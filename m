Return-Path: <SRS0=V28G=7D=vger.kernel.org=linux-doc-owner@kernel.org>
Message-ID: <a8f55ca9d7ca81b4acb7afecd8144aa396975cfb.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 21 May 2020 16:23:38 -0700
In-Reply-To: <202005211550.AF0E83BB@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-6-yu-cheng.yu@intel.com>
         <202005211550.AF0E83BB@keescook>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200521232338.XPLcBdsnxamoKK0MBSQM4CvHuJY2Z1n9dE6NFGXakgk@z>

On Thu, 2020-05-21 at 16:02 -0700, Kees Cook wrote:
> On Thu, May 21, 2020 at 02:17:20PM -0700, Yu-cheng Yu wrote:
> > Introduce a quick test to verify shadow stack and IBT are working.
> 
> Cool! :)
> 
> I'd love to see either more of a commit log or more comments in the test
> code itself. I had to spend a bit of time trying to understand how the
> test was working. (i.e. using ucontext to "reset", using segv handler to
> catch some of them, etc.) I have not yet figured out why you need to
> send USR1/USR2 for two of them instead of direct calls?

Yes, I will work on it.

[...]

> > +
> > +#pragma GCC push_options
> > +#pragma GCC optimize ("O0")
> 
> Can you avoid compiler-specific pragmas? (Or verify that Clang also
> behaves correctly here?) Maybe it's better to just build the entire file
> with -O0 in the Makefile?

This file is compiled using -O2 in the makefile.  I will see if other ways are
possible.

[...]

> > +
> > +void segv_handler(int signum, siginfo_t *si, void *uc)
> > +{
> 
> Does anything in siginfo_t indicate which kind of failure you're
> detecting? It'd be nice to verify test_id matches the failure mode being
> tested.

Yes, there is an si_code for control-protection fault.
I will fix this.

Agree with your other comments.

Thanks,
Yu-cheng
