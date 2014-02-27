From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v5 8/8] pvqspinlock, x86: Enable KVM to use qspinlock's
	PV support
Date: Thu, 27 Feb 2014 13:36:00 -0500
Message-ID: <530F8590.60207@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-9-git-send-email-Waiman.Long@hp.com>
	<530F0607.1020705@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F0607.1020705@redhat.com>
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

On 02/27/2014 04:31 AM, Paolo Bonzini wrote:
>   static __init int kvm_spinlock_init_jump(void)
> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> index f185584..a70fdeb 100644
> --- a/kernel/Kconfig.locks
> +++ b/kernel/Kconfig.locks
> @@ -229,4 +229,4 @@ config ARCH_USE_QUEUE_SPINLOCK
>
>   config QUEUE_SPINLOCK
>   	def_bool y if ARCH_USE_QUEUE_SPINLOCK
> -	depends on SMP&&  !PARAVIRT_SPINLOCKS
> +	depends on SMP&&  (!PARAVIRT_SPINLOCKS || !XEN)
>
> Should this rather be
>
>      def_bool y if ARCH_USE_QUEUE_SPINLOCK&&  (!PARAVIRT_SPINLOCKS || !XEN)
>
> ?
>
> PARAVIRT_SPINLOCKS + XEN + QUEUE_SPINLOCK + PARAVIRT_UNFAIR_LOCKS is a
> valid combination, but it's impossible to choose PARAVIRT_UNFAIR_LOCKS
> if QUEUE_SPINLOCK is unavailable.
>
> Paolo

The PV ticketlock code assumes the presence of ticket spinlock. So it 
will cause compilation error if QUEUE_SPINLOCK is enabled. My patches 
7/8 modified the KVM code so that the PV ticketlock code can coexist 
with queue spinlock. As I haven't figure out the proper way to modify 
the Xen code, I need to disable the queue spinlock code if 
PARAVIRT_SPINLOCKS and XEN are both enabled. However, by disabling 
PARAVIRT_SPINLOCKS, we can use PARAVIRT_UNFAIR_LOCKS with XEN.

-Longman
