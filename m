From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 34/34] mm: dynamically allocate page->ptl if it cannot be
 embedded to struct page
Date: Mon, 14 Oct 2013 12:04:37 +0300 (EEST)
Message-ID: <20131014090437.F22CBE0090@blue.fi.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1381428359-14843-35-git-send-email-kirill.shutemov@linux.intel.com>
 <00000141a3f48ada-37ee9c14-2f2b-40a2-93f4-70258363351b-000000@email.amazonses.com>
 <20131010200921.91D84E0090@blue.fi.intel.com>
 <00000141a7d2aa7b-e59f292a-746c-4f55-aa51-9fa060a7fbeb-000000@email.amazonses.com>
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42674 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab3JNJEm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Oct 2013 05:04:42 -0400
In-Reply-To: <00000141a7d2aa7b-e59f292a-746c-4f55-aa51-9fa060a7fbeb-000000@email.amazonses.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 10 Oct 2013, Kirill A. Shutemov wrote:
> 
> > Christoph Lameter wrote:
> > > On Thu, 10 Oct 2013, Kirill A. Shutemov wrote:
> > >
> > > > +static inline bool ptlock_alloc(struct page *page)
> > > > +{
> > > > +	if (sizeof(spinlock_t) > sizeof(page->ptl))
> > > > +		return __ptlock_alloc(page);
> > > > +	return true;
> > > > +}
> > >
> > > Could you make the check a CONFIG option? CONFIG_PTLOCK_DOES_NOT_FIT_IN_PAGE_STRUCT or
> > > so?
> >
> > No. We will have to track what affects sizeof(spinlock_t) manually.
> > Not a fun and error prune.
> 
> You can generate a config option depending on the size of the object via
> Kbuild. Kbuild will determine the setting before building the kernel as a
> whole by runing some small C program.

I don't think it's any better than what we have there now.

-- 
 Kirill A. Shutemov
