From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/11] qspinlock, kvm: Add paravirt support
Date: Sun, 22 Jun 2014 22:06:18 +0530
Message-ID: <53A70602.8020000@linux.vnet.ibm.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130154.400698797@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140615130154.400698797@chello.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, scott.norton@hp.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On 06/15/2014 06:17 PM, Peter Zijlstra wrote:
> Signed-off-by: Peter Zijlstra<peterz@infradead.org>
> ---
[...]
> +
> +void kvm_wait(int *ptr, int val)
> +{
> +	unsigned long flags;
> +
> +	if (in_nmi())
> +		return;
> +
> +	/*
> +	 * Make sure an interrupt handler can't upset things in a
> +	 * partially setup state.
> +	 */

I am seeing hang with even 2 cpu guest (with patches on top of 3.15-rc6 ).
looking further with gdb I see one cpu is stuck with native_halt with
slowpath flag(_Q_LOCKED_SLOW) set when it was called.

(gdb) bt
#0  native_halt () at /test/master/arch/x86/include/asm/irqflags.h:55
#1  0xffffffff81033118 in halt (ptr=0xffffffff81eb0e58, val=524291) at 
/test/master/arch/x86/include/asm/paravirt.h:116
#2  kvm_wait (ptr=0xffffffff81eb0e58, val=524291) at 
arch/x86/kernel/kvm.c:835
#3  kvm_wait (ptr=0xffffffff81eb0e58, val=524291) at 
arch/x86/kernel/kvm.c:809
#4  0xffffffff810a2d8e in pv_wait (lock=0xffffffff81eb0e58) at 
/test/master/arch/x86/include/asm/paravirt.h:744
#5  __pv_wait_head (lock=0xffffffff81eb0e58) at 
kernel/locking/qspinlock.c:352

Value of lock seem to be 524288 (means already unlocked?)
So apart from races Waiman mentioned, are we also in need of smp_mb()
here and/or native_queue_unlock()?.

Interestingly I see other cpu stuck at multi_cpu_stop().

(gdb) thr 1
[Switching to thread 1 (Thread 1)]#0  multi_cpu_stop 
(data=0xffff8802140d1da0) at kernel/stop_machine.c:192
192			if (msdata->state != curstate) {

Or is it I am missing something.

please let me know if .config need to be shared.

> +	local_irq_save(flags);
> +
> +	/*
> +	 * check again make sure it didn't become free while
> +	 * we weren't looking.
> +	 */
> +	if (ACCESS_ONCE(*ptr) != val)
> +		goto out;
> +
> +	/*
> +	 * halt until it's our turn and kicked. Note that we do safe halt
> +	 * for irq enabled case to avoid hang when lock info is overwritten
> +	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
> +	 */
> +	if (arch_irqs_disabled_flags(flags))
> +		halt();
> +	else
> +		safe_halt();
> +
> +out:
> +	local_irq_restore(flags);
> +}
> +#endif /* QUEUE_SPINLOCK */
