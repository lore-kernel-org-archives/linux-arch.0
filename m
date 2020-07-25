From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
Date: Fri, 24 Jul 2020 23:02:58 -0400
Message-ID: <ccf0c6a6-b7c3-8909-cc8f-0c5e7434c372@redhat.com>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
 <20200724081647.GA16642@willie-the-truck>
 <8532332b-85dd-661b-cf72-81a8ceb70747@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <8532332b-85dd-661b-cf72-81a8ceb70747@redhat.com>
Content-Language: en-US
Sender: kvm-ppc-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, peterz@infradead.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 7/24/20 3:10 PM, Waiman Long wrote:
> On 7/24/20 4:16 AM, Will Deacon wrote:
>> On Thu, Jul 23, 2020 at 08:47:59PM +0200, peterz@infradead.org wrote:
>>> On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
>>>> BTW, do you have any comment on my v2 lock holder cpu info 
>>>> qspinlock patch?
>>>> I will have to update the patch to fix the reported 0-day test 
>>>> problem, but
>>>> I want to collect other feedback before sending out v3.
>>> I want to say I hate it all, it adds instructions to a path we spend an
>>> aweful lot of time optimizing without really getting anything back for
>>> it.
>>>
>>> Will, how do you feel about it?
>> I can see it potentially being useful for debugging, but I hate the
>> limitation to 256 CPUs. Even arm64 is hitting that now.
>
> After thinking more about that, I think we can use all the remaining 
> bits in the 16-bit locked_pending. Reserving 1 bit for locked and 1 
> bit for pending, there are 14 bits left. So as long as NR_CPUS < 16k 
> (requirement for 16-bit locked_pending), we can put all possible cpu 
> numbers into the lock. We can also just use smp_processor_id() without 
> additional percpu data. 

Sorry, that doesn't work. The extra bits in the pending byte won't get 
cleared on unlock. That will have noticeable performance impact. 
Clearing the pending byte on unlock will cause other performance 
problem. So I guess we will have to limit the cpu number in the locked byte.

Regards,
Longman
