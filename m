From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Tue, 09 Dec 2008 13:51:36 -0600
Message-ID: <493ECC48.6060107@nortel.com>
References: <20081208012211.GA23106@elte.hu> <7c86c4470812082237ne58c814s7218cc663f3b49e9@mail.gmail.com> <20081209134636.GA1926@elte.hu> <493E9F3E.3020902@nortel.com> <20081209190254.GA27833@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zcars04e.nortel.com ([47.129.242.56]:57903 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbYLITwF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 14:52:05 -0500
In-Reply-To: <20081209190254.GA27833@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: eranian@gmail.com, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

Ingo Molnar wrote:
> * Chris Friesen <cfriesen@nortel.com> wrote:

>> Regardless of sampling method, don't you still want some way to 
>> enable/disable the various counters as close to simultaneously as 
>> possible?
> 
> If it's about counter control for the monitored task, then we sure could 
> do something about that. (apps/libraries could thus select a subset of 
> functions to profile/measure, runtime, etc.)
> 
> If it's about counter control for the profiler/debugger, i'm not sure how 
> useful that is - do you have a good usecase for it?

I'm sure that others could give more usecases, but I was thinking about 
cases like "I want to test _these_ multiple metrics simultaneously over 
_this_ specific section of code".  In a case like this, it seems 
desirable to start/stop the various performance counters as close 
together as possible, especially if the section of code being tested is 
short.

Chris
