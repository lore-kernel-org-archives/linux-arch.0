From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 3/4] MCS Lock: Barrier corrections
Date: Wed, 06 Nov 2013 12:05:13 -0500
Message-ID: <527A76C9.1030208@hp.com>
References: <cover.1383670202.git.tim.c.chen@linux.intel.com> <1383673356.11046.279.camel@schen9-DESK> <20131105183744.GJ26895@mudshark.cambridge.arm.com> <1383679317.11046.293.camel@schen9-DESK> <CAF7GXvra3U_MqeJOUztdK7ggCSJcMZxJHuYtHJ4jRqNv2ZCY7Q@mail.gmail.com> <20131106122019.GG21074@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131106122019.GG21074@mudshark.cambridge.arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Figo.zhang" <figo1802@gmail.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On 11/06/2013 07:20 AM, Will Deacon wrote:
> On Wed, Nov 06, 2013 at 05:44:42AM +0000, Figo.zhang wrote:
>> 2013/11/6 Tim Chen<tim.c.chen@linux.intel.com<mailto:tim.c.chen@linux.intel.com>>
>> On Tue, 2013-11-05 at 18:37 +0000, Will Deacon wrote:
>>> On Tue, Nov 05, 2013 at 05:42:36PM +0000, Tim Chen wrote:
>>>> diff --git a/include/linux/mcs_spinlock.h b/include/linux/mcs_spinlock.h
>>>> index 96f14299..93d445d 100644
>>>> --- a/include/linux/mcs_spinlock.h
>>>> +++ b/include/linux/mcs_spinlock.h
>>>> @@ -36,16 +36,19 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
>>>>      node->locked = 0;
>>>>      node->next   = NULL;
>>>>
>>>> +   /* xchg() provides a memory barrier */
>>>>      prev = xchg(lock, node);
>>>>      if (likely(prev == NULL)) {
>>>>              /* Lock acquired */
>>>>              return;
>>>>      }
>>>>      ACCESS_ONCE(prev->next) = node;
>>>> -   smp_wmb();
>>>>      /* Wait until the lock holder passes the lock down */
>>>>      while (!ACCESS_ONCE(node->locked))
>>>>              arch_mutex_cpu_relax();
>>>> +
>>>> +   /* Make sure subsequent operations happen after the lock is acquired */
>>>> +   smp_rmb();
>>> Ok, so this is an smp_rmb() because we assume that stores aren't speculated,
>>> right? (i.e. the control dependency above is enough for stores to be ordered
>>> with respect to taking the lock)...
>>>
>>>>   }
>>>>
>>>>   /*
>>>> @@ -58,6 +61,7 @@ static void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *nod
>>>>
>>>>      if (likely(!next)) {
>>>>              /*
>>>> +            * cmpxchg() provides a memory barrier.
>>>>               * Release the lock by setting it to NULL
>>>>               */
>>>>              if (likely(cmpxchg(lock, node, NULL) == node))
>>>> @@ -65,9 +69,14 @@ static void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *nod
>>>>              /* Wait until the next pointer is set */
>>>>              while (!(next = ACCESS_ONCE(node->next)))
>>>>                      arch_mutex_cpu_relax();
>>>> +   } else {
>>>> +           /*
>>>> +            * Make sure all operations within the critical section
>>>> +            * happen before the lock is released.
>>>> +            */
>>>> +           smp_wmb();
>>> ...but I don't see what prevents reads inside the critical section from
>>> moving across the smp_wmb() here.
>> This is to prevent any read in next critical section from
>> creeping up before write in the previous critical section
>> has completed
> Understood, but an smp_wmb() doesn't provide any ordering guarantees with
> respect to reads, hence why I think you need an smp_mb() here.

A major reason for the current design is to avoid overhead of a full 
memory barrier in x86 which doesn't need that. I do agree that the 
current code may not be enough for other architectures. I would like to 
propose that the following changes:

1) Move the lock/unlock functions to mcs_spinlock.c.
2) Define a set of primitives - smp_mb__before_critical_section(), 
smp_mb_after_critical_section() that will fall back to smp_mb() if they 
are not defined in asm/processor.h, for example.
3) Use the new primitives instead of the current smp_rmb() and smp_wmb() 
memory barrier.

That will allow each architecture to tailor what sort of memory barrier 
do they want to use.

Regards,
Longman

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
