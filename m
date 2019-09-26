From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
Date: Wed, 25 Sep 2019 21:59:40 -0500
Message-ID: <20190926025940.hima423t2yfhh6h4@treble>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190919150809.446771597@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 19, 2019 at 05:03:24PM +0200, Thomas Gleixner wrote:
>  ENTRY(error_exit)
> -	UNWIND_HINT_REGS
>  	DISABLE_INTERRUPTS(CLBR_ANY)
>  	TRACE_IRQS_OFF
> +	UNWIND_HINT_REGS
>  	testb	$3, CS(%rsp)
>  	jz	retint_kernel
>  	jmp	retint_user

I don't think this UNWIND_HINT_REGS needs to be moved?

-- 
Josh
