From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Date: Fri, 22 May 2020 11:28:48 +0200
Message-ID: <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200521211720.20236-6-yu-cheng.yu@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:

> +#pragma GCC push_options
> +#pragma GCC optimize ("O0")
> +void ibt_violation(void)
> +{
> +#ifdef __i386__
> +	asm volatile("lea 1f, %eax");
> +	asm volatile("jmp *%eax");
> +#else
> +	asm volatile("lea 1f, %rax");
> +	asm volatile("jmp *%rax");
> +#endif
> +	asm volatile("1:");
> +	result[test_id] = -1;
> +	test_id++;
> +	setcontext(&ucp);
> +}
> +
> +void shstk_violation(void)
> +{
> +#ifdef __i386__
> +	unsigned long x = 0;
> +
> +	((unsigned long *)&x)[2] = (unsigned long)stack_hacked;
> +#else
> +	unsigned long long x = 0;
> +
> +	((unsigned long long *)&x)[2] = (unsigned long)stack_hacked;
> +#endif
> +}
> +#pragma GCC pop_options

This is absolutely atrocious.

The #pragma like Kees already said just need to go. Also, there's
absolutely no clue what so ever what it attempts to achieve.

The __i386__ ifdeffery is horrible crap. Splitting an asm with #ifdef
like that is also horrible crap.

This is not how you write code.

Get asm/asm.h into userspace and then write something like:


void ibt_violation(void)
{
	asm volatile("lea  1f, %" _ASM_AX "\n\t"
		     "jmp  *%" _ASM_AX "\n\t"
		     "1:\n\t" ::: "a");

	WRITE_ONCE(result[test_id], -1);
	WRITE_ONCE(test_id, test_id+1);

	setcontext(&ucp);
}

void shstk_violation(void)
{
	unsigned long x = 0;

	WRITE_ONCE(x[2], stack_hacked);
}
