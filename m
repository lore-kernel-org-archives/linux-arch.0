From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Sat, 06 Dec 2008 13:34:39 +0100
Message-ID: <1228566879.16244.4.camel@lappy.programming.kicks-ass.net>
References: <20081204225345.654705757@linutronix.de>
	 <18744.29747.728320.652642@cargo.ozlabs.ibm.com>
	 <20081205063131.GB12785@elte.hu>
	 <18744.56857.259756.129894@cargo.ozlabs.ibm.com>
	 <20081205080813.GA2030@elte.hu>
	 <18744.61429.548462.667020@cargo.ozlabs.ibm.com>
	 <20081205120734.GA26244@elte.hu>
	 <18745.49593.567217.277510@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60316 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589AbYLFMfC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 6 Dec 2008 07:35:02 -0500
In-Reply-To: <18745.49593.567217.277510@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

On Sat, 2008-12-06 at 11:05 +1100, Paul Mackerras wrote:
> Now, the tables in perfmon's user-land libpfm that describe the
> mapping from abstract events to event-selector values and the
> constraints on what events can be counted together come to nearly
> 29,000 lines of code just for the IBM 64-bit powerpc processors.
> 
> Your API condemns us to adding all that bloat to the kernel, plus the
> code to use those tables.

Since you need those tables and that code anyway, and in a solid
reliable way, what is the objection of carrying it in the kernel?

Furthermore, is there a good technical reason these cpus are so
complicated to use?
