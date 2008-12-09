From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Tue, 9 Dec 2008 12:02:46 +0100
Message-ID: <20081209110246.GC21618@elte.hu>
References: <20081208012211.GA23106@elte.hu> <7c86c4470812082237ne58c814s7218cc663f3b49e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:59466 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbYLILDQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Dec 2008 06:03:16 -0500
Content-Disposition: inline
In-Reply-To: <7c86c4470812082237ne58c814s7218cc663f3b49e9@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: eranian@gmail.com
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>


* stephane eranian <eranian@googlemail.com> wrote:

> > There's also more generic x86 support: all 4 generic PMCs of Nehalem 
> > / Core i7 are supported - i've run 4 instances of KernelTop and they 
> > used up four separate PMCs.
>
> Core/Atom have 5 counters, Nehalem has 7. Why are you not using all of 
> them already?

no, Nehalem has 4 generic purpose PMCs and 3 fixed-purpose PMCs (7 
total), Core/Atom has 2 generic PMCs and 3 fixed-purpose PMCs (5 total). 
Saying that it has 7 is misleading. (and even the generic PMCs have 
constraints)

	Ingo
