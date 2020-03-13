From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH v9 15/27] mm: Handle THP/HugeTLB Shadow Stack page
 fault
Date: Fri, 13 Mar 2020 15:00:20 -0700
Message-ID: <c8c394fba4b64c9151201952752647d61324c0a8.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-16-yu-cheng.yu@intel.com>
         <202002251258.7D6DA92@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <202002251258.7D6DA92@keescook>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
List-Id: linux-arch.vger.kernel.org

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
