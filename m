Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:39406 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdALVnA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2017 16:43:00 -0500
Subject: Re: [PATCH v2] x86, locking/spinlocks: Remove
 paravirt_ticketlocks_enabled
References: <1484252878-1962-1-git-send-email-longman@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <76a962e4-14a9-74ab-6e6c-89fe3b8c1a1d@oracle.com>
Date: Thu, 12 Jan 2017 16:39:36 -0500
MIME-Version: 1.0
In-Reply-To: <1484252878-1962-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Juergen Gross <jgross@suse.com>
Message-ID: <20170112213936.bjObgN2Lt6IJ0WJjKw5qqNcZ-tBdZsgt3EE8qQSjMb8@z>


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
