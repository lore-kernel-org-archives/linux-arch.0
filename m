From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/11] qspinlock: Add pending bit
Date: Wed, 18 Jun 2014 13:29:48 +0200
Message-ID: <53A1782C.7040400@redhat.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.196728583@chello.nl>
	<20140617203615.GA29634@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140617203615.GA29634@laptop.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Il 17/06/2014 22:36, Konrad Rzeszutek Wilk ha scritto:
> +	/* One more attempt - but if we fail mark it as pending. */
> +	if (val == _Q_LOCKED_VAL) {
> +		new = Q_LOCKED_VAL |_Q_PENDING_VAL;
> +
> +		old = atomic_cmpxchg(&lock->val, val, new);
> +		if (old == _Q_LOCKED_VAL) /* YEEY! */
> +			return;
> +		val = old;
> +	}

Note that Peter's code is in a for(;;) loop:


+	for (;;) {
+		/*
+		 * If we observe any contention; queue.
+		 */
+		if (val & ~_Q_LOCKED_MASK)
+			goto queue;
+
+		new = _Q_LOCKED_VAL;
+		if (val == new)
+			new |= _Q_PENDING_VAL;
+
+		old = atomic_cmpxchg(&lock->val, val, new);
+		if (old == val)
+			break;
+
+		val = old;
+	}
+
+	/*
+	 * we won the trylock
+	 */
+	if (new == _Q_LOCKED_VAL)
+		return;

So what you'd have is basically:

	/*
	 * One more attempt if no one is already in queue.  Perhaps
	 * they have unlocked the spinlock already.
	 */
	if (val == _Q_LOCKED_VAL && atomic_read(&lock->val) == 0) {
		old = atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL);
		if (old == 0) /* YEEY! */
			return;
		val = old;
	}

But I agree with Waiman that this is unlikely to trigger often enough. 
It does have to be handled in the slowpath for correctness, but the most 
likely path is (0,0,1)->(0,1,1).

Paolo
