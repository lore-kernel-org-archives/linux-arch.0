From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC patch 14/15] workpending: Provide infrastructure for work
 before entering a guest
Date: Mon, 23 Sep 2019 11:17:50 -0700
Message-ID: <CALCETrWjDtcued8nYv=FtcjREz8C4Kj6OaCCirUkbZQForSo+A@mail.gmail.com>
References: <20190919150314.054351477@linutronix.de> <20190919150809.860645841@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919150809.860645841@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Entering a guest is similar to exiting to user space. Pending work like
> handling signals, rescheduling, task work etc. needs to be handled before
> that.
>
> Provide generic infrastructure to avoid duplication of the same handling code
> all over the place.
>
> Update ARM64 struct kvm_vcpu_stat with a signal_exit member so the generic
> code compiles.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/arm64/include/asm/kvm_host.h |    1
>  include/linux/entry-common.h      |   66 ++++++++++++++++++++++++++++++++++++++
>  kernel/entry/common.c             |   44 +++++++++++++++++++++++++
>  3 files changed, 111 insertions(+)
>
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -409,6 +409,7 @@ struct kvm_vcpu_stat {
>         u64 wfi_exit_stat;
>         u64 mmio_exit_user;
>         u64 mmio_exit_kernel;
> +       u64 signal_exits;
>         u64 exits;
>  };
>
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -255,4 +255,70 @@ static inline void arch_syscall_exit_tra
>  /* Common syscall exit function */
>  void syscall_exit_to_usermode(struct pt_regs *regs, long syscall, long retval);
>
> +#if IS_ENABLED(CONFIG_KVM)
> +
> +#include <linux/kvm_host.h>
> +
> +#ifndef ARCH_EXIT_TO_GUESTMODE_WORK
> +# define ARCH_EXIT_TO_GUESTMODE_WORK   (0)
> +#endif
> +
> +#define EXIT_TO_GUESTMODE_WORK                                         \
> +       (_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_RESUME |     \
> +        ARCH_EXIT_TO_GUESTMODE_WORK)
> +
> +int core_exit_to_guestmode_work(struct kvm *kvm, struct kvm_vcpu *vcpu,
> +                               unsigned long ti_work);
> +
> +/**
> + * arch_exit_to_guestmode - Architecture specific exit to guest mode function
> + * @kvm:       Pointer to the guest instance
> + * @vcpu:      Pointer to current's VCPU data
> + * @ti_work:   Cached TIF flags gathered in exit_to_guestmode()
> + *
> + * Invoked from core_exit_to_guestmode_work(). Can be replaced by
> + * architecture specific code.
> + */
> +static inline int arch_exit_to_guestmode(struct kvm *kvm, struct kvm_vcpu *vcpu,
> +                                        unsigned long ti_work);

Can you add a comment about whether IRQs are supposed to be off (I
assume they are) and perhaps a lockdep assertion to verify it?
