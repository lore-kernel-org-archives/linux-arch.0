Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:44026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfFGHHz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 03:07:55 -0400
Date: Fri, 7 Jun 2019 09:07:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 05/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
Message-ID: <20190607070725.GN3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-6-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607070725.FHLNtHN7E808hVRTSj3UA7kCsXA0lTlM4bUkACW2ywU@z>

On Thu, Jun 06, 2019 at 01:06:24PM -0700, Yu-cheng Yu wrote:
> Intel Control-flow Enforcement Technology (CET) introduces the
> following MSRs.
> 
>     MSR_IA32_U_CET (user-mode CET settings),
>     MSR_IA32_PL3_SSP (user-mode shadow stack),
>     MSR_IA32_PL0_SSP (kernel-mode shadow stack),
>     MSR_IA32_PL1_SSP (Privilege Level 1 shadow stack),
>     MSR_IA32_PL2_SSP (Privilege Level 2 shadow stack).
> 
> Introduce them into XSAVES system states.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/types.h            | 22 +++++++++++++++++++++
>  arch/x86/include/asm/fpu/xstate.h           |  4 +++-
>  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>  arch/x86/kernel/fpu/xstate.c                | 10 ++++++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)

And yet, no changes to msr-index.h !?
