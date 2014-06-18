From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 10/11] qspinlock: Paravirt support
Date: Wed, 18 Jun 2014 11:26:51 -0400
Message-ID: <53A1AFBB.7090800@hp.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130154.213923590@chello.nl> <539F6AD5.4070301@hp.com>
	<53A18000.8080909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53A18000.8080909@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, gleb@redhat.com, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On 06/18/2014 08:03 AM, Paolo Bonzini wrote:
> Il 17/06/2014 00:08, Waiman Long ha scritto:
>>> +void __pv_queue_unlock(struct qspinlock *lock)
>>> +{
>>> +    int val = atomic_read(&lock->val);
>>> +
>>> +    native_queue_unlock(lock);
>>> +
>>> +    if (val & _Q_LOCKED_SLOW)
>>> +        ___pv_kick_head(lock);
>>> +}
>>> +
>>
>> Again a race can happen here between the reading and writing of the lock
>> value. I can't think of a good way to do that without using cmpxchg.
>
> Could you just use xchg on the locked byte?
>
> Paolo

The slowpath flag is just an indication that the queue head cpu might 
have been suspended. It may not be due to spurious wakeup. Releasing the 
lock unconditionally may cause the queue to be changed while it is being 
inspected. It really depending on how the cpu kicking is being handled. 
My patch delays the unlocking until all the inspections had been done to 
make sure that we don't waste time doing a cpu kick that is not needed.

-Longman
