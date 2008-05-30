From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 12:11:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301210350.16253@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com>  <1212138752.12349.227.camel@twins>
  <Pine.LNX.4.64.0805301106360.14564@schroedinger.engr.sgi.com>
 <1212172742.24826.19.camel@lappy.programming.kicks-ass.net>
 <Pine.LNX.4.64.0805301141260.16184@schroedinger.engr.sgi.com>
 <1212174001.24826.37.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:35290 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751318AbYE3TMA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 15:12:00 -0400
In-Reply-To: <1212174001.24826.37.camel@lappy.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Peter Zijlstra wrote:

> For -rt we'd need to make the CPU_ops true atomic operations, with that
> all the single word stuff works again.

Hmmmm.... Okay then this would just mean adding an #ifdef CONFIG_RT to
include/asm-x86/percpu.h.
 
> All the multi word stuff (that currently requires preempt-off) must be
> converted to a locked version.

How would the (now atomic) per cpu ops interact with the locks? I.e. you 
take the lock for the kmem_cache_cpu structure and then the fastpath tries 
to perform an atomic update on one of the variables therein?
