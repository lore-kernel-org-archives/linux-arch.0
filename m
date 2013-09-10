From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 7/7] sched, x86: Optimize the preempt_schedule() call
Date: Tue, 10 Sep 2013 15:42:47 +0200
Message-ID: <20130910134247.GC7537@gmail.com>
References: <20130910130811.507933095@infradead.org>
 <20130910132011.474646746@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130910132011.474646746@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> +	.macro SAVE_ALL
> +	pushl_cfi %eax
> +	CFI_REL_OFFSET eax, 0
> +	pushl_cfi %ebp
> +	CFI_REL_OFFSET ebp, 0
> +	pushl_cfi %edi
> +	CFI_REL_OFFSET edi, 0
> +	pushl_cfi %esi
> +	CFI_REL_OFFSET esi, 0
> +	pushl_cfi %edx
> +	CFI_REL_OFFSET edx, 0
> +	pushl_cfi %ecx
> +	CFI_REL_OFFSET ecx, 0
> +	pushl_cfi %ebx
> +	CFI_REL_OFFSET ebx, 0
> +	.endm
> +
> +	.macro RESTORE_ALL
> +	popl_cfi %ebx
> +	CFI_RESTORE ebx
> +	popl_cfi %ecx
> +	CFI_RESTORE ecx
> +	popl_cfi %edx
> +	CFI_RESTORE edx
> +	popl_cfi %esi
> +	CFI_RESTORE esi
> +	popl_cfi %edi
> +	CFI_RESTORE edi
> +	popl_cfi %ebp
> +	CFI_RESTORE ebp
> +	popl_cfi %eax
> +	CFI_RESTORE eax
> +	.endm

Side note: shouldn't the pushl_cfi and popl_cfi macros be adjusted, 
instead of open coding it?

Thanks,

	Ingo
