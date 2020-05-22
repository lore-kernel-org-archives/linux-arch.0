From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Date: Fri, 22 May 2020 10:22:51 -0700
Message-ID: <202005221020.B578B8C6@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
 <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, May 22, 2020 at 11:28:48AM +0200, Peter Zijlstra wrote:
> Get asm/asm.h into userspace and then write something like:

Yeah, selftests is going to start suffering from the same "tools/ header
duplication" problem. I've also had cases (see the logic in the Makefile
in selftests/x86) where selftests is duplicating existing Kconfig and
Makefile logic ("can I build this way?")

But yes, I think getting a copy of asm.h would be nice here. I don't
think the WRITE_ONCE() is needed in this particular case. Hmm.

-- 
Kees Cook
