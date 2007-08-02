Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:3795 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbXHBRkQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2007 13:40:16 -0400
Message-ID: <46B216ED.9090404@shadowen.org>
Date: Thu, 02 Aug 2007 18:39:57 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] vmemmap ppc64: convert VMM_* macros to a real	function
References: <exportbomb.1186045945@pinky>	 <E1IGWwO-0002Yc-8h@hellhawk.shadowen.org> <1186072295.18414.257.camel@localhost>
In-Reply-To: <1186072295.18414.257.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

Dave Hansen wrote:
> On Thu, 2007-08-02 at 10:25 +0100, Andy Whitcroft wrote:
>> +unsigned long __meminit vmemmap_section_start(struct page *page)
>> +{
>> +       unsigned long offset = ((unsigned long)page) -
>> +                                               ((unsigned long)(vmemmap)); 
> 
> Isn't this basically page_to_pfn()?  Can we use it here?

No, as that does direct subtraction of the two pointers.  Our 'page'
here is not guarenteed to be aligned even to a struct page boundary.
When it is not so aligned the subtraction of the pointers is undefined.
 Indeed when you do subtract them when the 'page' is not aligned you get
complete gibberish back and blammo's result.

-apw
