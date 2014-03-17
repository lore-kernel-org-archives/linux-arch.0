From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v6 04/11] qspinlock: Optimized code path for 2 contending
	tasks
Date: Mon, 17 Mar 2014 13:23:55 -0400
Message-ID: <53272FAB.3070204@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-5-git-send-email-Waiman.Long@hp.com>
	<5320B0A8.8030805@hp.com>
	<20140313135701.GB25546@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140313135701.GB25546@laptop.programming.kicks-ass.net>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu
List-Id: linux-arch.vger.kernel.org

On 03/13/2014 09:57 AM, Peter Zijlstra wrote:
> On Wed, Mar 12, 2014 at 03:08:24PM -0400, Waiman Long wrote:
>> On 03/12/2014 02:54 PM, Waiman Long wrote:
>>> +		/*
>>> +		 * Set the lock bit&   clear the waiting bit simultaneously
>>> +		 * It is assumed that there is no lock stealing with this
>>> +		 * quick path active.
>>> +		 *
>>> +		 * A direct memory store of _QSPINLOCK_LOCKED into the
>>> +		 * lock_wait field causes problem with the lockref code, e.g.
>>> +		 *   ACCESS_ONCE(qlock->lock_wait) = _QSPINLOCK_LOCKED;
>>> +		 *
>>> +		 * It is not currently clear why this happens. A workaround
>>> +		 * is to use atomic instruction to store the new value.
>>> +		 */
>>> +		{
>>> +			u16 lw = xchg(&qlock->lock_wait, _QSPINLOCK_LOCKED);
>>> +			BUG_ON(lw != _QSPINLOCK_WAITING);
>>> +		}
>> It was found that when I used a direct memory store instead of an atomic op,
>> the following kernel crash might happen at filesystem dismount time:
>>
>> [ 1529.936714] Call Trace:
>> [ 1529.936714]  [<ffffffff811c2d03>] d_walk+0xc3/0x260
>> [ 1529.936714]  [<ffffffff811c1770>] ? check_and_collect+0x30/0x30
>> [ 1529.936714]  [<ffffffff811c3985>] shrink_dcache_for_umount+0x75/0x120
>> [ 1529.936714]  [<ffffffff811adf21>] generic_shutdown_super+0x21/0xf0
>> [ 1529.936714]  [<ffffffff811ae207>] kill_block_super+0x27/0x70
>> [ 1529.936714]  [<ffffffff811ae4ed>] deactivate_locked_super+0x3d/0x60
>> [ 1529.936714]  [<ffffffff811aea96>] deactivate_super+0x46/0x60
>> [ 1529.936714]  [<ffffffff811ca277>] mntput_no_expire+0xa7/0x140
>> [ 1529.936714]  [<ffffffff811cb6ce>] SyS_umount+0x8e/0x100
>> [ 1529.936714]  [<ffffffff815d2c29>] system_call_fastpath+0x16/0x1b
>> It was more readily reproducible in a KVM guest. It was harder to reproduce
>> in a bare metal machine, but kernel crash still happened after several
>> tries.
>>
>> I am not sure what exactly cause this crash, but it will have something to
>> do with the interaction between the lockref and the qspinlock code. I would
>> like more eyes on that to find the root cause of it.
> I cannot reproduce with my series that has the one word write.
>
> What I did was I made my swap partition (who needs that anyway on a
> machine with 16G of memory) into an XFS partition.
>
> Then I copied my linux.git onto it and unmounted.
>
> I'll try a few more times; the above trace seems to suggest it happens
> during dcache cleanup, so I suppose I should read the filesystem some
> and unmount again.
>
> Is there anything specific you did to make it go bang?

I had found the reason for the crash, it has to do with my original 
definition of the queue_spin_value_unlocked() function. When I extended 
it to cover the first 2 bytes (lock + wait bit), the problem is gone.

-Longman
