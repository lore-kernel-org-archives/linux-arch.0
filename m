From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 09/27] rcu: Rename rcu_irq_{enter,exit}_irqson()
Date: Wed, 26 Feb 2020 01:35:51 +0100
Message-ID: <20200226003550.GE9599@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.559644596@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZAfy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Feb 2020 19:35:54 -0500
Content-Disposition: inline
In-Reply-To: <20200221134215.559644596@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, Feb 21, 2020 at 02:34:25PM +0100, Peter Zijlstra wrote:
> The functions do in fact use local_irq_{save,restore}() and can
> therefore be used when IRQs are in fact disabled. Worse, they are
> already used in places where IRQs are disabled, leading to great
> confusion when reading the code.
> 
> Rename them to fix this confusion.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

FWIW I'd have called that _irqsafe() as irqsave() suggests some return
value to later restore.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
