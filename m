Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22421 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389893AbfISPk1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Sep 2019 11:40:27 -0400
Received: by mail-wr1-f70.google.com with SMTP id h6so1238787wrh.6
        for <linux-arch@vger.kernel.org>; Thu, 19 Sep 2019 08:40:05 -0700 (PDT)
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.860645841@linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0cc964dc-4d00-05ec-1ed1-f6cee7370d7b@redhat.com>
Date: Thu, 19 Sep 2019 17:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190919150809.860645841@linutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190919154001.feZK_m8gGAvgHH-ZO2spQOLjxDkb7Y606NEeLon_CdY@z>

Quick API review before I dive into the implementation.

On 19/09/19 17:03, Thomas Gleixner wrote:
> +=09/*
> +=09 * Before returning to guest mode handle all pending work
> +=09 */
> +=09if (ti_work & _TIF_SIGPENDING) {
> +=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
> +=09=09vcpu->stat.signal_exits++;
> +=09=09return -EINTR;
> +=09}
> +
> +=09if (ti_work & _TIF_NEED_RESCHED) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09schedule();
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09if (ti_work & _TIF_PATCH_PENDING) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09klp_update_patch_state(current);
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09if (ti_work & _TIF_NOTIFY_RESUME) {
> +=09=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> +=09=09clear_thread_flag(TIF_NOTIFY_RESUME);
> +=09=09tracehook_notify_resume(NULL);
> +=09=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);
> +=09}
> +
> +=09/* Any extra architecture specific work */
> +=09return arch_exit_to_guestmode_work(kvm, vcpu, ti_work);
> +}

Perhaps, in virt/kvm/kvm_main.c:

int kvm_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
=09=09=09=09unsigned long ti_work)
{
=09int r;

=09/*
=09 * Before returning to guest mode handle all pending work
=09 */
=09if (ti_work & _TIF_SIGPENDING) {
=09=09vcpu->run->exit_reason =3D KVM_EXIT_INTR;
=09=09vcpu->stat.signal_exits++;
=09=09return -EINTR;
=09}

=09srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
=09core_exit_to_guestmode_work(ti_work);
=09vcpu->srcu_idx =3D srcu_read_lock(&kvm->srcu);

=09return r;
}

and in kernel/entry/common.c:

int core_exit_to_guestmode_work(unsigned long ti_work)
{
=09/*
=09 * Before returning to guest mode handle all pending work
=09 */
=09if (ti_work & _TIF_NEED_RESCHED)
=09=09schedule();

=09if (ti_work & _TIF_PATCH_PENDING)
=09=09klp_update_patch_state(current);

=09if (ti_work & _TIF_NOTIFY_RESUME) {
=09=09clear_thread_flag(TIF_NOTIFY_RESUME);
=09=09tracehook_notify_resume(NULL);
=09}
=09return arch_exit_to_guestmode_work(ti_work);
}

so that kernel/entry/ is not polluted with KVM structs and APIs.

Perhaps even extract the body of core_exit_to_usermode_work's while loop
to a separate function, and call it as

=09core_exit_to_usermode_work_once(NULL,
=09=09=09=09ti_work & EXIT_TO_GUESTMODE_WORK);

from core_exit_to_guestmode_work.

In general I don't mind having these exit_to_guestmode functions in
kvm_host.h, and only having entry-common.h export EXIT_TO_GUESTMODE_WORK
and ARCH_EXIT_TO_GUESTMODE_WORK.  Unless you had good reasons to do the
opposite...

Paolo
