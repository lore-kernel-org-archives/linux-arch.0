Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57844 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388053AbeKGEKL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Nov 2018 23:10:11 -0500
Subject: Re: [PATCH v5 21/27] x86/cet/shstk: Introduce WRUSS instruction
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-22-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ee5a93f7-ed42-dcc5-0e55-e73ac2637e84@intel.com>
Date: Tue, 6 Nov 2018 10:43:27 -0800
MIME-Version: 1.0
In-Reply-To: <20181011151523.27101-22-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181106184327.L_VPRv9fHP-ErTJwX2nlmNgz5Tw813X2Y3BzkO1Hkec@z>

On 10/11/18 8:15 AM, Yu-cheng Yu wrote:
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1305,6 +1305,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
>  		error_code |= X86_PF_USER;
>  		flags |= FAULT_FLAG_USER;
>  	} else {
> +		/*
> +		 * WRUSS is a kernel instruction and but writes
> +		 * to user shadow stack.  When a fault occurs,
> +		 * both X86_PF_USER and X86_PF_SHSTK are set.
> +		 * Clear X86_PF_USER here.
> +		 */
> +		if ((error_code & (X86_PF_USER | X86_PF_SHSTK)) ==
> +		    (X86_PF_USER | X86_PF_SHSTK))
> +			error_code &= ~X86_PF_USER;
This hunk of code basically points out that the architecture of WRUSS is
broken for Linux.  The setting of X86_PF_USER for a ring-0 instruction
really is a mis-feature of the architecture for us and we *undo* it in
software which is unfortunate.  Wish I would have caught this earlier.

Andy, note that this is another case where hw_error_code and
sw_error_code will diverge, unfortunately.

Anyway, this is going to necessitate some comment updates in the page
fault code.  Yu-cheng, you are going to collide with some recent changes
I made to the page fault code.  Please be careful with the context when
you do the merge and make sure that all the new comments stay correct.
