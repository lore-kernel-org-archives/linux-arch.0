Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:9631 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbfFGR7k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jun 2019 13:59:40 -0400
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup
 function
References: <20190606200926.4029-1-yu-cheng.yu@intel.com>
 <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net>
 <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <20190607174336.GM3436@hirez.programming.kicks-ass.net>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
Date: Fri, 7 Jun 2019 10:59:37 -0700
MIME-Version: 1.0
In-Reply-To: <20190607174336.GM3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607175937.x145XXYBqjbFkxTz8iehJ-Z9BABKEKIRr1YGG2vPBfU@z>

On 6/7/19 10:43 AM, Peter Zijlstra wrote:
> I've no idea what the kernel should do; since you failed to answer the
> question what happens when you point this to garbage.
> 
> Does it then fault or what?

Yeah, I think you'll fault with a rather mysterious CR2 value since
you'll go look at the instruction that faulted and not see any
references to the CR2 value.

I think this new MSR probably needs to get included in oops output when
CET is enabled.

Why don't we require that a VMA be in place for the entire bitmap?
Don't we need a "get" prctl function too in case something like a JIT is
running and needs to find the location of this bitmap to set bits itself?

Or, do we just go whole-hog and have the kernel manage the bitmap
itself. Our interface here could be:

	prctl(PR_MARK_CODE_AS_LEGACY, start, size);

and then have the kernel allocate and set the bitmap for those code
locations.
