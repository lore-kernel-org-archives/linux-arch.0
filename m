From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 07/19] qspinlock: Use a simple write to grab the lock,
	if applicable
Date: Fri, 09 May 2014 21:06:08 -0400
Message-ID: <536D7B80.7080301@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-8-git-send-email-Waiman.Long@hp.com>
	<20140508190203.GP2844@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140508190203.GP2844@laptop.programming.kicks-ass.net>
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

On 05/08/2014 03:02 PM, Peter Zijlstra wrote:
> On Wed, May 07, 2014 at 11:01:35AM -0400, Waiman Long wrote:
>>   /**
>> + * get_qlock - Set the lock bit and own the lock
>> + * @lock: Pointer to queue spinlock structure
>> + *
>> + * This routine should only be called when the caller is the only one
>> + * entitled to acquire the lock.
>> + */
>> +static __always_inline void get_qlock(struct qspinlock *lock)
> set_locked()
>
>> +{
>> +	struct __qspinlock *l = (void *)lock;
>> +
>> +	barrier();
>> +	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
>> +	barrier();
>> +}
> get_qlock() is just horrible. The function doesn't actually _get_
> anything, and qlock is not in line with the rest of the naming.

Sure, I will make the change.

-Longman
