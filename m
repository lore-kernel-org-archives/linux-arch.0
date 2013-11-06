From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm: create a separate slab for page->ptl allocation
Date: Wed, 6 Nov 2013 15:21:55 +0200
Message-ID: <20131106132155.GA22132@shutemov.name>
References: <1382442839-7458-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20131105150145.734a5dd5b5d455800ebfa0d3@linux-foundation.org>
 <20131105224217.GC20167@shutemov.name>
 <20131105155619.021f32eba1ca8f15a73ed4c9@linux-foundation.org>
 <20131105231310.GE20167@shutemov.name>
 <20131106093131.GU28601@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131106093131.GU28601@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 06, 2013 at 10:31:31AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 06, 2013 at 01:13:11AM +0200, Kirill A. Shutemov wrote:
> > I would like to get rid of __ptlock_alloc()/__ptlock_free() too, but I
> > don't see a way within C: we need to know sizeof(spinlock_t) on
> > preprocessor stage.
> > 
> > We can have a hack on kbuild level: write small helper program to find out
> > sizeof(spinlock_t) before start building and turn it into define.
> > But it's overkill from my POV. And cross-compilation will be a fun.
> 
> Ah, I just remembered, we have such a thing!

Great!

> @@ -1354,7 +1356,7 @@ static inline bool ptlock_init(struct page *page)
>  	 * slab code uses page->slab_cache and page->first_page (for tail
>  	 * pages), which share storage with page->ptl.
>  	 */
> -	VM_BUG_ON(page->ptl);
> +	VM_BUG_ON(*(unsigned long *)&page->ptl);

Huh? Why not direct cast to unsigned long?

VM_BUG_ON((unsigned long)page->ptl);

Otherwise:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
