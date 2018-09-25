Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeIYWfy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2018 18:35:54 -0400
Date: Tue, 25 Sep 2018 18:27:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 01/27] x86/cpufeatures: Add CPUIDs for
 Control-flow Enforcement Technology (CET)
Message-ID: <20180925162705.GB30146@hirez.programming.kicks-ass.net>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
 <20180921150351.20898-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150351.20898-2-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180925162705.RcBMKXxcvnHhGRnuFdX7iS7HXZS7I-2q4RaijbwQ6EE@z>

On Fri, Sep 21, 2018 at 08:03:25AM -0700, Yu-cheng Yu wrote:

> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 772c219b6889..63cbb4d9938e 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -21,6 +21,7 @@ struct cpuid_bit {
>  static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
>  	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
> +	{ X86_FEATURE_IBT,		CPUID_EDX, 20, 0x00000007, 0},
                                                                   ^^
missing white space at the end there.

>  	{ X86_FEATURE_CAT_L3,		CPUID_EBX,  1, 0x00000010, 0 },
>  	{ X86_FEATURE_CAT_L2,		CPUID_EBX,  2, 0x00000010, 0 },
>  	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
> -- 
> 2.17.1
> 
