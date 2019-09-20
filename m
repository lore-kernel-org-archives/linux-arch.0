Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:52081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438265AbfITLsT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Sep 2019 07:48:19 -0400
Date: Fri, 20 Sep 2019 13:48:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
In-Reply-To: <0cc964dc-4d00-05ec-1ed1-f6cee7370d7b@redhat.com>
Message-ID: <alpine.DEB.2.21.1909201345380.1858@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150809.860645841@linutronix.de> <0cc964dc-4d00-05ec-1ed1-f6cee7370d7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190920114805.-Ze8ihhWy92FXCKbW2Ozb67lQ3O2Hnf1QqqMcA9WT1o@z>

On Thu, 19 Sep 2019, Paolo Bonzini wrote:
> > +	/* Any extra architecture specific work */
> > +	return arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> > +}
> 
> Perhaps, in virt/kvm/kvm_main.c:
> 
> int kvm_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
> 				unsigned long ti_work)
> {
...
> }
> 
> and in kernel/entry/common.c:
> 
> int core_exit_to_guestmode_work(unsigned long ti_work)
> {
...
> }

Makes sense.
 
> so that kernel/entry/ is not polluted with KVM structs and APIs.
> 
> Perhaps even extract the body of core_exit_to_usermode_work's while loop
> to a separate function, and call it as
> 
> 	core_exit_to_usermode_work_once(NULL,
> 				ti_work & EXIT_TO_GUESTMODE_WORK);

Doh, its too obvious now that you mention it :)

> from core_exit_to_guestmode_work.
> 
> In general I don't mind having these exit_to_guestmode functions in
> kvm_host.h, and only having entry-common.h export EXIT_TO_GUESTMODE_WORK
> and ARCH_EXIT_TO_GUESTMODE_WORK.  Unless you had good reasons to do the
> opposite...

That was an arbitrary choice and it does not matter much where it lives.

Thanks,

	tglx
