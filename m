Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:23925 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbbGQRRO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2015 13:17:14 -0400
Received: from g2t2352.austin.hp.com (g2t2352.austin.hp.com [15.217.128.51])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id E98D84B7D
	for <linux-arch@vger.kernel.org>; Fri, 17 Jul 2015 17:17:13 +0000 (UTC)
Message-ID: <55A93896.3090905@hp.com>
Date: Fri, 17 Jul 2015 13:17:10 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] ARM: atomics: define our SMP atomics in terms
 of _relaxed operations
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com> <1437060758-10381-8-git-send-email-will.deacon@arm.com> <55A816A3.1000502@hp.com> <20150716210821.GC19282@twins.programming.kicks-ass.net> <55A845A2.20507@hp.com> <20150717093555.GC18994@arm.com>
In-Reply-To: <20150717093555.GC18994@arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Message-ID: <20150717171710.AcPpSG-ZhqwGk-FpEucPi883DeG5q7qROQO6_L2gvL0@z>

On 07/17/2015 05:35 AM, Will Deacon wrote:
> On Fri, Jul 17, 2015 at 01:00:34AM +0100, Waiman Long wrote:
>> On 07/16/2015 05:08 PM, Peter Zijlstra wrote:
>>> On Thu, Jul 16, 2015 at 04:40:03PM -0400, Waiman Long wrote:
>>>> On 07/16/2015 11:32 AM, Will Deacon wrote:
>>>>> @@ -117,6 +115,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>>>>>    #error "SMP is not supported on this platform"
>>>                ^^^^^^^^^^^^^
>> That #error is only for ARMv5 or below.
>>
>>>>>    #endif
>>>>>
>>>>> +#define xchg xchg_relaxed
>>>> Is that a typo? I think xchg() needs to be a full memory barrier.
>>> Pointless on UP.
> I don't see the problem here. As Peter pointed out, this code only gets
> looked at if !SMP and structuring it this way means I can have one
> definition of xchg_relaxed, regardless of architecture version.
>
> Will

I am sorry that I got confused as to where it is defined. It should be 
OK in this case.

Cheers,
Longman
