Return-Path: <SRS0=yLSb=7E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:38059 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgEVPKK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 11:10:10 -0400
Message-ID: <cc3d7668eb7dd738a85f0b0935624496efae43be.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Fri, 22 May 2020 08:10:14 -0700
In-Reply-To: <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-6-yu-cheng.yu@intel.com>
         <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Message-ID: <20200522151014.Ui1JMAzlx5dMK2bNPIOpVEBJK3w5rlRD-imYpWSm3E8@z>

On Fri, 2020-05-22 at 11:28 +0200, Peter Zijlstra wrote:
> On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:
> 
> > +#pragma GCC push_options
> > +#pragma GCC optimize ("O0")
> > +void ibt_violation(void)
> > +{
> > +#ifdef __i386__
> > +	asm volatile("lea 1f, %eax");
> > +	asm volatile("jmp *%eax");
> > +#else
> > +	asm volatile("lea 1f, %rax");
> > +	asm volatile("jmp *%rax");
> > +#endif
> > +	asm volatile("1:");
> > +	result[test_id] = -1;
> > +	test_id++;
> > +	setcontext(&ucp);
> > +}
> > +
> > +void shstk_violation(void)
> > +{
> > +#ifdef __i386__
> > +	unsigned long x = 0;
> > +
> > +	((unsigned long *)&x)[2] = (unsigned long)stack_hacked;
> > +#else
> > +	unsigned long long x = 0;
> > +
> > +	((unsigned long long *)&x)[2] = (unsigned long)stack_hacked;
> > +#endif
> > +}
> > +#pragma GCC pop_options
> 
> This is absolutely atrocious.
> 
> The #pragma like Kees already said just need to go. Also, there's
> absolutely no clue what so ever what it attempts to achieve.
> 
> The __i386__ ifdeffery is horrible crap. Splitting an asm with #ifdef
> like that is also horrible crap.
> 
> This is not how you write code.
> 
> Get asm/asm.h into userspace and then write something like:
> 
> 
> void ibt_violation(void)
> {
> 	asm volatile("lea  1f, %" _ASM_AX "\n\t"
> 		     "jmp  *%" _ASM_AX "\n\t"
> 		     "1:\n\t" ::: "a");
> 
> 	WRITE_ONCE(result[test_id], -1);
> 	WRITE_ONCE(test_id, test_id+1);
> 
> 	setcontext(&ucp);
> }
> 
> void shstk_violation(void)
> {
> 	unsigned long x = 0;
> 
> 	WRITE_ONCE(x[2], stack_hacked);
> }

Thanks!  I will change it.

Yu-cheng
