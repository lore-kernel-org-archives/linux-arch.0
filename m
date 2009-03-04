From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] generic debug pagealloc
Date: Wed, 4 Mar 2009 23:17:23 +0900
Message-ID: <20090304141721.GC7168@localhost.localdomain>
References: <20090303160103.GB5812@localhost.localdomain> <20090303133610.cb771fef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20090303133610.cb771fef.akpm@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 03, 2009 at 01:36:10PM -0800, Andrew Morton wrote:
> Alternatively, we could just not do the kmap_atomic() at all.  i386
> won't be using this code and IIRC the only other highmem architecture
> is powerpc32, and ppc32 appears to also have its own DEBUG_PAGEALLOC
> implementation.  So you could remove the kmap_atomic() stuff and put
> 
> #ifdef CONFIG_HIGHMEM
> #error i goofed
> #endif
> 
> in there.

I'll take the variant of this. Then poison_page() will be

static void poison_page(struct page *page)
{
        void *addr;

        if (PageHighmem(page))
                return; // i goofed

       page->poison = true;
       addr = page_address(page);
       memset(addr, PAGE_POISON, PAGE_SIZE);
}

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
