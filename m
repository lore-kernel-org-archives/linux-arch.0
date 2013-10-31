Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:62438 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3JaFp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 01:45:57 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arch: *: remove '__init' for setup_profiling_timer()
Date: Thu, 31 Oct 2013 05:45:48 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075153861@IN01WEMBXA.internal.synopsys.com>
References: <52672ECD.9010800@asianux.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, realmz paranoid <realmz6@gmail.com>, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Parisc List <linux-parisc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20131031054548.H1pwlabhOPByOiPDAjnUidA4n1MjvtLevBCgW8PDi2E@z>

On 10/23/2013 07:36 AM, Chen Gang wrote:
> Most of architectures not use '__init' for setup_profiling_timer(), so
> need remove it, or can generate warning (e.g. arc with allmodconfig):
>
>     MODPOST vmlinux.o
>   WARNING: vmlinux.o(.text+0x3c682): Section mismatch in reference from the function write_profile() to the function .init.text:setup_profiling_timer()
>   The function write_profile() references
>   the function __init setup_profiling_timer().
>   This is often because write_profile lacks a __init
>   annotation or the annotation of setup_profiling_timer is wrong.
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arc/kernel/smp.c          |    2 +-
>  arch/blackfin/mach-bf561/smp.c |    2 +-
>  arch/parisc/kernel/smp.c       |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
> index bca3052..3bdac11 100644
> --- a/arch/arc/kernel/smp.c
> +++ b/arch/arc/kernel/smp.c
> @@ -187,7 +187,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  /*
>   * not supported here
>   */
> -int __init setup_profiling_timer(unsigned int multiplier)
> +int setup_profiling_timer(unsigned int multiplier)
>  {
>  	return -EINVAL;
>  }
> diff --git a/arch/blackfin/mach-bf561/smp.c b/arch/blackfin/mach-bf561/smp.c
> index 11789be..3bef058 100644
> --- a/arch/blackfin/mach-bf561/smp.c
> +++ b/arch/blackfin/mach-bf561/smp.c
> @@ -43,7 +43,7 @@ void __init platform_prepare_cpus(unsigned int max_cpus)
>  	init_cpu_present(&mask);
>  }
>  
> -int __init setup_profiling_timer(unsigned int multiplier) /* not supported */
> +int setup_profiling_timer(unsigned int multiplier) /* not supported */
>  {
>  	return -EINVAL;
>  }
> diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
> index 8a252f2..2e8cd36 100644
> --- a/arch/parisc/kernel/smp.c
> +++ b/arch/parisc/kernel/smp.c
> @@ -433,7 +433,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  }
>  
>  #ifdef CONFIG_PROC_FS
> -int __init
> +int
>  setup_profiling_timer(unsigned int multiplier)
>  {
>  	return -EINVAL;

In theory this change is OK. However this is legacy code at best and it would be
better to define a weak definition in kernel/profile.c and remove this cruft from
relevant arches. I'll send out a patch.

-Vineet
