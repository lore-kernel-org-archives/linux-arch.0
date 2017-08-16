From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v9 3/5] cris: mark _stext and _end as char-arrays,
 not single char
Date: Wed, 16 Aug 2017 20:01:33 +0900
Message-ID: <20170816200133.1abbd36d5b5621f6f4b7f639@kernel.org>
References: <150172762859.27216.16741726568669538542.stgit@devbox>
        <150172782555.27216.2805751327900543374.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbdHPLBo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Aug 2017 07:01:44 -0400
In-Reply-To: <150172782555.27216.2805751327900543374.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Francis Deslauriers <francis.deslauriers@efficios.com>, mathieu.desnoyers@efficios.com, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, linux-arch@vger.kernel.org

On Thu,  3 Aug 2017 11:37:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

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

BTW, I would like to ask cris people, this seems to check over 1 byte,
since _etext and module_end will be placed at the next byte of the real
address area.
As same as other arch, Should it be 

(addr < (unsigned long)_etext)

or are there any other reason?

Thank you,


>  #ifdef CONFIG_KALLSYMS
>  			print_ip_sym(addr);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
