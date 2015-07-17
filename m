From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 7/7] ARM: atomics: define our SMP atomics in terms
 of _relaxed operations
Date: Fri, 17 Jul 2015 13:17:10 -0400
Message-ID: <55A93896.3090905@hp.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com> <1437060758-10381-8-git-send-email-will.deacon@arm.com> <55A816A3.1000502@hp.com> <20150716210821.GC19282@twins.programming.kicks-ass.net> <55A845A2.20507@hp.com> <20150717093555.GC18994@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150717093555.GC18994@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

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
