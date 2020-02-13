From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 13 Feb 2020 18:55:59 -0500
Message-ID: <20200213185559.65e9f520@oasis.local.home>
References: <20200212210749.971717428@infradead.org>
        <20200212232005.GC115917@google.com>
        <20200213082716.GI14897@hirez.programming.kicks-ass.net>
        <20200213135138.GB2935@paulmck-ThinkPad-P72>
        <20200213164031.GH14914@hirez.programming.kicks-ass.net>
        <20200213185612.GG2935@paulmck-ThinkPad-P72>
        <20200213204444.GA94647@google.com>
        <20200213205442.GK2935@paulmck-ThinkPad-P72>
        <20200213211930.GG170680@google.com>
        <20200213214859.GL2935@paulmck-ThinkPad-P72>
        <20200213225853.GB112239@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBMX4C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 18:56:02 -0500
In-Reply-To: <20200213225853.GB112239@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Thu, 13 Feb 2020 17:58:53 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> Oh ok, it was a fair question. Seems Steve nailed it, only the
> rcu_nmi_enter() needs NOKPROBE, although as you mentioned in the other
> thread, it would be good to get Masami's eyes on it since he introduced the
> NOKPROBE.

Note, I did go and verify that the issue still exists, and the NOKPROBE
looks to still be needed. But as you stated, because Masami added the
NOKPROBE I'd feel more comfortable with him looking over my explanation.

-- Steve
