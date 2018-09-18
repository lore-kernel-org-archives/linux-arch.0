Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:07:35 -0400
Date: Tue, 18 Sep 2018 22:33:15 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 08/20] signal/x86/traps: Move setting error_code
 and trap_nr into do_trap_no_signal
In-Reply-To: <20180918000546.12552-8-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182228350.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918203315.ptdeqqAIFvEv71u0jEruSi5jz2O5FT6uOKlAjaRE5Dc@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Half of the times when error_code and trap_nr are set are already in

s/when// I think

> do_trap_no_signal.  Move the other time these are set into do_trap_no_signal,

Please write function as do_trap_no_signal() so it's more obvious what you
are talking about.

> and give do_trap_no_signal a single exit where a signals are sent.

s/a/// or s/a/all/ Not sure what you wanted to do here.

> After the move the comment documeting this all is much easier to follow
> as everything is together in one place.
> 
> Also update the string that is passed in to const.  The only user of that
> str is die and it already takes a const string, so this just makes it explicit

string

> that the string won't change.
> 
> This prepares the way for adding a second caller to do_trap_no_signal.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/x86/kernel/traps.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 31a689b67be3..f31c0ddee278 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -189,7 +189,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
>  }
>  
>  static nokprobe_inline int
> -do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
> +do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
>  		  struct pt_regs *regs,	long error_code)
>  {
>  	if (v8086_mode(regs)) {
> @@ -202,10 +202,8 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
>  						error_code, trapnr))
>  				return 0;
>  		}
> -		return -1;
>  	}
> -
> -	if (!user_mode(regs)) {
> +	else if (!user_mode(regs)) {

Please put that 'else if' right after the closing bracket, i.e.

	} else if (...) {

>  		if (fixup_exception(regs, trapnr))
>  			return 0;

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
