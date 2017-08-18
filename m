From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH -tip v9 3/5] cris: mark _stext and _end as char-arrays,
 not single char
Date: Fri, 18 Aug 2017 20:38:27 +0200
Message-ID: <20170818183827.GF16480@axis.com>
References: <150172762859.27216.16741726568669538542.stgit@devbox>
 <150172782555.27216.2805751327900543374.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:52556 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdHRSib (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 14:38:31 -0400
Content-Disposition: inline
In-Reply-To: <150172782555.27216.2805751327900543374.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Francis Deslauriers <francis.deslauriers@efficios.com>, mathieu.desnoyers@efficios.com, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, linux-cris-kernel@axis.com, linux-arch@vger.kernel.org


On Thu, Aug 03, 2017 at 11:37:15AM +0900, Masami Hiramatsu wrote:
> Mark _stext and _end as character arrays instead of single
> character, as same as include/asm-generic/sections.h does.

Looks good.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/cris/arch-v32/mach-a3/arbiter.c |    4 ++--
>  arch/cris/arch-v32/mach-fs/arbiter.c |    4 ++--
>  arch/cris/kernel/traps.c             |    6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/cris/arch-v32/mach-a3/arbiter.c b/arch/cris/arch-v32/mach-a3/arbiter.c
> index ab5c421a4de8..735a9b0abdb8 100644
> --- a/arch/cris/arch-v32/mach-a3/arbiter.c
> +++ b/arch/cris/arch-v32/mach-a3/arbiter.c
> @@ -227,7 +227,7 @@ static void crisv32_arbiter_config(int arbiter, int region, int unused_slots)
>  	}
>  }
>  
> -extern char _stext, _etext;
> +extern char _stext[], _etext[];
>  
>  static void crisv32_arbiter_init(void)
>  {
> @@ -265,7 +265,7 @@ static void crisv32_arbiter_init(void)
>  
>  #ifndef CONFIG_ETRAX_KGDB
>  	/* Global watch for writes to kernel text segment. */
> -	crisv32_arbiter_watch(virt_to_phys(&_stext), &_etext - &_stext,
> +	crisv32_arbiter_watch(virt_to_phys(_stext), _etext - _stext,
>  		MARB_CLIENTS(arbiter_all_clients, arbiter_bar_all_clients),
>  			      arbiter_all_write, NULL);
>  #endif
> diff --git a/arch/cris/arch-v32/mach-fs/arbiter.c b/arch/cris/arch-v32/mach-fs/arbiter.c
> index c97f4d8120f9..047c70bdbb23 100644
> --- a/arch/cris/arch-v32/mach-fs/arbiter.c
> +++ b/arch/cris/arch-v32/mach-fs/arbiter.c
> @@ -158,7 +158,7 @@ static void crisv32_arbiter_config(int region, int unused_slots)
>  	}
>  }
>  
> -extern char _stext, _etext;
> +extern char _stext[], _etext[];
>  
>  static void crisv32_arbiter_init(void)
>  {
> @@ -190,7 +190,7 @@ static void crisv32_arbiter_init(void)
>  
>  #ifndef CONFIG_ETRAX_KGDB
>  	/* Global watch for writes to kernel text segment. */
> -	crisv32_arbiter_watch(virt_to_phys(&_stext), &_etext - &_stext,
> +	crisv32_arbiter_watch(virt_to_phys(_stext), _etext - _stext,
>  			      arbiter_all_clients, arbiter_all_write, NULL);
>  #endif
>  }
> diff --git a/arch/cris/kernel/traps.c b/arch/cris/kernel/traps.c
> index a01636a12a6e..d98131c45bb5 100644
> --- a/arch/cris/kernel/traps.c
> +++ b/arch/cris/kernel/traps.c
> @@ -42,7 +42,7 @@ void (*nmi_handler)(struct pt_regs *);
>  void show_trace(unsigned long *stack)
>  {
>  	unsigned long addr, module_start, module_end;
> -	extern char _stext, _etext;
> +	extern char _stext[], _etext[];
>  	int i;
>  
>  	pr_err("\nCall Trace: ");
> @@ -69,8 +69,8 @@ void show_trace(unsigned long *stack)
>  		 * down the cause of the crash will be able to figure
>  		 * out the call path that was taken.
>  		 */
> -		if (((addr >= (unsigned long)&_stext) &&
> -		     (addr <= (unsigned long)&_etext)) ||
> +		if (((addr >= (unsigned long)_stext) &&
> +		     (addr <= (unsigned long)_etext)) ||
>  		    ((addr >= module_start) && (addr <= module_end))) {
>  #ifdef CONFIG_KALLSYMS
>  			print_ip_sym(addr);

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
