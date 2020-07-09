From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Date: Thu, 9 Jul 2020 17:14:28 +0800
Message-ID: <362990d2-3948-9820-e2d9-aa1ff1c8b068@huawei.com>
References: <20200709091054.1698-1-yezhenyu2@huawei.com>
 <20200709091054.1698-3-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7827 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbgGIJOn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 05:14:43 -0400
In-Reply-To: <20200709091054.1698-3-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On 2020/7/9 17:10, Zhenyu Ye wrote:
> +	/*
> +	 * When cpu does not support TLBI RANGE feature, we flush the tlb
> +	 * entries one by one at the granularity of 'stride'.
> +	 * When cpu supports the TLBI RANGE feature, then:
> +	 * 1. If pages is odd, flush the first page through non-RANGE
> +	 *    instruction;
> +	 * 2. For remaining pages: The minimum range granularity is decided
> +	 *    by 'scale', so we can not flush all pages by one instruction
> +	 *    in some cases.
> +	 *
> +	 * For example, when the pages = 0xe81a, let's start 'scale' from
> +	 * maximum, and find right 'num' for each 'scale':
> +	 *
> +	 *  When scale = 3, we can flush no pages because the minumum
> +	 * range is 2^(5*3 + 1) = 0x10000.
> +	 *  When scale = 2, the minimum range is 2^(5*2 + 1) = 0x800, we can
> +	 * flush 0xe800 pages this time, the num = 0xe800/0x800 - 1 = 0x1c.
> +	 * Remain pages is 0x1a;
> +	 *  When scale = 1, the minimum range is 2^(5*1 + 1) = 0x40, no page
> +	 * can be flushed.
> +	 *  When scale = 0, we flush the remaining 0x1a pages, the num =
> +	 * 0x1a/0x2 - 1 = 0xd.
> +	 *
> +	 * However, in most scenarios, the pages = 1 when flush_tlb_range() is
> +	 * called. Start from scale = 3 or other proper value (such as scale =
> +	 * ilog2(pages)), will incur extra overhead.
> +	 * So increase 'scale' from 0 to maximum, the flush order is exactly
> +	 * opposite to the example.
> +	 */

The comments may be too long, probably should be moved to commit messages.

Thanks,
Zhenyu
