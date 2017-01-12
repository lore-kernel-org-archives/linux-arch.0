From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2] x86, locking/spinlocks: Remove
	paravirt_ticketlocks_enabled
Date: Thu, 12 Jan 2017 16:39:36 -0500
Message-ID: <76a962e4-14a9-74ab-6e6c-89fe3b8c1a1d@oracle.com>
References: <1484252878-1962-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1484252878-1962-1-git-send-email-longman@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>
List-Id: linux-arch.vger.kernel.org


> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
> index e8a9ea7..25a7c43 100644
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -141,25 +141,6 @@ void __init xen_init_spinlocks(void)
>  	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
>  }
>  
> -/*
> - * While the jump_label init code needs to happend _after_ the jump labels are
> - * enabled and before SMP is started. Hence we use pre-SMP initcall level
> - * init. We cannot do it in xen_init_spinlocks as that is done before
> - * jump labels are activated.
> - */
> -static __init int xen_init_spinlocks_jump(void)
> -{
> -	if (!xen_pvspin)
> -		return 0;
> -
> -	if (!xen_domain())
> -		return 0;
> -
> -	static_key_slow_inc(&paravirt_ticketlocks_enabled);
> -	return 0;
> -}
> -early_initcall(xen_init_spinlocks_jump);
> -
>  static __init int xen_parse_nopvspin(char *arg)
>  {
>  	xen_pvspin = false;


Xen bits:

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
