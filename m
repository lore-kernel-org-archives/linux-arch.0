From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 06/19] qspinlock: prolong the stay in the pending
	bit path
Date: Fri, 09 May 2014 20:58:47 -0400
Message-ID: <536D79C7.2000701@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-7-git-send-email-Waiman.Long@hp.com>
	<20140508185854.GN2844@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140508185854.GN2844@laptop.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 05/08/2014 02:58 PM, Peter Zijlstra wrote:
> On Wed, May 07, 2014 at 11:01:34AM -0400, Waiman Long wrote:
>> @@ -221,11 +222,37 @@ static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
>>   	 */
>>   	for (;;) {
>>   		/*
>> -		 * If we observe any contention; queue.
>> +		 * If we observe that the queue is not empty,
>> +		 * return and be queued.
>>   		 */
>> -		if (val&  ~_Q_LOCKED_MASK)
>> +		if (val&  _Q_TAIL_MASK)
>>   			return 0;
>>
>> +		if (val == (_Q_LOCKED_VAL|_Q_PENDING_VAL)) {
>> +			/*
>> +			 * If both the lock and pending bits are set, we wait
>> +			 * a while to see if that either bit will be cleared.
>> +			 * If that is no change, we return and be queued.
>> +			 */
>> +			if (!retry)
>> +				return 0;
>> +			retry--;
>> +			cpu_relax();
>> +			cpu_relax();
>> +			*pval = val = atomic_read(&lock->val);
>> +			continue;
>> +		} else if (val == _Q_PENDING_VAL) {
>> +			/*
>> +			 * Pending bit is set, but not the lock bit.
>> +			 * Assuming that the pending bit holder is going to
>> +			 * set the lock bit and clear the pending bit soon,
>> +			 * it is better to wait than to exit at this point.
>> +			 */
>> +			cpu_relax();
>> +			*pval = val = atomic_read(&lock->val);
>> +			continue;
>> +		}
> Didn't I give a much saner alternative to this mess last time?

I don't recall you have any suggestion last time. Anyway, if you think 
the code is too messy, I think I can give up the first if statement 
which is more an optimistic spinning kind of code for short critical 
section. The 2nd if statement is still need to improve chance of using 
this code path due to timing reason. I will rerun my performance test to 
make sure it won't have too much performance impact.

-Longman
