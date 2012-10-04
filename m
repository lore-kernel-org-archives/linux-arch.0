From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/8] sparc64: Eliminate PTE table memory wastage.
Date: Thu, 04 Oct 2012 14:20:03 -0400 (EDT)
Message-ID: <20121004.142003.851528112593506369.davem@davemloft.net>
References: <20121002.182642.49574627747120711.davem@davemloft.net>
	<87y5jmfbd3.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44469 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab2JDSUG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Oct 2012 14:20:06 -0400
In-Reply-To: <87y5jmfbd3.fsf@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: aneesh.kumar@linux.vnet.ibm.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, aarcange@redhat.com, hannes@cmpxchg.org

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 04 Oct 2012 22:00:48 +0530

> David Miller <davem@davemloft.net> writes:
> 
>> We've split up the PTE tables so that they take up half a page instead
>> of a full page.  This is in order to facilitate transparent huge page
>> support, which works much better if our PMDs cover 4MB instead of 8MB.
>>
>> What we do is have a one-behind cache for PTE table allocations in the
>> mm struct.
>>
>> This logic triggers only on allocations.  For example, we don't try to
>> keep track of free'd up page table blocks in the style that the s390
>> port does.
> 
> I am also implementing a similar change for powerpc. We have a 64K page
> size, and want to make sure PMD cover 16MB, which is the huge page size
> supported by the hardware. I was looking at using the s390 logic,
> considering we have 16 PMDs mapping to same PTE page. Should we look at
> generalizing the case so that other architectures can start using the
> same code ?

I think until we have multiple cases we won't know what's common or not.

Each arch has different need.  I need to split the page into two pieces
so my code is simpler, and juse uses page counting to manage alloc/free.

Whereas s390 uses an bitmask to manage page state, and also reclaims
pgtable pages into a per-mm list on free.  I decided not to do that
and to just let the page allocator do the work.

So I don't think it's appropriate to think about commonization at this
time, as even the only two cases existing are very non-common :-)
