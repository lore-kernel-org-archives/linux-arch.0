From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v6 10/11] pvqspinlock, x86: Enable qspinlock PV support
	for KVM
Date: Thu, 13 Mar 2014 15:13:31 -0400
Message-ID: <5322035B.5000205@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-11-git-send-email-Waiman.Long@hp.com>
	<5321B9BE.7050209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5321B9BE.7050209@redhat.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.
List-Id: linux-arch.vger.kernel.org

On 03/13/2014 09:59 AM, Paolo Bonzini wrote:
> Il 12/03/2014 19:54, Waiman Long ha scritto:
>> @@ -807,8 +889,13 @@ void __init kvm_spinlock_init(void)
>>      if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
>>          return;
>>
>> +#ifdef CONFIG_QUEUE_SPINLOCK
>> +    pv_lock_ops.kick_cpu = kvm_kick_cpu_type;
>> +    pv_lock_ops.hibernate = kvm_hibernate;
>> +#else
>>      pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
>>      pv_lock_ops.unlock_kick = kvm_unlock_kick;
>> +#endif
>
> This should also disable the unfair path.
>
> Paolo
>

The unfair lock uses a different jump label and does not require any 
special PV ops. There is a separate init function for that.

-Longman
