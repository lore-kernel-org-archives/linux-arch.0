Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388535AbfDRL20 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 07:28:26 -0400
Date: Thu, 18 Apr 2019 12:28:18 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] The patch solves =?utf-8?Q?the?=
 =?utf-8?Q?_type_error__of_the_parameter_=E2=80=9Coff?= =?utf-8?B?4oCd?= in
 syscall mmap on the ARM64 platform.
Message-ID: <20190418112818.GA31923@lakrids.cambridge.arm.com>
References: <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555504525-17962-1-git-send-email-zhouby_cn@126.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boyang Zhou <zhouby_cn@126.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, haozhu@nudt.edu.cn, linux@dominikbrodowski.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Message-ID: <20190418112818.OGwkv0ST_ssO3AgFeJ5tG4cVv-mYqy1Q2czISfyHuAk@z>

[adding linux-arch and relevant folk]

On Wed, Apr 17, 2019 at 08:35:25PM +0800, Boyang Zhou wrote:
> The error information is that “offset value too large for defined data type”.
> Reason:
> On the X86 platform, the data type of “off" is unsigned long; but on the ARM64 platform, the data type is defined as off_t, and off_t is by type long instead of unsigned long.
> When the off right shifts in the function “sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT)"on ARM64, high address of off is filled with sign bit 1instead of 0.
> In our case, we mmap GPU doorbell on both platform. On the x86 platform, the value of off is f009c00000000000, after shift the value becomes f009c00000000; while on the ARM64, the value of off changes from ed35c00000000000 to fffed35c00000000. This value is treated as unsigned long in later functions. So it is too big for off and the error happened.
> We have tested the patchs in Huawei ARM64 server with a couples of AMD GPUs.

It looks like the generic mmap uses unsigned long, as do sparc and x86.

However, arm64, microblase, powerpc and riscv all use off_t.

Should those all be using unsigned long? If so, that seems like it
should be a treewide cleanup.

Similar applies to pgoff for mmap2.

Thanks,
Mark.

> 
> Signed-off-by: Boyang Zhou <zhouby_cn@126.com>
> ---
>  arch/arm64/kernel/sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index b44065f..6f91e81 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -31,7 +31,7 @@
>  
>  SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>  		unsigned long, prot, unsigned long, flags,
> -		unsigned long, fd, off_t, off)
> +		unsigned long, fd, unsigned long, off)
>  {
>  	if (offset_in_page(off) != 0)
>  		return -EINVAL;
> -- 
> 2.7.4
> 
