Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59520 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756048Ab1DSVwx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Apr 2011 17:52:53 -0400
Subject: Re: slub: fix panic with DISCONTIGMEM
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <alpine.DEB.2.00.1104191633250.23077@router.home>
References: <1303248576.11237.23.camel@mulgrave.site>
	 <alpine.DEB.2.00.1104191633250.23077@router.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Apr 2011 16:52:50 -0500
Message-ID: <1303249970.11237.30.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, "hugh.dickins@tiscali.co.uk" <hugh.dickins@tiscali.co.uk>, Parisc List <linux-parisc@vger.kernel.org>
Message-ID: <20110419215250.sGRL76J4Eey7llBJZ4-t57eA_I-VcdE01AtgRA2Rlwc@z>

On Tue, 2011-04-19 at 16:38 -0500, Christoph Lameter wrote:
> On Tue, 19 Apr 2011, James Bottomley wrote:
> 
> > Slub makes assumptions about page_to_nid() which are violated by
> > DISCONTIGMEM and !NUMA.  This violation results in a panic because
> 
> Fix this by stating correctly by saying "The kernel makes assumptions in
> various subsystems ..."

Slub is a subset of the kernel, so the original wording is a bit more
precise.

> > page_to_nid() can be non-zero for pages in the discontiguous ranges and
> > this leads to a null return by get_node().  The assertion by the
> > maintainer is that DISCONTIGMEM should only be allowed when NUMA is also
> > defined.  However, at least six architectures: alpha, ia64, m32r, m68k,
> 
> That is not what I said. DISCONTIG support needs to be fixed so that the
> core subsystems using page_to_nid() will operate correctly with a !NUMA
> discontig configuration. Core will expect page_to_nid() to only return 0
> on !NUMA.

Well, we can discuss how to proceed going forwards.  The current fact is
that any prior kernel that enables SLUB with DISCONTIGMEM and !NUMA will
eventually go boom when the page allocator returns a page not in the
first pfn array.  That has to be fixed in -stable.  I don't really think
a DISCONTIGMEM re-engineering effort would be the best thing for the
-stable series.

James


