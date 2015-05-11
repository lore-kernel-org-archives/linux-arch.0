From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 00/21] Re-introduce h8300 architecture
Date: Mon, 11 May 2015 21:04:30 +0200
Message-ID: <16018199.XO2Ye1J7R2@wuerfel>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp> <20150511175027.GA31125@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150511175027.GA31125@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 11 May 2015 10:50:27 Guenter Roeck wrote:
> On Mon, May 11, 2015 at 03:26:19PM +0900, Yoshinori Sato wrote:
> > Changes for v12
> > - IRQ chip convert to OF
> > - dts cleanup
> > - some headers use generic
> > - rebase to v4.1-rc3
> > 
> Configurations in arch/h8300/configs shtill build ok.
> 
> make allmodoconfig, after fixing the spi build error, results in
> 
> ERROR: "csum_partial_copy_nocheck" [net/ipv6/ipv6.ko] undefined!
> ERROR: "ip_compute_csum" [net/ipv6/ip6_gre.ko] undefined!
> ERROR: "ip_fast_csum" [net/ipv4/xfrm4_mode_beet.ko] undefined!
> ERROR: "ip_compute_csum" [net/bridge/bridge.ko] undefined!
> ERROR: "ip_fast_csum" [net/bridge/bridge.ko] undefined!
> ERROR: "ip_fast_csum" [net/bridge/br_netfilter.ko] undefined!
> ERROR: "ip_fast_csum" [net/atm/mpoa.ko] undefined!
> ERROR: "__ucmpdi2" [fs/btrfs/btrfs.ko] undefined!
> ERROR: "ip_compute_csum" [drivers/scsi/scsi_debug.ko] undefined!
> ERROR: "ip_fast_csum" [drivers/net/slip/slhc.ko] undefined!
> ERROR: "__ucmpdi2" [drivers/md/bcache/bcache.ko] undefined!
> ERROR: "__ucmpdi2" [drivers/iio/imu/inv_mpu6050/inv-mpu6050.ko] undefined!
> 
> csum_partial_copy_nocheck, ip_compute_csum, and ip_fast_csum need to be exported
> from arch/h8300/lib/checksum.c.

Interesting. From what I can see, the  arch/h8300/lib/checksum.c file
contains a completely generic implementation of the IP checksum code.
That should not be necessary at all, and is more likely to lead to
subtle errors like the one you see here.

It would be better to do one of two things:

a) use the code from lib/checksum.c that is known to work well, and that
   contains all the necessary exports. It seems that the h8300 is
   almost an except copy of the generic code, it just misses a few
   improvements that were done already in the kernel.

b) provide an optimized implementation written in assembly where necessary.
   This can provide a significant performance improvement for TCP/IP
   networking.

> No idea what to do about the missing __ucmpdi2
> symbol, or what causes it.

This is a libgcc symbol provided by arch/h8300/lib/ucmpdi2.c in patch
15. The other similar functions are written in assembly and exported
from arch/h8300/kernel/h8300_ksyms.c, while this one is written in C
and missing the export. It should be added in the file that defines
the function.

	Arnd
