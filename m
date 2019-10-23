Return-Path: <jpoimboe@redhat.com>
Date: Wed, 23 Oct 2019 16:31:07 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 03/17] x86/traps: Remove pointless irq enable from
 do_spurious_interrupt_bug()
Message-ID: <20191023213107.m7ishskghswktspp@treble>
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.871608831@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191023123117.871608831@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023213107.YReIHewhDkRxYIUYbtxKblmpj2gf_rNnR_MHstFqF98@z>

On Wed, Oct 23, 2019 at 02:27:08PM +0200, Thomas Gleixner wrote:
> That function returns immediately after conditionally reenabling interrup=
ts which
> is more than pointless and requires the ASM code to disable interrupts ag=
ain.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/traps.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -871,7 +871,6 @@ do_simd_coprocessor_error(struct pt_regs
>  dotraplinkage void
>  do_spurious_interrupt_bug(struct pt_regs *regs, long error_code)
>  {
> -=09cond_local_irq_enable(regs);
>  }

I think we can just remove this handler altogether.  The Intel and AMD
manuals say vector 15 (X86_TRAP_SPURIOUS) is reserved.

--=20
Josh
