From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 1/2] mm: try to detect that page->ptl is in use
Date: Mon, 14 Oct 2013 16:58:33 +0400
Message-ID: <CAMo8BfJV9qHQtCgM9QxMo082yxJNDHRY-kh0VuVUDhNhexXMng@mail.gmail.com>
References: <1381754723-21783-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1381754723-21783-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Chris Zankel <chris@zankel.net>, Christoph Lameter <cl@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Matt Mackall <mpm@selenic.com>, LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 14, 2013 at 4:45 PM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> prep_new_page() initialize page->private (and therefore page->ptl) with
> 0. Make sure nobody took it in use in between allocation of the page and
> page table constructor.
>
> It can happen if arch try to use slab for page table allocation: slab
> code uses page->slab_cache and page->first_page (for tail pages), which
> share storage with page->ptl.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  Documentation/vm/split_page_table_lock | 4 ++++
>  include/linux/mm.h                     | 9 +++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/Documentation/vm/split_page_table_lock b/Documentation/vm/split_page_table_lock
> index e2f617b732..3c54f7dca2 100644
> --- a/Documentation/vm/split_page_table_lock
> +++ b/Documentation/vm/split_page_table_lock
> @@ -53,6 +53,10 @@ There's no need in special enabling of PTE split page table lock:
>  everything required is done by pgtable_page_ctor() and pgtable_page_dtor(),
>  which must be called on PTE table allocation / freeing.
>
> +Make sure the architecture doesn't use slab allocator for page table
> +allacation: slab uses page->slab_cache and page->first_page for its pages.

Typo: allocation.

> +These fields share storage with page->ptl.
> +
>  PMD split lock only makes sense if you have more than two page table
>  levels.
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 658e8b317f..9a4a873b2f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1262,6 +1262,15 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>
>  static inline bool ptlock_init(struct page *page)
>  {
> +       /*
> +        * prep_new_page() initialize page->private (and therefore page->ptl)
> +        * with 0. Make sure nobody took it in use in between.
> +        *
> +        * It can happen if arch try to use slab for page table allocation:
> +        * slab code uses page->slab_cache and page->first_page (for tail
> +        * pages), which share storage with page->ptl.
> +        */
> +       VM_BUG_ON(page->ptl);
>         if (!ptlock_alloc(page))
>                 return false;
>         spin_lock_init(ptlock_ptr(page));
> --
> 1.8.4.rc3
>

-- 
Thanks.
-- Max

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
