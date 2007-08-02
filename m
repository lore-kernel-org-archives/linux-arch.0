Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:49327 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751228AbXHBTaP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2007 15:30:15 -0400
Date: Thu, 2 Aug 2007 12:30:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 4/4] vmemmap ppc64: convert VMM_* macros to a real function
In-Reply-To: <1186072295.18414.257.camel@localhost>
Message-ID: <Pine.LNX.4.64.0708021229230.7948@schroedinger.engr.sgi.com>
References: <exportbomb.1186045945@pinky>  <E1IGWwO-0002Yc-8h@hellhawk.shadowen.org>
 <1186072295.18414.257.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2 Aug 2007, Dave Hansen wrote:

> On Thu, 2007-08-02 at 10:25 +0100, Andy Whitcroft wrote:
> > 
> > +unsigned long __meminit vmemmap_section_start(struct page *page)
> > +{
> > +       unsigned long offset = ((unsigned long)page) -
> > +                                               ((unsigned long)(vmemmap)); 
> 
> Isn't this basically page_to_pfn()?  Can we use it here?

Nope. He cast page to long.

Its equivalent to 

	page_to_pfn(page) * sizeof(struct page)

