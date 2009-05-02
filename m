From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 13/35] parisc: create ptemap.h
Date: Sat, 02 May 2009 14:45:59 -0700
Message-ID: <1241300759.9131.4.camel@localhost.localdomain>
References: <20090501144201.D31EF417@kernel>
	 <20090501144221.4C7F3D79@kernel>
	 <20090502142939.GD28342@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60173 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbZEBVqB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 May 2009 17:46:01 -0400
In-Reply-To: <20090502142939.GD28342@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2009-05-02 at 10:29 -0400, Kyle McMartin wrote:
> On Fri, May 01, 2009 at 07:42:21AM -0700, Dave Hansen wrote:
> > +#ifndef _PARISC_ASM_PTEMAP_H
> > +#define _PARISC_ASM_PTEMAP_H
> > +
> > +#define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
> > +#define pte_offset_map_nested(pmd, address) pte_offset_kernel(pmd, address)
> > +#define pte_unmap(pte) do { } while (0)
> > +#define pte_unmap_nested(pte) do { } while (0)
> > +
> > +#define pte_unmap(pte)			do { } while (0)
> > +#define pte_unmap_nested(pte)		do { } while (0)
> > +
> > +#endif /* _PARISC_ASM_PTEMAP_H */
> 
> You have duplicate definitiosn of pte_unmap{,_nested}?

Heh.  I actually just copied this verbatim from the existing parisc
header.  It already had a duplicate. :)

Anyway, I've made sure not to copy the dup and added a note in the patch
description so that it is much more clear.  I'll show up in the next
post.  Thanks for the review!

-- Dave
