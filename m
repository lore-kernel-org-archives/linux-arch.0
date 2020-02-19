From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date: Wed, 19 Feb 2020 18:13:09 +0100
Message-ID: <20200219171309.GC32346@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:57462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRNQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:13:16 -0500
Content-Disposition: inline
In-Reply-To: <20200219150744.488895196@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 03:47:26PM +0100, Peter Zijlstra wrote:
> Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()

x86/mce: ...

> It is an abomination; and in prepration of removing the whole
> ist_enter() thing, it needs to go.
> 
> Convert #MC over to using task_work_add() instead; it will run the
> same code slightly later, on the return to user path of the same
> exception.

That's fine because the error happened in userspace.

...

> @@ -1202,6 +1186,29 @@ static void __mc_scan_banks(struct mce *
>  	*m = *final;
>  }
>  
> +static void mce_kill_me_now(struct callback_head *ch)
> +{
> +	force_sig(SIGBUS);
> +}
> +
> +static void mce_kill_me_maybe(struct callback_head *cb)

You don't even need the "mce_" prefixes - those are static functions and
in mce-land.

Change looks good otherwise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
