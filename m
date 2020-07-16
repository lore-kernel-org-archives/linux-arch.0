From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] linux: arm: vdso: nullpatch vdso_clock_gettime64 for
 non-virtual timers
Date: Thu, 16 Jul 2020 19:46:17 +0100
Message-ID: <ac44a5a3-ca35-cd0a-f823-4b814c01c498@arm.com>
References: <20200716150723.9389-1-knaerzche@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgGPSqV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 14:46:21 -0400
In-Reply-To: <20200716150723.9389-1-knaerzche@gmail.com>
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Bee <knaerzche@gmail.com>, linux-arch@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Vlastimil Babka <vbabka@suse.cz>

Hi Alex,

On 2020-07-16 16:07, Alex Bee wrote:
> Along with commit commit 74d06efb9c2f ("ARM: 8932/1: Add clock_gettime64
> entry point") clock_gettime64 was added for ARM platform to solve the
> y2k38 problem on 32-bit platforms. glibc from version 2.31 onwards
> started using this vdso-call on ARM platforms.
> However it was (probably) forgotten to "nullpatch" this call, when no
> reliable timer source is available, for example when
> "arm,cpu-registers-not-fw-configured" is defined in devicetree for
> "arm,armv7-timer".
> This results in erratic time jumps whenever "gettimeofday" gets called,
> since the (non-working) vdso-call will be used instead of a syscall.
> 
> This patch adds clock_gettime64 to get nullpatched as well. It has been
> verified to work and solve this issue on Rockchip RK322x, RK3288 and
> RPi4 (32-bit kernel build) platforms.

FYI, a version of this patch was already submitted, and is just waiting 
for Russell to apply it:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8987/1

Robin.

> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>   arch/arm/kernel/vdso.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> index 6bfdca4769a7..fddd08a6e063 100644
> --- a/arch/arm/kernel/vdso.c
> +++ b/arch/arm/kernel/vdso.c
> @@ -184,6 +184,7 @@ static void __init patch_vdso(void *ehdr)
>   	if (!cntvct_ok) {
>   		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
>   		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
> +		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
>   	}
>   }
>   
> 
