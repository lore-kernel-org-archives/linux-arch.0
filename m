From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 05 Dec 2008 09:03:36 +0100
Message-ID: <1228464216.18899.18.camel@twins>
References: <20081204225345.654705757@linutronix.de>
	 <18744.29747.728320.652642@cargo.ozlabs.ibm.com>
	 <20081205063131.GB12785@elte.hu> <20081205070329.GA30874@elte.hu>
	 <1228461385.18899.13.camel@twins>
	 <18744.57057.243817.407691@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:42792 "EHLO
	viefep18-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYLEIDr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2008 03:03:47 -0500
In-Reply-To: <18744.57057.243817.407691@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

On Fri, 2008-12-05 at 18:57 +1100, Paul Mackerras wrote:
> Peter Zijlstra writes:
> 
> > So, while most people would not consider two consecutive read() ops to
> > be close or near the same time, due to preemption and such, that is
> > taken away by the fact that the counters are task local time based - so
> > preemption doesn't affect thing. Right?
> 
> I'm sorry, I don't follow the argument here.  What do you mean by
> "task local time based"?

time only flows when the task is running.
