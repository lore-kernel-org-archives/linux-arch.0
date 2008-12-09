From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Tue, 09 Dec 2008 11:35:01 -0600
Message-ID: <493EAC45.4050704@nortel.com>
References: <20081208012211.GA23106@elte.hu>	 <7c86c4470812082237ne58c814s7218cc663f3b49e9@mail.gmail.com>	 <20081209134636.GA1926@elte.hu> <87a5b0800812090846h396523a0kdb2d1ca4b4781851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zcars04f.nortel.com ([47.129.242.57]:65169 "EHLO
	zcars04f.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbYLIRfj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 12:35:39 -0500
In-Reply-To: <87a5b0800812090846h396523a0kdb2d1ca4b4781851@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, eranian@gmail.com, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

Will Newton wrote:
> On Tue, Dec 9, 2008 at 1:46 PM, Ingo Molnar <mingo@elte.hu> wrote:
> 
>> Firstly, sampling "at 1msec intervals" or any fixed period is a _very_
>> wrong mindset - and cross-sampling counters is a similarly wrong mindset.
> 
> If your hardware does not interrupt on overflow I don't think you have
> any choice in the matter. I know such hardware is less than ideal but
> it exists so it should be supported.

I think you could still set up the counters as Ingo describes and then 
sample the counters (as opposed to the program) at a suitable interval 
(chosen such that the counters won't overflow more than once between 
samples).

Chris
