From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 00/27] tracing vs world
Date: Fri, 21 Feb 2020 14:34:16 +0100
Message-ID: <20200221133416.777099322@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:56360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgBUNud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:33 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

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

NOTE:
  patches 19,20,21 already live in tip/locking/kcsan and are included
  here because 20,21 are needed for the patches following to make sense.
  If/when this gets merged, we need to figure out how to resolve this.

Changes since -v3:

 - Replaced the #DF patch with one from Boris
 - Moved trace_rcu_{enter,exit}() into rcupdate.h
 - Flipped TIF_SIGPENDING and TIF_NOTIFY_RESUME handling
 - Added comment to nmi_enter()
 - fixed various compile fails
 - inlined bsearch()
 - Added lockdep checking for USED <- IN-NMI recursion
 - Added rcu_nmi_enter vs kprobes comment

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
