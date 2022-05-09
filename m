Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ADEC433EF
	for <linux-arch@archiver.kernel.org>; Mon,  9 May 2022 01:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiEICBp (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 8 May 2022 22:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiEIB4b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 May 2022 21:56:31 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21760433BF;
        Sun,  8 May 2022 18:52:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCc7SF0_1652061151;
Received: from 30.32.96.14(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCc7SF0_1652061151)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 09:52:32 +0800
Message-ID: <31e0001e-5274-742b-0cd9-318f5c2e068f@linux.alibaba.com>
Date:   Mon, 9 May 2022 09:53:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 0/3] Introduce new huge_ptep_get_access_flags()
 interface
To:     Matthew Wilcox <willy@infradead.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
 <Ynf5Aje8FXlPdOSl@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Ynf5Aje8FXlPdOSl@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/9/2022 1:08 AM, Matthew Wilcox wrote:
> On Sun, May 08, 2022 at 04:58:51PM +0800, Baolin Wang wrote:
>> As Mike pointed out [1], the huge_ptep_get() will only return one specific
>> pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
>> will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
>> size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
>> size hugetlb page for those functions that want to check the dirty or
>> young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
>> get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
>> will also get inaccurate access statistics.
>>
>> To fix this issue, one approach is that we can define an ARM64 specific huge_ptep_get()
>> implementation, which will take into account any subpages' dirty or young bits.
>> However we should add a new parameter for ARM64 specific huge_ptep_get() to check
>> how many continuous PTEs or PMDs in this CONT-PTE/PMD size hugetlb, that means we
>> should convert all the places using huge_ptep_get(), meanwhile most places using
>> huge_ptep_get() did not care about the dirty or young flags at all.
>>
>> So instead of changing the prototype of huge_ptep_get(), this patch set introduces
>> a new huge_ptep_get_access_flags() interface and define an ARM64 specific implementation,
>> that will take into account any subpages' dirty or young bits for CONT-PTE/PMD size
>> hugetlb page. And we can only change to use huge_ptep_get_access_flags() for those
>> functions that care about the dirty or young flags of a hugetlb page.
> 
> I question whether this is the right approach.  I understand that
> different hardware implementations have different requirements here,
> but at least one that I'm aware of (AMD Zen 2/3) requires that all
> PTEs that are part of a contig PTE must have identical A/D bits.  Now,
> you could say that's irrelevant because it's x86 and we don't currently
> support contPTE on x86, but I wouldn't be surprised to see that other
> hardware has the same requirement.

Yes, so on x86, we can use the default huge_ptep_get(). But for ARM64, 
unfortunately the A/D bits of a contig PTE is independent, that's why we 
want a ARM64 specific huge_ptep_get().

> So what if we make that a Linux requirement?  Setting a contPTE dirty or
> accessed becomes a bit more expensive (although still one/two cachelines,
> so not really much more expensive than a single write).  Then there's no
> need to change the "get" side of things because they're always identical.
> 
> It does mean that we can't take advantage of hardware setting A/D bits,
> unless hardware can be persuaded to behave this way.  I don't have any
> ARM specs in front of me to check.

I hope the hardware can make sure the contPTE are always identical, 
however in fact like I said the A/D bits setting of a contig PTE by 
hardware is independent in a contig-PTE size hugetlb page, they are not 
always identical.

 From my testing, if I monitored a contig-PTE size hugetlb page with 
DAMON, and I only modified the subpages of the contig-PTE size hugetlb 
page. The result is I can not monitor any accesses, but actually there are.

So I think an ARM64 specific huge_ptep_get() implementation seems the 
right way as Muchun suggested?

Thanks.
