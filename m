Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389646AbfISPma (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Sep 2019 11:42:30 -0400
Received: by mail-wm1-f70.google.com with SMTP id g82so1988871wmg.9
        for <linux-arch@vger.kernel.org>; Thu, 19 Sep 2019 08:40:57 -0700 (PDT)
Subject: Re: [RFC patch 15/15] x86/kvm: Use GENERIC_EXIT_WORKPENDING
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.964620570@linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef1145d8-01af-57d2-1065-cf12db16e422@redhat.com>
Date: Thu, 19 Sep 2019 17:40:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190919150809.964620570@linutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190919154051.e6r-ryE-0x5DhLlJHuVb1QlHamk0qmAHVo1I2oAv1Bc@z>

On 19/09/19 17:03, Thomas Gleixner wrote:
> Use the generic infrastructure to check for and handle pending work befor=
e
> entering into guest mode.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Subject should be "x86/kvm: use exit_to_guestmode".

Paolo

> ---
>  arch/x86/kvm/x86.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -52,6 +52,7 @@
>  #include <linux/irqbypass.h>
>  #include <linux/sched/stat.h>
>  #include <linux/sched/isolation.h>
> +#include <linux/entry-common.h>
>  #include <linux/mem_encrypt.h>
> =20
>  #include <trace/events/kvm.h>
> @@ -7984,8 +7985,8 @@ static int vcpu_enter_guest(struct kvm_v
>  =09if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
>  =09=09kvm_x86_ops->sync_pir_to_irr(vcpu);
> =20
> -=09if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_request_pending(vcpu)
> -=09    || need_resched() || signal_pending(current)) {
> +=09if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_request_pending(vcpu)=
 ||
> +=09    exit_to_guestmode_work_pending()) {
>  =09=09vcpu->mode =3D OUTSIDE_GUEST_MODE;
>  =09=09smp_wmb();
>  =09=09local_irq_enable();
> @@ -8178,17 +8179,9 @@ static int vcpu_run(struct kvm_vcpu *vcp
> =20
>  =09=09kvm_check_async_pf_completion(vcpu);
> =20
> -=09=09if (signal_pending(current)) {
> -=09=09=09r =3D -EINTR;
> -=09=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
> -=09=09=09++vcpu->stat.signal_exits;
> +=09=09r =3D exit_to_guestmode(kvm, vcpu);
> +=09=09if (r)
>  =09=09=09break;
> -=09=09}
> -=09=09if (need_resched()) {
> -=09=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> -=09=09=09cond_resched();
> -=09=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> -=09=09}
>  =09}
> =20
>  =09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
>=20
>=20
