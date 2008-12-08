From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Mon, 08 Dec 2008 15:41:57 +0100
Message-ID: <87k5aan2yy.fsf@basil.nowhere.org>
References: <20081208012211.GA23106@elte.hu>
	<18748.37739.383961.318233@drongo.ozlabs.ibm.com>
	<20081208113318.GA14723@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34762 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbYLHOlq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Dec 2008 09:41:46 -0500
In-Reply-To: <20081208113318.GA14723@elte.hu> (Ingo Molnar's message of "Mon, 8 Dec 2008 12:33:18 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

Ingo Molnar <mingo@elte.hu> writes:

> This means that the only correct technical/mathematical argument is to 
> talk about "levels of noise" and how they compare and correlate - and 
> i've seen no actual measurements or estimations pro or contra. Group 
> readout of counters can reduce noise for sure, but it is wrong for you to 
> try to turn this into some sort of all-or-nothing property. Other sources 
> of noise tend to be of much higher of magnitude.

Ingo, could you please describe how PEBS and IBS fit into your model?

Thanks.

-Andi

-- 
ak@linux.intel.com
