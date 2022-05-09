Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF9FC433FE
	for <linux-arch@archiver.kernel.org>; Mon,  9 May 2022 01:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiEIBti (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 8 May 2022 21:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiEIBlb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 May 2022 21:41:31 -0400
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3E36172;
        Sun,  8 May 2022 18:37:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCc6dHr_1652060050;
Received: from 30.32.96.14(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCc6dHr_1652060050)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 09:34:11 +0800
Message-ID: <97bb8f7e-38ce-4a21-fb76-4bd040ec00b7@linux.alibaba.com>
Date:   Mon, 9 May 2022 09:34:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 0/3] Introduce new huge_ptep_get_access_flags()
 interface
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
 <YnfhHejDgjgyqEcb@FVFYT0MHHV2J.usts.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YnfhHejDgjgyqEcb@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5/8/2022 11:26 PM, Muchun Song wrote:
> On Sun, May 08, 2022 at 04:58:51PM +0800, Baolin Wang wrote:
>> Hi,
>>
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
> 
> IIUC, we could get the page size by page_size(pte_page(pte)).
> So, how about the following implementation of huge_ptep_get()?
> Does this work for you?
> 
> pte_t huge_ptep_get(pte_t *ptep)
> {
> 	int ncontig, i;
> 	size_t pgsize;
> 	pte_t orig_pte = ptep_get(ptep);
> 
> 	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
> 		return orig_pte;
> 
> 	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
> 
> 	for (i = 0; i < ncontig; i++, ptep++) {
> 		pte_t pte = ptep_get(ptep);
> 
> 		if (pte_dirty(pte))
> 			orig_pte = pte_mkdirty(orig_pte);
> 
> 		if (pte_young(pte))
> 			orig_pte = pte_mkyoung(orig_pte);
> 	}
> 
> 	return orig_pte;
> }

Thanks for your suggestion, and I think this works for me and looks more 
straight forward in case some functions using huge_ptep_get() will care 
about the young or dirty bits in future.

My only concern is that all the functions using huge_ptep_get() will set 
a contPTE dirty or accessed bit, however most functions do not care 
about the dirty and accessed bit, which becomes a bit more expensive for 
them? Also mentioned by Matthew in his comments. Anyway, I still think 
your suggestion is straight forward and I can change in next version if 
no other objections.
