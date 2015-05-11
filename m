From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v12 00/21] Re-introduce h8300 architecture
Date: Mon, 11 May 2015 10:50:27 -0700
Message-ID: <20150511175027.GA31125@roeck-us.net>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, May 11, 2015 at 03:26:19PM +0900, Yoshinori Sato wrote:
> Changes for v12
> - IRQ chip convert to OF
> - dts cleanup
> - some headers use generic
> - rebase to v4.1-rc3
> 
Configurations in arch/h8300/configs shtill build ok.

make allmodoconfig, after fixing the spi build error, results in

ERROR: "csum_partial_copy_nocheck" [net/ipv6/ipv6.ko] undefined!
ERROR: "ip_compute_csum" [net/ipv6/ip6_gre.ko] undefined!
ERROR: "ip_fast_csum" [net/ipv4/xfrm4_mode_beet.ko] undefined!
ERROR: "ip_compute_csum" [net/bridge/bridge.ko] undefined!
ERROR: "ip_fast_csum" [net/bridge/bridge.ko] undefined!
ERROR: "ip_fast_csum" [net/bridge/br_netfilter.ko] undefined!
ERROR: "ip_fast_csum" [net/atm/mpoa.ko] undefined!
ERROR: "__ucmpdi2" [fs/btrfs/btrfs.ko] undefined!
ERROR: "ip_compute_csum" [drivers/scsi/scsi_debug.ko] undefined!
ERROR: "ip_fast_csum" [drivers/net/slip/slhc.ko] undefined!
ERROR: "__ucmpdi2" [drivers/md/bcache/bcache.ko] undefined!
ERROR: "__ucmpdi2" [drivers/iio/imu/inv_mpu6050/inv-mpu6050.ko] undefined!

csum_partial_copy_nocheck, ip_compute_csum, and ip_fast_csum need to be exported
from arch/h8300/lib/checksum.c. No idea what to do about the missing __ucmpdi2
symbol, or what causes it.

Guenter
