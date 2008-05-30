From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 11:56:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301155380.16253@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com>  <1212138752.12349.227.camel@twins>
 <20080530091847.GA26563@elte.hu>  <Pine.LNX.4.64.0805301109120.14564@schroedinger.engr.sgi.com>
 <1212172834.24826.22.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:38642 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752019AbYE3S4n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 14:56:43 -0400
In-Reply-To: <1212172834.24826.22.camel@lappy.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Peter Zijlstra wrote:

> Yes, I get that, but for instance kmem_cache_cpu usage would require
> horrible long preempt off sections, hence we add a lock and manage
> consistency using that lock instead of strict per-cpu and preempt
> disable.

Really? Where is that horrible long preempt off section? I thought they 
were all short and we use semaphores when looping over all slabs.
