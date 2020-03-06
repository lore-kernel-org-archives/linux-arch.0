Return-Path: <SRS0=ldhC=4X=vger.kernel.org=linux-doc-owner@kernel.org>
Message-ID: <d1e483574f496d16aa2ff92562debfdacaff0f36.camel@intel.com>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Fri, 06 Mar 2020 13:16:55 -0800
In-Reply-To: <d4e09cf8-4237-d168-7e46-929f2b536332@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-6-yu-cheng.yu@intel.com>
         <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
         <070d9d78981f0aad2baf740233e8dfc32ecd29d7.camel@intel.com>
         <d4e09cf8-4237-d168-7e46-929f2b536332@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200306211655.USUyRGhN7RIPsRXl6PEc_vDaHqxSqddBjxOsCffozbU@z>

On Fri, 2020-03-06 at 11:02 -0800, Dave Hansen wrote:
> On 3/6/20 10:37 AM, Yu-cheng Yu wrote:
> > We used to do this for CET instructions, but after adding kernel-mode
> > instructions and inserting ENDBR's, the code becomes cluttered.  I also
> > found an earlier discussion on the ENDBR:
> > 
> > https://lore.kernel.org/lkml/CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com/
> > 
> > It makes sense to let the user know early on that the system cannot support
> > CET and cannot build a CET-enabled kernel.
> > 
> > One thing we can do is to disable CET in Kconfig and not in kernel
> > build, which I will do in the next version.
> 
> I'll go on the record and say I think we should allow building
> CET-enabled kernels on old toolchains.  We need it for build test
> coverage.  We can spit out a warning, but we need to allow building it.

The build test will go through (assembler or .byte), once the opcode patch
is applied [1].  Also, when we enable kernel-mode CET, it is difficult to
build IBT code without the right tool chain.

Yu-cheng

[1] opcode patch: 
https://lore.kernel.org/lkml/20200204171425.28073-1-yu-cheng.yu@intel.com/
