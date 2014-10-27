From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v12 09/11] pvqspinlock,
	x86: Add para-virtualization support
Date: Mon, 27 Oct 2014 16:50:42 -0400
Message-ID: <544EB022.4070801@hp.com>
References: <1413483040-58399-1-git-send-email-Waiman.Long@hp.com>
	<1413483040-58399-10-git-send-email-Waiman.Long@hp.com>
	<20141024084738.GU21513@worktop.programming.kicks-ass.net>
	<544ABC47.2000700@hp.com>
	<20141024220423.GB10501@worktop.programming.kicks-ass.net>
	<544E7DC9.5020903@hp.com>
	<20141027172719.GK3337@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141027172719.GK3337@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On 10/27/2014 01:27 PM, Peter Zijlstra wrote:
> On Mon, Oct 27, 2014 at 01:15:53PM -0400, Waiman Long wrote:
>> On 10/24/2014 06:04 PM, Peter Zijlstra wrote:
>>> On Fri, Oct 24, 2014 at 04:53:27PM -0400, Waiman Long wrote:
>>>> The additional register pressure may just cause a few more register moves
>>>> which should be negligible in the overall performance . The additional
>>>> icache pressure, however, may have some impact on performance. I was trying
>>>> to balance the performance of the pv and non-pv versions so that we won't
>>>> penalize the pv code too much for a bit more performance in the non-pv code.
>>>> Doing it your way will add a lot of function call and register
>>>> saving/restoring to the pv code.
>>> If people care about performance they should not be using virt crap :-)
>>>
>>> I only really care about bare metal.
>> Yes, I am aware of that. However, the whole point of doing PV spinlock is to
>> improve performance in a virtual guest.
> Anything that avoids the lock holder preemption nonsense is a _massive_
> win for them, a few function calls should not even register on that
> scale.

I would say all the PV stuffs are mostly useful for a over-committed 
guest where a single CPU is shared in more than one guest. When the 
guests are not overcommitted, the PV code seldom get triggered. In those 
cases, the overhead of the extra function call and register 
saving/restoring will show up.

>> +#ifdef _GEN_PV_LOCK_SLOWPATH
>> +static void pv_queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>> +#else
>>   void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>> +#endif
> If you have two functions you might as well use the PV stuff to patch in
> the right function call at the usage sites and avoid:
>
>> +       if (pv_enabled()) {
>> +               pv_queue_spin_lock_slowpath(lock, val);
>> +               return;
>> +       }
> this alltogether.

Good point! I will do some investigation on how to do this kind of 
function address patching and eliminate the extra function call overhead.

>>          this_cpu_dec(mcs_nodes[0].count);
>>   }
>>   EXPORT_SYMBOL(queue_spin_lock_slowpath);
>> +
>> +#if !defined(_GEN_PV_LOCK_SLOWPATH)&&  defined(CONFIG_PARAVIRT_SPINLOCKS)
>> +/*
>> + * Generate the PV version of the queue_spin_lock_slowpath function
>> + */
>> +#undef pv_init_node
>> +#undef pv_wait_check
>> +#undef pv_link_and_wait_node
>> +#undef pv_wait_head
>> +#undef EXPORT_SYMBOL
>> +#undef in_pv_code
>> +
>> +#define _GEN_PV_LOCK_SLOWPATH
>> +#define EXPORT_SYMBOL(x)
>> +#define in_pv_code     return_true
>> +#define pv_enabled     return_false
>> +
>> +#include "qspinlock.c"
>> +
>> +#endif
> That's properly disgusting :-) But a lot better than actually
> duplicating everything I suppose.

I know you don't like this kind of preprocessor trick, but this is the 
easiest way that I can think of to generate two separate functions from 
the same source code.

-Longman
