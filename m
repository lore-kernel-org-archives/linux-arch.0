Return-Path: <sean.j.christopherson@intel.com>
Date: Wed, 23 Oct 2019 07:17:59 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 06/17] x86/entry/32: Remove redundant interrupt disable
Message-ID: <20191023141759.GF329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.191230255@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123118.191230255@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023141759.dwiwRAhRorMWrFvPiqejN_irX95NJlFHU3l3kiG5Cq8@z>

On Wed, Oct 23, 2019 at 02:27:11PM +0200, Thomas Gleixner wrote:
> Now that the trap handlers return with interrupts disabled, the
> unconditional disabling of interrupts in the low level entry code can be
> removed along with the trace calls and the misnomed preempt_stop macro.
> As a consequence ret_from_exception and ret_from_intr collapse.
> 
> Add a debug check to verify that interrupts are disabled depending on
> CONFIG_DEBUG_ENTRY.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

One nit below.

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

>  arch/x86/entry/entry_32.S |   21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1207,7 +1198,7 @@ ENDPROC(common_spurious)
>  	TRACE_IRQS_OFF
>  	movl	%esp, %eax
>  	call	do_IRQ
> -	jmp	ret_from_intr
> +	jmp	ret_from_exception
>  ENDPROC(common_interrupt)
>  
>  #define BUILD_INTERRUPT3(name, nr, fn)			\
> @@ -1219,7 +1210,7 @@ ENTRY(name)						\
>  	TRACE_IRQS_OFF					\
>  	movl	%esp, %eax;				\
>  	call	fn;					\
> -	jmp	ret_from_intr;				\
> +	jmp	ret_from_exception;				\

This backslash is now unaligned.

>  ENDPROC(name)
>  
>  #define BUILD_INTERRUPT(name, nr)		\
> @@ -1366,7 +1357,7 @@ ENTRY(xen_do_upcall)
>  #ifndef CONFIG_PREEMPTION
>  	call	xen_maybe_preempt_hcall
>  #endif
> -	jmp	ret_from_intr
> +	jmp	ret_from_exception
>  ENDPROC(xen_hypervisor_callback)
>  
>  /*
> 
> 
