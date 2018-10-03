Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11379 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbeJCXH3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Oct 2018 19:07:29 -0400
Message-ID: <a278be878c9a1bdbe9adea515fcca5a691db17aa.camel@intel.com>
Subject: Re: [RFC PATCH v4 09/27] x86/mm: Change _PAGE_DIRTY to
 _PAGE_DIRTY_HW
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Wed, 03 Oct 2018 09:07:52 -0700
In-Reply-To: <20181003133856.GA24782@bombadil.infradead.org>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
         <20180921150351.20898-10-yu-cheng.yu@intel.com>
         <20181003133856.GA24782@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181003160752.JcBYatK9X-jXnE4qaXpFq6VC9xH1_Y7V7QtQ91TkDFo@z>

On Wed, 2018-10-03 at 06:38 -0700, Matthew Wilcox wrote:
> On Fri, Sep 21, 2018 at 08:03:33AM -0700, Yu-cheng Yu wrote:
> > We are going to create _PAGE_DIRTY_SW for non-hardware, memory
> > management purposes.  Rename _PAGE_DIRTY to _PAGE_DIRTY_HW and
> > _PAGE_BIT_DIRTY to _PAGE_BIT_DIRTY_HW to make these PTE dirty
> > bits more clear.  There are no functional changes in this
> > patch.
> 
> I would like there to be some documentation in this patchset which
> explains the difference between PAGE_SOFT_DIRTY and PAGE_DIRTY_SW.

I will add some comments for the difference between PAGE_SOFT_DIRTY and
PAGE_DIRTY_SW.

Yu-cheng
