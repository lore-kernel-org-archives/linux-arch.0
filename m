Return-Path: <SRS0=uZ41=BC=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:65237 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGWQZh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 12:25:37 -0400
Date: Thu, 23 Jul 2020 09:25:31 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Message-ID: <20200723162531.GF21891@linux.intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Message-ID: <20200723162531.RedtLtM8Yzct9ahrbLY2us03bBoZPiIEsTFU8pXt5aQ@z>

On Wed, Apr 29, 2020 at 03:07:06PM -0700, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details can be found in "Intel
> 64 and IA-32 Architectures Software Developer's Manual" [1].
> 
> This series depends on the XSAVES supervisor state series that was split
> out and submitted earlier [2].

...

> Yu-cheng Yu (25):
>   x86/cpufeatures: Add CET CPU feature flags for Control-flow
>     Enforcement Technology (CET)
>   x86/fpu/xstate: Introduce CET MSR XSAVES supervisor states

How would people feel about taking the above two patches (02 and 03 in the
series) through the KVM tree to enable KVM virtualization of CET before the
kernel itself gains CET support?  I.e. add the MSR and feature bits, along
with the XSAVES context switching.  The feature definitons could use "" to
suppress displaying them in /proc/cpuinfo to avoid falsely advertising CET
to userspace.

AIUI, there are ABI issues that need to be sorted out, and that is likely
going to drag on for some time. 

Is this a "hell no" sort of idea, or something that would be feasible if we
can show that there are no negative impacts to the kernel?
