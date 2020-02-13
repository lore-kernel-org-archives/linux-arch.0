From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Date: Thu, 13 Feb 2020 09:25:08 -0500
Message-ID: <CAEXW_YSddXU++o7xpi-0kzg9GA6UkM5FsnoXjLQ=gAFBjPf=RA@mail.gmail.com>
References: <20200212210139.382424693@infradead.org> <20200212210749.915180520@infradead.org>
 <20200212223818.GA115917@google.com> <20200212204128.20f5e8ba@oasis.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44886 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgBMOZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 09:25:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so5768715qkb.11
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 06:25:20 -0800 (PST)
In-Reply-To: <20200212204128.20f5e8ba@oasis.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Thomas Glexiner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>

On Wed, Feb 12, 2020 at 8:41 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 12 Feb 2020 17:38:18 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > I think there are ways to turn off function inlining, such as gcc's:
> > -fkeep-inline-functions
> >
> > And just to be sure weird compilers (clang *cough*) don't screw this up,
> > could we make it static inline notrace?
>
> inline is defined as notrace, so not needed.
>
> I did that because of surprises when functions marked as inline
> suddenly became non inlined and traced, which caused issues with
> function tracing (before I finally got recursion protection working).
> But even then, I figured, if something is inlined and gcc actually
> inlines it, it wont be traced. For consistency, if something is marked
> inline, it should not be traced.

Ah I see it, thanks for the clarification Steve! That looks like a
good idea. I withdraw my previous comment.

- Joel
