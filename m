From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH v9 14/27] mm: Handle Shadow Stack page fault
Date: Thu, 05 Mar 2020 10:30:22 -0800
Message-ID: <dca80473b585c9491fa2f9410806b10aee4594f7.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-15-yu-cheng.yu@intel.com>
         <202002251218.F919026@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28704 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgCESaX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 13:30:23 -0500
In-Reply-To: <202002251218.F919026@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel

On Tue, 2020-02-25 at 12:20 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:22AM -0800, Yu-cheng Yu wrote:
> > When a task does fork(), its Shadow Stack (SHSTK) must be duplicated for
> > the child.  This patch implements a flow similar to copy-on-write of an
> > anonymous page, but for SHSTK.
> > 
> > A SHSTK PTE must be RO and Dirty.  This Dirty bit requirement is used to
> > effect the copying.  In copy_one_pte(), clear the Dirty bit from a SHSTK
> > PTE to cause a page fault upon the next SHSTK access.  At that time, fix
> > the PTE and copy/re-use the page.
> 
> Just to confirm, during the fork, it's really not a SHSTK for a moment
> (it's still RO, but not dirty). Can other racing threads muck this up,
> or is this bit removed only on the copied side?

In [RFC PATCH v9 12/27] x86/mm: Modify ptep_set_wrprotect and
pmdp_set_wrprotect for _PAGE_DIRTY_SW, _PAGE_DIRTY_HW is changed to
_PAGE_DIRTY_SW with cmpxchg.  That prevents racing.

The hw dirty bit is removed from the original copy first.  The next shadow
stack access to the page causes copying.  The copied page gets the hw dirty
bit again.

Yu-cheng
