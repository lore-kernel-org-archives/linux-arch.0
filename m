Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:44596 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbZCDORb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2009 09:17:31 -0500
Date: Wed, 4 Mar 2009 23:17:23 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] generic debug pagealloc
Message-ID: <20090304141721.GC7168@localhost.localdomain>
References: <20090303160103.GB5812@localhost.localdomain> <20090303133610.cb771fef.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <20090303133610.cb771fef.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20090304141723.5lmJDDMh9j5OoFK0rF1tTpYGQUGbk8hmJNjuBheYJfo@z>

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
