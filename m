From: Peter Zijlstra <peterz@infradead.org>
Subject: current_thread_info() vs task_thread_info(current)
Date: Mon, 18 Jul 2011 13:23:03 +0200
Message-ID: <1310988183.13765.56.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50638 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1GRLX0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2011 07:23:26 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@us.ibm.com>

Thomas just spend a lovely morning trying to make sense of a trace where
TIF_NEED_RESCHED wasn't set after resched_task() and magically appeared
after local_bh_enable().

What happened is that on that particular platform softirqs ran on a
separate stack, and current_thread_info() is relative to the stack
pointer.

The result is that current_thread_info() isn't the same as
task_thread_info(current), *surprise*!!

The immediate problem is of course that we can loose TIF flags when set
through current_thread_info() from IRQ/SoftIRQ context.

Now I was going to add a WARN() in x86_64's current_thread_info() to
catch all these, sadly x86_64's implementation isn't prone to this
particular issue, which means most people (kernel devs) will not be
affected (i386 is affected, but nobody sane uses that anymore).


Just to give an example, RCU uses set_need_resched(), set_need_resched()
uses current_thread_info(). The use in force_quiescent_state() is from
softirq afaict, the one in __rcu_pending() is from hardirq.

On such platforms as Thomas was playing on, the TIF bit will be lost,
since it will be set on the thread_info associated with some interrupt
stack, not the current process.


So how are we going to solve this? Naively I'd think that
current_thread_info() is short for task_thread_info(current), and thus
the platforms for where this isn't true are broken.

I mean, what use is the thread_info not of a thread?

Comments?
