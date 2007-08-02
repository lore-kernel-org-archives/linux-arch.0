Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:36996 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbXHBQbk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Aug 2007 12:31:40 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72GVduf017110
	for <linux-arch@vger.kernel.org>; Thu, 2 Aug 2007 12:31:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l72GVdMc531648
	for <linux-arch@vger.kernel.org>; Thu, 2 Aug 2007 12:31:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l72GVcvN002888
	for <linux-arch@vger.kernel.org>; Thu, 2 Aug 2007 12:31:39 -0400
Subject: Re: [PATCH 4/4] vmemmap ppc64: convert VMM_* macros to a real
	function
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <E1IGWwO-0002Yc-8h@hellhawk.shadowen.org>
References: <exportbomb.1186045945@pinky>
	 <E1IGWwO-0002Yc-8h@hellhawk.shadowen.org>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 09:31:35 -0700
Message-Id: <1186072295.18414.257.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-08-02 at 10:25 +0100, Andy Whitcroft wrote:
> 
> +unsigned long __meminit vmemmap_section_start(struct page *page)
> +{
> +       unsigned long offset = ((unsigned long)page) -
> +                                               ((unsigned long)(vmemmap)); 

Isn't this basically page_to_pfn()?  Can we use it here?

-- Dave

