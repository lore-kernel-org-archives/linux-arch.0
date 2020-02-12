Return-Path: <SRS0=bqXs=4A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgBLJno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:44 -0500
Message-ID: <20200212093210.468391728@infradead.org>
Date: Wed, 12 Feb 2020 10:32:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/8] tracing vs rcu vs nmi
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200212093210.3uwg_bho3F396iYDkGbL0SB0HsCgcQ73xniKQWln9RU@z>

Hi all,

These here patches are the result of Mathieu and Steve trying to get commit
865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
tracepoints") reverted again.

One of the things discovered is that tracing MUST NOT happen before nmi_enter()
or after nmi_exit(). I've only fixed x86, but quickly gone through other
architectures and there is definitely more stuff to be fixed (simply grep for
nmi_enter in your arch).
