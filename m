Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfHWPB3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 11:01:29 -0400
Date: Fri, 23 Aug 2019 16:01:23 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 1/5] mm: untag user pointers in mmap/munmap/mremap/brk
Message-ID: <20190823150123.okjow4g3mt2znz7c@willie-the-truck>
References: <20190815154403.16473-1-catalin.marinas@arm.com>
 <20190815154403.16473-2-catalin.marinas@arm.com>
 <20190819162851.tncj4wpwf625ofg6@willie-the-truck>
 <20190822164125.acfb97de912996b2b9127c61@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822164125.acfb97de912996b2b9127c61@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Dave P Martin <Dave.Martin@arm.com>
Message-ID: <20190823150123.XxNvSNaUkYd4qeKovyEAOGQ9KazQuqdKmh7RRC0_Q9Y@z>

On Thu, Aug 22, 2019 at 04:41:25PM -0700, Andrew Morton wrote:
> On Mon, 19 Aug 2019 17:28:51 +0100 Will Deacon <will@kernel.org> wrote:
> 
> > On Thu, Aug 15, 2019 at 04:43:59PM +0100, Catalin Marinas wrote:
> > > There isn't a good reason to differentiate between the user address
> > > space layout modification syscalls and the other memory
> > > permission/attributes ones (e.g. mprotect, madvise) w.r.t. the tagged
> > > address ABI. Untag the user addresses on entry to these functions.
> > > 
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > >  mm/mmap.c   | 5 +++++
> > >  mm/mremap.c | 6 +-----
> > >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Andrew -- please can you pick this patch up? I'll take the rest of the
> > series via arm64 once we've finished discussing the wording details.
> > 
> 
> Sure, I grabbed the patch from the v9 series.

Thanks, Andrew.

> But please feel free to include this in the arm64 tree - I'll autodrop
> my copy if this turns up in linux-next.

I'd prefer for this one to go via you so that it can sit with the rest of
the core changes relating to tagged addresses. Obviously please yell if
you run into any issues with it!

Cheers,

Will
