From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 7/7] ARM: atomics: define our SMP atomics in terms
 of _relaxed operations
Date: Thu, 16 Jul 2015 20:00:34 -0400
Message-ID: <55A845A2.20507@hp.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com> <1437060758-10381-8-git-send-email-will.deacon@arm.com> <55A816A3.1000502@hp.com> <20150716210821.GC19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:55777 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbbGQAAh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 20:00:37 -0400
In-Reply-To: <20150716210821.GC19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On 07/16/2015 05:08 PM, Peter Zijlstra wrote:
> On Thu, Jul 16, 2015 at 04:40:03PM -0400, Waiman Long wrote:
>> On 07/16/2015 11:32 AM, Will Deacon wrote:
>>> @@ -117,6 +115,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>>>   #error "SMP is not supported on this platform"
>               ^^^^^^^^^^^^^

That #error is only for ARMv5 or below.

>>>   #endif
>>>
>>> +#define xchg xchg_relaxed
>> Is that a typo? I think xchg() needs to be a full memory barrier.
> Pointless on UP.
