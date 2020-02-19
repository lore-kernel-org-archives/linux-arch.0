From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date: Wed, 19 Feb 2020 09:21:48 -0800
Message-ID: <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
References: <20200219144724.800607165@infradead.org> <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRWC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:22:02 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6113A24677
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 17:22:01 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id p9so1555339wmc.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 09:22:01 -0800 (PST)
In-Reply-To: <20200219171309.GC32346@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andrew Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Wed, Feb 19, 2020 at 9:13 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 19, 2020 at 03:47:26PM +0100, Peter Zijlstra wrote:
> > Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
>
> x86/mce: ...
>
> > It is an abomination; and in prepration of removing the whole
> > ist_enter() thing, it needs to go.
> >
> > Convert #MC over to using task_work_add() instead; it will run the
> > same code slightly later, on the return to user path of the same
> > exception.
>
> That's fine because the error happened in userspace.

Unless there is a signal pending and the signal setup code is about to
hit the same failed memory.  I suppose we can just treat cases like
this as "oh well, time to kill the whole system".

But we should genuinely agree that we're okay with deferring this handling.
