From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/9] tracing vs rcu vs nmi
Date: Wed, 12 Feb 2020 22:01:39 +0100
Message-ID: <20200212210139.382424693@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgBLVOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:08 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

Hi all,

These here patches are the result of Mathieu and Steve trying to get commit
865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
tracepoints") reverted again.

One of the things discovered is that tracing MUST NOT happen before nmi_enter()
or after nmi_exit(). Audit results of the previous version are still valid.

Changes since -v1:

 - Added tags
 - Changed #4; changed nmi_enter() to use __preempt_count_add() vs
   marking preempt_count_add() notrace.
 - Changed #5; confusion on which functions are notrace due to Makefile
 - Added #9; remove limitation on the perf-function-trace coupling
