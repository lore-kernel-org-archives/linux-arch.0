From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v5 5/8] pvqspinlock, x86: Enable unfair queue spinlock
	in a KVM guest
Date: Thu, 27 Feb 2014 14:05:48 -0500
Message-ID: <530F8C8C.2030906@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-6-git-send-email-Waiman.Long@hp.com>
	<530F0832.50205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F0832.50205@redhat.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/27/2014 04:41 AM, Paolo Bonzini wrote:
> Il 26/02/2014 16:14, Waiman Long ha scritto:
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
> I think this should apply to all paravirt implementations, unless 
> pv_lock_ops.kick_cpu != NULL.
>
> Paolo

Unfair lock is currently implemented as an independent config option 
that can be turned on or off irrespective of the other PV settings. 
There are concern about lock starvation if there is a large number of 
virtual CPUs. So one idea that I have is to disable this feature if 
there is more than a certain number of virtual CPUs available. I will 
investigate this idea when I have time.

-Longman
