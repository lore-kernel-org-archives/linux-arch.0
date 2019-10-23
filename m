Return-Path: <jpoimboe@redhat.com>
Date: Wed, 23 Oct 2019 17:01:09 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 05/17] x86/traps: Make interrupt enable/disable
 symmetric in C code
Message-ID: <20191023220109.jmbrluyjxenblcij@treble>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.084086112@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191023123118.084086112@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023220109.mIAQe5g1-ZbD84icxQi4-uTjcSYJkhkOpsxKKPf0XKc@z>

On Wed, Oct 23, 2019 at 02:27:10PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1500,10 +1500,13 @@ static noinline void
>  =09=09return;
> =20
>  =09/* Was the fault on kernel-controlled part of the address space? */
> -=09if (unlikely(fault_in_kernel_space(address)))
> +=09if (unlikely(fault_in_kernel_space(address))) {
>  =09=09do_kern_addr_fault(regs, hw_error_code, address);
> -=09else
> +=09} else {
>  =09=09do_user_addr_fault(regs, hw_error_code, address);
> +=09=09if (regs->flags & X86_EFLAGS_IF)
> +=09=09=09local_irq_disable();
> +=09}

The corresponding irq enable is in do_user_addr_fault(), why not do the
disable there?

--=20
Josh
