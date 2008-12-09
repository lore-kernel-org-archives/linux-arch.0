From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Tue, 09 Dec 2008 23:40:31 +0100
Message-ID: <87skoxc6qo.fsf@basil.nowhere.org>
References: <20081208012211.GA23106@elte.hu>
	<7c86c4470812082237ne58c814s7218cc663f3b49e9@mail.gmail.com>
	<20081209134636.GA1926@elte.hu>
	<18750.61143.101922.949701@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:33010 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYLIWkO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 17:40:14 -0500
In-Reply-To: <18750.61143.101922.949701@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Wed, 10 Dec 2008 09:19:03 +1100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, eranian@gmail.com, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

Paul Mackerras <paulus@samba.org> writes:

> So, can we agree to discuss both sampling and counting, and design an
> infrastructure that's good for both?

When you say counting you should also include "event ring buffers with
metadata", like PEBS on Intel x86. 

-Andi

-- 
ak@linux.intel.com
