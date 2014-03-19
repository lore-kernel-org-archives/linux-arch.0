From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v7 07/11] pvqspinlock, x86: Allow unfair queue spinlock
	in a XEN guest
Date: Wed, 19 Mar 2014 16:28:14 -0400
Message-ID: <20140319202814.GB11210@phenom.dumpdata.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
	<1395260049-30839-8-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1395260049-30839-8-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 19, 2014 at 04:14:05PM -0400, Waiman Long wrote:
> This patch adds a XEN init function to activate the unfair queue
> spinlock in a XEN guest when the PARAVIRT_UNFAIR_LOCKS kernel config
> option is selected.
> 
> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> ---
>  arch/x86/xen/setup.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
> index 0982233..66bb6f5 100644
> --- a/arch/x86/xen/setup.c
> +++ b/arch/x86/xen/setup.c
> @@ -625,3 +625,22 @@ void __init xen_arch_setup(void)
>  	numa_off = 1;
>  #endif
>  }
> +
> +#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
> +/*
> + * Enable unfair lock if running in a Xen guest
> + */
> +static __init int xen_unfair_locks_init_jump(void)
> +{
> +	/*
> +	 * Disable unfair lock if not running in a PV domain
> +	 */
> +	if (!xen_pv_domain())
> +		return 0;

I would just make this 'xen_domain'. Not sure why you need
to have it only for PV while the PVHVM guests can also use it?

Would it also make sense to use the same printk statement
that the KVM has?
> +
> +	static_key_slow_inc(&paravirt_unfairlocks_enabled);
> +
> +	return 0;
> +}
> +early_initcall(xen_unfair_locks_init_jump);
> +#endif
> -- 
> 1.7.1
> 
