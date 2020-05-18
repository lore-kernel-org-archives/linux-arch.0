From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH v3 1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE
 feature
Date: Mon, 18 May 2020 20:29:39 +0800
Message-ID: <9189159f-0df8-ef9a-5216-adc030856439@huawei.com>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-2-yezhenyu2@huawei.com>
 <20200505101405.GB82424@C02TD0UTHF1T.local>
 <cb9d32b6-a9d8-3737-e69d-df4191b7afa9@huawei.com>
 <4d8cb48c-4f47-d966-f29b-3343bd966c5f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:38482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbgERM3u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 08:29:50 -0400
In-Reply-To: <4d8cb48c-4f47-d966-f29b-3343bd966c5f@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, xiexiangyou@huawei.com, zhangshaokun@hisilicon.com, linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, linux-arm-kernel@lists.infradead.org

Hi Anshuman,

On 2020/5/18 12:22, Anshuman Khandual wrote:
>>>>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>>>>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
>>>> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TLBI_RANGE_SHIFT, 4, 0),
> 
> Hello Zhenyu,
> 
> This is already being added through another patch [1] in a series [2] which primarily
> has cpufeature changes. I will soon update the series making this feature FTR_HIDDEN.
> 
> [1] https://patchwork.kernel.org/patch/11523881/
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=281211
> 
> I am planning to respin the series (V4) based on arm64 tree (for-next/cpufeature). So
> could you please rebase this patch (probably dropping cpufeature related changes) on
> upcoming V4, so that all the changes will be based on arm64 tree (for-next/cpufeature).
> 
> - Anshuman
> 

OK, I will rebase my patch based on your V4.

Zhenyu
