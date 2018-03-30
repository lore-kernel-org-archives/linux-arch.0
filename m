From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 7/7] x86/entry/64: extend register clearing on syscall
 entry to lower registers
Date: Fri, 30 Mar 2018 12:10:20 +0200
Message-ID: <20180330101020.6g2pib3xaftawl5h@gmail.com>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
 <20180330093720.6780-8-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330093720.6780-8-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

>  	.endif
>  	pushq	\rdx		/* pt_regs->dx */
> +	xorl	%edx, %edx	/* nosepc   dx */
>  	pushq   %rcx		/* pt_regs->cx */
> +	xorl	%ecx, %ecx	/* nosepc   cx */
>  	pushq   \rax		/* pt_regs->ax */
>  	pushq   %r8		/* pt_regs->r8 */
>  	xorl	%r8d, %r8d	/* nospec   r8 */
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index 08425c42f8b7..23e0945959e5 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -220,8 +220,11 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
>  	pushq	%rax			/* pt_regs->orig_ax */
>  	pushq	%rdi			/* pt_regs->di */
>  	pushq	%rsi			/* pt_regs->si */
> +	xorl	%esi, %esi		/* nosepc   si */
>  	pushq	%rdx			/* pt_regs->dx */
> +	xorl	%edx, %edx		/* nosepc   dx */
>  	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
> +	xorl	%ecx, %ecx		/* nosepc   cx */
>  	pushq	$-ENOSYS		/* pt_regs->ax */
>  	pushq   $0			/* pt_regs->r8  = 0 */
>  	xorl	%r8d, %r8d		/* nospec   r8 */
> @@ -365,8 +368,11 @@ ENTRY(entry_INT80_compat)
>  
>  	pushq	(%rdi)			/* pt_regs->di */
>  	pushq	%rsi			/* pt_regs->si */
> +	xorl	%esi, %esi		/* nosepc   si */
>  	pushq	%rdx			/* pt_regs->dx */
> +	xorl	%edx, %edx		/* nosepc   dx */
>  	pushq	%rcx			/* pt_regs->cx */
> +	xorl	%ecx, %ecx		/* nosepc   cx */
>  	pushq	$-ENOSYS		/* pt_regs->ax */
>  	pushq   $0			/* pt_regs->r8  = 0 */
>  	xorl	%r8d, %r8d		/* nospec   r8 */

s/nosepc
 /nospec

Thanks,

	Ingo
