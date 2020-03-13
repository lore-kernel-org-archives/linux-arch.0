Return-Path: <SRS0=hUYu=46=vger.kernel.org=linux-doc-owner@kernel.org>
Message-ID: <c8c394fba4b64c9151201952752647d61324c0a8.camel@intel.com>
Subject: Re: [RFC PATCH v9 15/27] mm: Handle THP/HugeTLB Shadow Stack page
 fault
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Fri, 13 Mar 2020 15:00:20 -0700
In-Reply-To: <202002251258.7D6DA92@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-16-yu-cheng.yu@intel.com>
         <202002251258.7D6DA92@keescook>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200313220020.lbkb-A-V1nRFhfy9bPgXakeqBmumRbOR3cD_MeP3qLA@z>

On Tue, 2020-02-25 at 12:59 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:23AM -0800, Yu-cheng Yu wrote:
> > This patch implements THP Shadow Stack (SHSTK) copying in the same way as
> > in the previous patch for regular PTE.
> > 
> > In copy_huge_pmd(), clear the dirty bit from the PMD to cause a page fault
> > upon the next SHSTK access to the PMD.  At that time, fix the PMD and
> > copy/re-use the page.
> 
> Now is as good a time as any to ask: do you have selftests for all this?
> It seems like it would be really nice to have a way to verify SHSTK is
> working correctly.

Yes, I have some simple tests at https://github.com/yyu168/cet-smoke-test.
I also run Linux/tools/testing/selftests/x86 and GLIBC tests with CET and THP
combinations.

Yu-cheng
