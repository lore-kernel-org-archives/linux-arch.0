From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: New helper to free highmem pages in larger chunks
Date: Tue, 6 Oct 2015 05:35:57 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075D781AB03@IN01WEMBXB.internal.synopsys.com>
References: <560FD031.3030909@synopsys.com>
 <20151005150955.3e1da261449ae046e1be3989@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:39451 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbJFFgd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2015 01:36:33 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Robin Holt <robin.m.holt@gmail.com>, Nathan Zimmer <nzimmer@sgi.com>, Jiang Liu <liuj97@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>

On Tuesday 06 October 2015 03:40 AM, Andrew Morton wrote:
> On Sat, 3 Oct 2015 18:25:13 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
>> Hi,
>>
>> I noticed increased boot time when enabling highmem for ARC. Turns out that
>> freeing highmem pages into buddy allocator is done page at a time, while it is
>> batched for low mem pages. Below is call flow.
>>
>> I'm thinking of writing free_highmem_pages() which takes start and end pfn and
>> want to solicit some ideas whether to write it from scratch or preferably call
>> existing __free_pages_memory() to reuse the logic to convert a pfn range into
>> {pfn, order} tuples.
>>
>> For latter however there are semantical differences as you can see below which I'm
>> not sure of:
>>   -highmem page->count is set to 1, while 0 for low mem
> That would be weird.
>
> Look more closely at __free_pages_boot_core() - it uses
> set_page_refcounted() to set the page's refcount to 1.  Those
> set_page_count() calls look superfluous to me.

If you closer still, set_page_refcounted() is called outside the loop for the
first page only. For all pages, loop iterator sets them to 1. Turns out there's
more fun here....

I ran this under a debugger and much earlier in boot process, there's existing
setting of page count to 1 for *all* pages of *all* zones (include highmem pages).
See call flow below.

free_area_init_node
    free_area_init_core
        loops thru all zones
            memmap_init_zone
               loops thru all pages of zones
               __init_single_page

This means the subsequent setting of page count to 0 (or 1 for the special first
page) is superfluous - actually buggy at best. I will send a patch to fix that. I
hope I don't break some obscure init path which doesn't hit the above init.


>
>>   -atomic clearing of page reserved flag vs. non atomic
> I doubt if the atomic is needed - who else can be looking at this page
> at this time?

I'll send another one to separately fix that as well. Seems like boot mem setup is
a relatively neglect part of kernel.

-Vineet
