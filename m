From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [patch 00/18] SMP: Boot and CPU hotplug refactoring - Part 1
Date: Fri, 20 Apr 2012 18:04:08 -0700
Message-ID: <4F920788.3080405@am.sony.com>
References: <20120420122120.097464672@linutronix.de>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:52671
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444Ab2DUBEb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2012 21:04:31 -0400
In-Reply-To: <20120420122120.097464672@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On 04/20/12 06:05, Thomas Gleixner wrote:
> Dear all,
> 
> I'm working on refactoring the SMP boot and CPU hotplug implementation.

Smoke test #1 successful.  Builds and boots on ARM Panda for:

  linux-3.4-rc3       CONFIG_PREEMPT_NONE

  linux-3.4-rc3-rt5   CONFIG_PREEMPT_RT_FULL


-Frank
