Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeGKJkF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jul 2018 05:40:05 -0400
Date: Wed, 11 Jul 2018 11:36:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 17/27] x86/cet/shstk: User-mode shadow stack
 support
Message-ID: <20180711093629.GY2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-18-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222639.8241-18-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180711093629.VQl3gVw0h7xy9XFH7T6-RJy6QEbEzB50IQ7DbIkPG-Q@z>

On Tue, Jul 10, 2018 at 03:26:29PM -0700, Yu-cheng Yu wrote:
> +struct cet_status {
> +	unsigned long	shstk_base;
> +	unsigned long	shstk_size;
> +	unsigned int	shstk_enabled:1;
> +};

> @@ -498,6 +499,10 @@ struct thread_struct {
>  	unsigned int		sig_on_uaccess_err:1;
>  	unsigned int		uaccess_err:1;	/* uaccess failed */
>  
> +#ifdef CONFIG_X86_INTEL_CET
> +	struct cet_status	cet;
> +#endif
> +
>  	/* Floating point and extended processor state */
>  	struct fpu		fpu;
>  	/*

Why does that need a structure? That avoids folding the bitfields.
