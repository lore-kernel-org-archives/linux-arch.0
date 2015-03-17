Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47366 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbbCQISP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Mar 2015 04:18:15 -0400
Date: Tue, 17 Mar 2015 09:18:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 tip/core/rcu 01/22] smpboot: Add common code for
 notification from dying CPU
Message-ID: <20150317081807.GQ2896@worktop.programming.kicks-ass.net>
References: <20150316183743.GA21453@linux.vnet.ibm.com>
 <1426531086-23825-1-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426531086-23825-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, laijs@cn.fujitsu.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, dvhart@linux.intel.com, fweisbec@gmail.com, oleg@redhat.com, bobby.prani@gmail.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150317081807.WulhwJ413TujXHXyIPH2mBaULXM-mMag7v4ueEN2t4Y@z>

On Mon, Mar 16, 2015 at 11:37:45AM -0700, Paul E. McKenney wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> RCU ignores offlined CPUs, so they cannot safely run RCU read-side code.
> (They -can- use SRCU, but not RCU.)  This means that any use of RCU
> during or after the call to arch_cpu_idle_dead().  Unfortunately,
> commit 2ed53c0d6cc99 added a complete() call, which will contain RCU
> read-side critical sections if there is a task waiting to be awakened.

Got a little more detail there?
