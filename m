From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 34/34] mm: dynamically allocate page->ptl if it cannot
 be embedded to struct page
Date: Fri, 11 Oct 2013 14:01:43 +0000
Message-ID: <00000141a7d2aa7b-e59f292a-746c-4f55-aa51-9fa060a7fbeb-000000@email.amazonses.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com> <1381428359-14843-35-git-send-email-kirill.shutemov@linux.intel.com> <00000141a3f48ada-37ee9c14-2f2b-40a2-93f4-70258363351b-000000@email.amazonses.com>
 <20131010200921.91D84E0090@blue.fi.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131010200921.91D84E0090@blue.fi.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 10 Oct 2013, Kirill A. Shutemov wrote:

> Christoph Lameter wrote:
> > On Thu, 10 Oct 2013, Kirill A. Shutemov wrote:
> >
> > > +static inline bool ptlock_alloc(struct page *page)
> > > +{
> > > +	if (sizeof(spinlock_t) > sizeof(page->ptl))
> > > +		return __ptlock_alloc(page);
> > > +	return true;
> > > +}
> >
> > Could you make the check a CONFIG option? CONFIG_PTLOCK_DOES_NOT_FIT_IN_PAGE_STRUCT or
> > so?
>
> No. We will have to track what affects sizeof(spinlock_t) manually.
> Not a fun and error prune.

You can generate a config option depending on the size of the object via
Kbuild. Kbuild will determine the setting before building the kernel as a
whole by runing some small C program.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
