From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] kernel buffer overflow kmalloc_slab() fix
Date: Fri, 20 May 2011 16:02:51 +0400
Message-ID: <1305892971.2571.16.camel@mulgrave.site>
References: <james_p_freyensee@linux.intel.com>
	 <1305834712-27805-2-git-send-email-james_p_freyensee@linux.intel.com>
	 <alpine.DEB.2.00.1105191550001.12530@router.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44582 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935666Ab1ETMGz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 May 2011 08:06:55 -0400
In-Reply-To: <alpine.DEB.2.00.1105191550001.12530@router.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: james_p_freyensee@linux.intel.com, linux-mm@kvack.org, gregkh@suse.de, hari.k.kanigeri@intel.com, linux-arch@vger.kernel.org

On Thu, 2011-05-19 at 15:51 -0500, Christoph Lameter wrote:
> On Thu, 19 May 2011, james_p_freyensee@linux.intel.com wrote:
> 
> > From: J Freyensee <james_p_freyensee@linux.intel.com>
> >
> > Currently, kmalloc_index() can return -1, which can be
> > passed right to the kmalloc_caches[] array, cause a
> 
> No kmalloc_index() cannot return -1 for the use case that you are
> considering here. The value passed as a size to
> kmalloc_slab is bounded by 2 * PAGE_SIZE and kmalloc_slab will only return
> -1 for sizes > 4M. So we will have to get machines with page sizes > 2M
> before this can be triggered.

Please don't make x86 centric assumptions like this.  I was vaguely
thinking about hugepages in parisc.  Like most risc machines, we have
(and have had for over a decade) a vast number of variable size pages
(actually from 4k to 64MB in power of 4 steps) and I think sparc is
similar, so I was wondering what to choose.  You'd have been deeply
annoyed if I'd chosen 4MB and had slub fall over (again).

linux-arch cc'd just so everyone else is aware of these limitations when
they implement hugepages.

James
