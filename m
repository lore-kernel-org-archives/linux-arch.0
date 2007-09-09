Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:21725 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567AbXIIR15 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Sep 2007 13:27:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1274565wah
        for <linux-arch@vger.kernel.org>; Sun, 09 Sep 2007 10:27:57 -0700 (PDT)
Message-ID: <86802c440709091027o32a63d11w629bad87abcc19c2@mail.gmail.com>
Date: Sun, 9 Sep 2007 10:27:19 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [discuss] [patch 3/5] Use extended crashkernel command line on x86_64
In-Reply-To: <20070909083914.951336895@strauss.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070909083914.065380136@strauss.suse.de>
	 <20070909083914.951336895@strauss.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Bernhard Walle <bwalle@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@in.ibm.com>
Cc: kexec@lists.infradead.org, linux-arch@vger.kernel.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 9/9/07, Bernhard Walle <bwalle@suse.de> wrote:
> This patch removes the crashkernel parsing from
> arch/x86_64/kernel/machine_kexec.c and calls the generic function, introduced in
> the last patch, in setup_bootmem_allocator().
>
> This is necessary because the amount of System RAM must be known in this
> function now because of the new syntax.
>
>
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
>
>
> ---
>  arch/x86_64/kernel/e820.c          |    3 ++-
>  arch/x86_64/kernel/machine_kexec.c |   27 ---------------------------
>  arch/x86_64/kernel/setup.c         |   35 ++++++++++++++++++++++++++++-------
>  3 files changed, 30 insertions(+), 35 deletions(-)
>
> --- a/arch/x86_64/kernel/e820.c
> +++ b/arch/x86_64/kernel/e820.c
> @@ -226,7 +226,8 @@ void __init e820_reserve_resources(void)
>                         request_resource(res, &code_resource);
>                         request_resource(res, &data_resource);
>  #ifdef CONFIG_KEXEC
...
> --- a/arch/x86_64/kernel/machine_kexec.c
> +++ b/arch/x86_64/kernel/machine_kexec.c
> @@ -231,33 +231,6 @@ NORET_TYPE void machine_kexec(struct kim
>                         image->start);
>  }
>
> -/* crashkernel=size@addr specifies the location to reserve for
> - * a crash kernel.  By reserving this memory we guarantee
> - * that linux never set's it up as a DMA target.
> - * Useful for holding code to do something appropriate
> - * after a kernel panic.
> - */
> -static int __init setup_crashkernel(char *arg)
> -{
> -       unsigned long size, base;
> -       char *p;
> -       if (!arg)
> -               return -EINVAL;
> -       size = memparse(arg, &p);
> -       if (arg == p)
> -               return -EINVAL;
> -       if (*p == '@') {
> -               base = memparse(p+1, &p);
> -               /* FIXME: Do I want a sanity check to validate the
> -                * memory range?  Yes you do, but it's too early for
> -                * e820 -AK */
> -               crashk_res.start = base;
> -               crashk_res.end   = base + size - 1;
> -       }
> -       return 0;
> -}
> -early_param("crashkernel", setup_crashkernel);
> -
>  void arch_crash_save_vmcoreinfo(void)
>  {
>  #ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
> --- a/arch/x86_64/kernel/setup.c
> +++ b/arch/x86_64/kernel/setup.c
> @@ -196,6 +196,33 @@ static inline void copy_edd(void)
>  }
>  #endif
>
> +#ifdef CONFIG_KEXEC
...

CONFIG_KEXEC or CONFIG_CRASH_DUMP?

YH
