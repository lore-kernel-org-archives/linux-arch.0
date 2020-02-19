Return-Path: <SRS0=LzcT=4H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgBSPOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:36 -0500
Message-ID: <20200219144724.800607165@infradead.org>
Date: Wed, 19 Feb 2020 15:47:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 00/22] tracing vs world
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Message-ID: <20200219144724.vKmy1xoUcXgEmwgsmQkbG45EVj_tiFPy1ehnht5H7Ac@z>

Hi all,


These here patches are the result of Mathieu and Steve trying to get commit
865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
tracepoints") reverted again.

One of the things discovered is that tracing MUST NOT happen before nmi_enter()
or after nmi_exit(). Audit results of the previous version are still valid.

This then snowballed into auditing other exceptions, notably #MC, and #BP. Lots
of patches came out of that.

I would love for some tooling in this area. Dan, smatch has full callchains
right? Would it be possible to have an __assert_no_tracing__() marker of sorts
that validates that no possible callchain reaching that assertion has hit
tracing before that point?

It would mean you have to handle the various means of 'notrace' annotation
(both the function attribute as well as the Makefile rules), recognising
tracepoints and ideally handling NOKPROBE annotations.

Changes since -v2:

 - #MC / ist_enter() audit -- first 4 patches. After this in_nmi() should
   always be set 'correctly'.
 - RCU IRQ enter/exit function simplification
 - #BP / poke_int3_handler() audit -- last many patches.
 - pulled in some locking/kcsan patches

Changes since -v1:

 - Added tags
 - Changed #4; changed nmi_enter() to use __preempt_count_add() vs
   marking preempt_count_add() notrace.
 - Changed #5; confusion on which functions are notrace due to Makefile
 - Added #9; remove limitation on the perf-function-trace coupling
