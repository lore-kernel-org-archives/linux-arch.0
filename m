From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 0/3] sysfs: add sysfs based cpuinfo
Date: Fri, 6 Dec 2019 16:58:03 +0000
Message-ID: <20191206165803.GD21671@lakrids.cambridge.arm.com>
References: <20191206162421.15050-1-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191206162421.15050-1-trenn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org, fschnitzlein@suse.de
List-Id: linux-arch.vger.kernel.org

Hi Thomas,

On Fri, Dec 06, 2019 at 05:24:18PM +0100, Thomas Renninger wrote:
> I picked up Felix Schnizlein's work from 2017.
> 
> It was already reviewed by Greg-KH at this time and even
> pushed into linux-next tree, when it came out that the mails
> never reached lkml, even the list was added to CC.
> 
> ARM people then correctly complained that this needs more review
> by ARCH people. It got reverted, Felix had no time anymore and this
> nice patcheset was hanging around nowhere...

Can you please provide a rationale for this?

It's not entirely clear to me what information people need or want, and
there's some data in /proc/cpuinfo that I think makes no sense to try to
export export in a structured way (e.g. bogomips).

> 
> Tested on aarch64:
> 
> /sys/devices/system/cpu/cpu1/info/:[0]# ls
> architecture  bogomips  flags  implementer  part  revision  variant
> 
> ------------------------------------------------------------
> 
> for file in *;do echo $file; cat $file;echo;done
> architecture
> 8
> 
> bogomips
> 40.00
> 
> flags
> fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> 
> implementer
> 0x51
> 
> part
> 0xc00
> 
> revision
> 1
> 
> variant
> 0x0
 
For arm64 we already expose the MIDR and REVIDR register values under
/sys/devices/system/cpu/cpu*/regs/identification, and that's the bulk of
the useful information above (aside from the flags/hwcaps).

Thanks,
Mark.
