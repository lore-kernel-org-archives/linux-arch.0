From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/11] qspinlock: Paravirt support
Date: Wed, 18 Jun 2014 14:03:12 +0200
Message-ID: <53A18000.8080909@redhat.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130154.213923590@chello.nl> <539F6AD5.4070301@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539F6AD5.4070301@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Il 17/06/2014 00:08, Waiman Long ha scritto:
>> +void __pv_queue_unlock(struct qspinlock *lock)
>> +{
>> +	int val = atomic_read(&lock->val);
>> +
>> +	native_queue_unlock(lock);
>> +
>> +	if (val & _Q_LOCKED_SLOW)
>> +		___pv_kick_head(lock);
>> +}
>> +
>
> Again a race can happen here between the reading and writing of the lock
> value. I can't think of a good way to do that without using cmpxchg.

Could you just use xchg on the locked byte?

Paolo
