From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Date: Wed, 12 Feb 2020 20:41:28 -0500
Message-ID: <20200212204128.20f5e8ba@oasis.local.home>
References: <20200212210139.382424693@infradead.org>
        <20200212210749.915180520@infradead.org>
        <20200212223818.GA115917@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbgBMBlb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 20:41:31 -0500
In-Reply-To: <20200212223818.GA115917@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, 12 Feb 2020 17:38:18 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> I think there are ways to turn off function inlining, such as gcc's:
> -fkeep-inline-functions
> 
> And just to be sure weird compilers (clang *cough*) don't screw this up,
> could we make it static inline notrace?

inline is defined as notrace, so not needed.

I did that because of surprises when functions marked as inline
suddenly became non inlined and traced, which caused issues with
function tracing (before I finally got recursion protection working).
But even then, I figured, if something is inlined and gcc actually
inlines it, it wont be traced. For consistency, if something is marked
inline, it should not be traced.

-- Steve
