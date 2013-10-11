From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/34] x86: add missed pgtable_pmd_page_ctor/dtor calls
 for preallocated pmds
Date: Fri, 11 Oct 2013 07:50:58 +0200
Message-ID: <20131011055058.GA4838@gmail.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1381428359-14843-2-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1381428359-14843-2-git-send-email-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> I've missed that we preallocate few pmds on pgd_alloc() if X86_PAE
> enabled. Let's add missed constructor/destructor calls.
> 
> I haven't noticed it during testing since prep_new_page() clears
> page->mapping and therefore page->ptl. It's effectively equal to
> spin_lock_init(&page->ptl).
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
