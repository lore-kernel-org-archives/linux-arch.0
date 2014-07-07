From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/11] qspinlock: Optimize for smaller NR_CPUS
Date: Mon, 07 Jul 2014 17:08:17 +0200
Message-ID: <53BAB7E1.4010506@redhat.com>
References: <20140615124657.264658593@chello.nl> <20140615130153.483502389@chello.nl> <53A17A88.7090705@redhat.com> <20140707143503.GS6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140707143503.GS6758@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, gleb@redhat.com, scott.norton@hp.com, chegu_vinod@hp.com
List-Id: linux-arch.vger.kernel.org

Il 07/07/2014 16:35, Peter Zijlstra ha scritto:
> On Wed, Jun 18, 2014 at 01:39:52PM +0200, Paolo Bonzini wrote:
>> Il 15/06/2014 14:47, Peter Zijlstra ha scritto:
>>>
>>> -	for (;;) {
>>> -		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
>>> -
>>> -		old = atomic_cmpxchg(&lock->val, val, new);
>>> -		if (old == val)
>>> -			break;
>>> -
>>> -		val = old;
>>> -	}
>>> +	clear_pending_set_locked(lock, val);
>>> 	return;
>>
>>
>> Might as well add clear_pending_set_locked already in patch 3.
>
> Patch 4, if anywhere.
>

This code is added in patch 3:

+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * *,1,0 -> *,0,1
+	 */
+	for (;;) {
+		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
+
+		old = atomic_cmpxchg(&lock->val, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+	return;

Unlike the change in patch 4, clear_pending_set_locked doesn't change 
how qspinlock moves from a state to the next.

Paolo
