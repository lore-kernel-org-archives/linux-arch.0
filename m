Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36355 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdALUEi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2017 15:04:38 -0500
Subject: Re: [PATCH] x86, locking/spinlocks: Remove
 paravirt_ticketlocks_enabled
References: <1484234236-12976-1-git-send-email-longman@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <a8aecbb1-edb8-fb31-885d-1a84ff134934@oracle.com>
Date: Thu, 12 Jan 2017 15:03:39 -0500
MIME-Version: 1.0
In-Reply-To: <1484234236-12976-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Juergen Gross <jgross@suse.com>
Message-ID: <20170112200339.mWKDG4d6y2sDJMre_MQ3ORXEedH_NzlTfFIKxRvl25c@z>


> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
> index e8a9ea7..a822606 100644
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -155,7 +155,6 @@ static __init int xen_init_spinlocks_jump(void)
>  	if (!xen_domain())
>  		return 0;
>  
> -	static_key_slow_inc(&paravirt_ticketlocks_enabled);
>  	return 0;
>  }
>  early_initcall(xen_init_spinlocks_jump);


Looks that with this change there is not much left of
xen_init_spinlocks_jump() and so it can be removed.

-boris

