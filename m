Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:34290 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbbCVRj4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Mar 2015 13:39:56 -0400
Received: by wegp1 with SMTP id p1so120523632weg.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2015 10:39:55 -0700 (PDT)
Message-ID: <550EFE68.6040007@plexistor.com>
Date: Sun, 22 Mar 2015 19:39:52 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/7] evacuate struct page from the block layer
References: <20150316201640.33102.33761.stgit@dwillia2-desk3.amr.corp.intel.com>	<20150318132650.3336261c58829f49a9af8675@linux-foundation.org>	<20150319134313.GF4003@linux.intel.com>	<550C490E.1080708@redhat.com>	<20150320203136.GM4003@linux.intel.com>	<550C8C47.5090002@redhat.com>	<550EF6B2.70506@plexistor.com> <CAPcyv4ieZjj6senh26BANA4KT54AdrU+O=o8zCAk7W=vA+SjnQ@mail.gmail.com>
In-Reply-To: <CAPcyv4ieZjj6senh26BANA4KT54AdrU+O=o8zCAk7W=vA+SjnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Rik van Riel <riel@redhat.com>, Matthew Wilcox <willy@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-raid <linux-raid@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20150322173952.SrKjSu01FJDWB9MQdxL62ordmmIwCkZ4_WUjlmMl7dY@z>

On 03/22/2015 07:22 PM, Dan Williams wrote:
> On Sun, Mar 22, 2015 at 10:06 AM, Boaz Harrosh <boaz@plexistor.com> wrote:
<>
>>
>> Moving to pfn's only means that all this unnamed code above that
>> "relies on struct page being PAGE_SIZE" is now not allowed to
>> interfaced with bio and sg list. Which in current code and in Dan's patches
>> means two tons of BUG_ONS and return -ENOTSUPP . For all these
>> subsystems below the bio and sglist that operate on page_structs
> 
> I'm not convinced it will be that bad.  In hyperbolic terms,
> continuing to overload struct page means we get to let floppy.c do i/o
> from pmem, who needs that level of compatibility?
> 

But you do need to make sure it does not crash. right?

> Similar to sg_chain support I think it's fine to let sub-systems /
> archs add pmem i/o support over time.  It's a scaling problem our
> development model is good at.
> 

You are so eager to do all this massive change, and willing to do it
over a decade (Judging by your own example of sg-chain)

But you completely ignore the fact that what I'm saying is that
nothing needs to fundamentally change at all. No support over time
and no "scaling problem" at all. All we want to fix is that page-struct
means NOT PAGE_SIZE but some other size.

The much smaller change and full cross Kernel compatibility. What's
not to like ?

Cheers
Boaz

