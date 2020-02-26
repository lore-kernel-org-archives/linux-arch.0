Return-Path: <SRS0=oITL=4O=vger.kernel.org=linux-doc-owner@kernel.org>
Date: Wed, 26 Feb 2020 20:57:10 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Message-ID: <20200226195710.6sma4whvs3o76oux@ucw.cz>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <597fb45a-cb94-e8e7-8e80-45a26766d32a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597fb45a-cb94-e8e7-8e80-45a26766d32a@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226195710.-SdTzbZg8JvnhbeS_JUDNh7fYmyItSC-ANEBSU1LWQc@z>

> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > Introduce Kconfig option: X86_INTEL_SHADOW_STACK_USER.
> > 
> > Shadow Stack (SHSTK) provides protection against function return address
> > corruption.  It is active when the kernel has this feature enabled, and
> > both the processor and the application support it.  When this feature is
> > enabled, legacy non-SHSTK applications continue to work, but without SHSTK
> > protection.
> > 
> > The user-mode SHSTK protection is only implemented for the 64-bit kernel.
> > IA32 applications are supported under the compatibility mode.
> 
> I think what you're trying to say here is that the hardware supports
> shadow stacks with 32-bit kernels.  However, this series does not
> include that support and we have no plans to add it.
> 
> Right?
> 
> I'll let others weigh in, but I rather dislike the use of acronyms here.
>  I'd much rather see the english "shadow stack" everywhere than SHSTK.

For the record, I like "shadow stack" better, too.
