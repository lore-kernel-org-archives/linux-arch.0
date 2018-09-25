Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeIYXM4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2018 19:12:56 -0400
Date: Tue, 25 Sep 2018 19:03:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 03/27] x86/fpu/xstate: Enable XSAVES system states
Message-ID: <20180925170355.GD30146@hirez.programming.kicks-ass.net>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150351.20898-4-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180925170355.N_CQmlV9kPPPydiVyU9t77wqy1qTJ-Rficnea3EXm9c@z>

On Fri, Sep 21, 2018 at 08:03:27AM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 4bd56079048f..9f51b0e1da25 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -365,8 +365,13 @@ void fpu__drop(struct fpu *fpu)
>   */
>  static inline void copy_init_user_fpstate_to_fpregs(void)
>  {
> +	/*
> +	 * Only XSAVES user states are copied.
> +	 * System states are preserved.
> +	 */
>  	if (use_xsave())
> -		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
> +		copy_kernel_to_xregs(&init_fpstate.xsave,
> +				     xfeatures_mask_user);

By my counting, that doesn't qualify for a line-break, it hits 80.

If you were to do this line-break, coding style would have you liberally
sprinkle {} around.

>  	else if (static_cpu_has(X86_FEATURE_FXSR))
>  		copy_kernel_to_fxregs(&init_fpstate.fxsave);
>  	else
