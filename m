From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v7 06/11] pvqspinlock, x86: Allow unfair queue spinlock
	in a KVM guest
Date: Fri, 21 Mar 2014 17:27:36 -0400
Message-ID: <532CAEC8.6080105@hp.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
	<1395260049-30839-7-git-send-email-Waiman.Long@hp.com>
	<532B6543.7050707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <532B6543.7050707@redhat.com>
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

On 03/20/2014 06:01 PM, Paolo Bonzini wrote:
> Il 19/03/2014 21:14, Waiman Long ha scritto:
>> This patch adds a KVM init function to activate the unfair queue
>> spinlock in a KVM guest when the PARAVIRT_UNFAIR_LOCKS kernel config
>> option is selected.
>>
>> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
>> ---
>>  arch/x86/kernel/kvm.c |   17 +++++++++++++++++
>>  1 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index 713f1b3..a489140 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -826,3 +826,20 @@ static __init int kvm_spinlock_init_jump(void)
>>  early_initcall(kvm_spinlock_init_jump);
>>
>>  #endif    /* CONFIG_PARAVIRT_SPINLOCKS */
>> +
>> +#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
>> +/*
>> + * Enable unfair lock if running in a real para-virtualized environment
>> + */
>> +static __init int kvm_unfair_locks_init_jump(void)
>> +{
>> +    if (!kvm_para_available())
>> +        return 0;
>> +
>> +    static_key_slow_inc(&paravirt_unfairlocks_enabled);
>> +    printk(KERN_INFO "KVM setup unfair spinlock\n");
>> +
>> +    return 0;
>> +}
>> +early_initcall(kvm_unfair_locks_init_jump);
>> +#endif
>>
>
> No!  Please do what I asked you to do.  You are not handling Hyper-V 
> or VMWare.  Just use X86_FEATURE_HYPERVISOR and it will cover all 
> hypervisors that actually follow Intel's guidelines.
>
> Paolo

OK, I can modify the patch to use X86_FEATURE_HYPERVISOR.

-Longman
