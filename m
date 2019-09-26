Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbfIZC7o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Sep 2019 22:59:44 -0400
Date: Wed, 25 Sep 2019 21:59:40 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
Message-ID: <20190926025940.hima423t2yfhh6h4@treble>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919150809.446771597@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190926025940.u4kotFggpf-38dQPnwu6fYDhhoDuGtg0oRJf7Kw8hcA@z>

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
