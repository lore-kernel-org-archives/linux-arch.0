From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Wed, 10 Dec 2008 15:44:31 +1100
Message-ID: <18751.18735.539555.111549@drongo.ozlabs.ibm.com>
References: <20081208012211.GA23106@elte.hu>
	<7c86c4470812082237ne58c814s7218cc663f3b49e9@mail.gmail.com>
	<20081209134636.GA1926@elte.hu>
	<18750.61143.101922.949701@cargo.ozlabs.ibm.com>
	<87skoxc6qo.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:37626 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255AbYLJEou (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Dec 2008 23:44:50 -0500
In-Reply-To: <87skoxc6qo.fsf@basil.nowhere.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>, eranian@gmail.com, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

Andi Kleen writes:

> When you say counting you should also include "event ring buffers with
> metadata", like PEBS on Intel x86. 

I'm not familiar with PEBS.  Maybe it's something different again,
neither sampling nor counting, but a third thing?

Paul.
