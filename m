Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:53303 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbaCMN7d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Mar 2014 09:59:33 -0400
Message-ID: <5321B9BE.7050209@redhat.com>
Date: Thu, 13 Mar 2014 14:59:26 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC v6 10/11] pvqspinlock, x86: Enable qspinlock PV support
 for KVM
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com> <1394650498-30118-11-git-send-email-Waiman.Long@hp.com>
In-Reply-To: <1394650498-30118-11-git-send-email-Waiman.Long@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Scott J Norton <scott.norton@hp.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20140313135926.C9BTysLtROrcUMwSghWX0AHVJOBn14MX2V4UCIEsRCM@z>

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

