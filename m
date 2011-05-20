Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.prem.mail.ac4.yahoo.com ([76.13.13.43]:27997 "HELO
	smtp104.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933843Ab1ETOdr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 May 2011 10:33:47 -0400
Date: Fri, 20 May 2011 09:33:44 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] kernel buffer overflow kmalloc_slab() fix
In-Reply-To: <1305892971.2571.16.camel@mulgrave.site>
Message-ID: <alpine.DEB.2.00.1105200932340.5610@router.home>
References: <james_p_freyensee@linux.intel.com>  <1305834712-27805-2-git-send-email-james_p_freyensee@linux.intel.com>  <alpine.DEB.2.00.1105191550001.12530@router.home> <1305892971.2571.16.camel@mulgrave.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: james_p_freyensee@linux.intel.com, linux-mm@kvack.org, gregkh@suse.de, hari.k.kanigeri@intel.com, linux-arch@vger.kernel.org
Message-ID: <20110520143344.wZ3MEn2957oL4XhwhpqcNhGJtq-DzYG47jWwaYGjRLk@z>

On Fri, 20 May 2011, James Bottomley wrote:

> On Thu, 2011-05-19 at 15:51 -0500, Christoph Lameter wrote:
> > On Thu, 19 May 2011, james_p_freyensee@linux.intel.com wrote:
> >
> > > From: J Freyensee <james_p_freyensee@linux.intel.com>
> > >
> > > Currently, kmalloc_index() can return -1, which can be
> > > passed right to the kmalloc_caches[] array, cause a
> >
> > No kmalloc_index() cannot return -1 for the use case that you are
> > considering here. The value passed as a size to
> > kmalloc_slab is bounded by 2 * PAGE_SIZE and kmalloc_slab will only return
> > -1 for sizes > 4M. So we will have to get machines with page sizes > 2M
> > before this can be triggered.
>
> Please don't make x86 centric assumptions like this.  I was vaguely
> thinking about hugepages in parisc.  Like most risc machines, we have
> (and have had for over a decade) a vast number of variable size pages
> (actually from 4k to 64MB in power of 4 steps) and I think sparc is
> similar, so I was wondering what to choose.  You'd have been deeply
> annoyed if I'd chosen 4MB and had slub fall over (again).
>
> linux-arch cc'd just so everyone else is aware of these limitations when
> they implement hugepages.

Well the simple solution would to put a BUG() in kmalloc_slab()
instead of returning -1 (whereupon the compiler will complain that we are
not returning a value). We tried the BUILD_BUG before but some compilers
are not playing ball there.


