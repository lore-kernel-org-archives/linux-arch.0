From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC v6 10/11] pvqspinlock, x86: Enable qspinlock PV support
	for KVM
Date: Thu, 13 Mar 2014 14:59:26 +0100
Message-ID: <5321B9BE.7050209@redhat.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-11-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1394650498-30118-11-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Il 12/03/2014 19:54, Waiman Long ha scritto:
> @@ -807,8 +889,13 @@ void __init kvm_spinlock_init(void)
>  	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
>  		return;
>
> +#ifdef CONFIG_QUEUE_SPINLOCK
> +	pv_lock_ops.kick_cpu = kvm_kick_cpu_type;
> +	pv_lock_ops.hibernate = kvm_hibernate;
> +#else
>  	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
>  	pv_lock_ops.unlock_kick = kvm_unlock_kick;
> +#endif

This should also disable the unfair path.

Paolo
