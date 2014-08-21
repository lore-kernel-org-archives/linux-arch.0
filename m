From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] dma-mapping: Provide write-combine allocations
Date: Thu, 21 Aug 2014 12:38:48 +0200
Message-ID: <53F5CC38.7060902@samsung.com>
References: <1403863018-20033-1-git-send-email-thierry.reding@gmail.com>
 <20140801124057.GA19889@ulmo> <20140801151917.GS30282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:51387 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbaHUKiw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Aug 2014 06:38:52 -0400
In-reply-to: <20140801151917.GS30282@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On 2014-08-01 17:19, Russell King - ARM Linux wrote:
> On Fri, Aug 01, 2014 at 02:40:59PM +0200, Thierry Reding wrote:
>> On Fri, Jun 27, 2014 at 11:56:58AM +0200, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Provide an implementation for dma_{alloc,free,mmap}_writecombine() when
>>> the architecture supports DMA attributes.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>> ---
>>> Changes in v2:
>>> - Add a generic dma_mmap_writecombine() function
>>>
>>>   arch/arm/include/asm/dma-mapping.h       | 16 ----------------
>>>   include/asm-generic/dma-mapping-common.h |  8 --------
>>>   include/linux/dma-mapping.h              | 26 ++++++++++++++++++++++++++
>>>   3 files changed, 26 insertions(+), 24 deletions(-)
>> Ping?
> I have no problem with this, but I don't think I can say yes to it; that
> depends whether other people are happy for this to live in
> include/linux/dma-mapping.h.
>
> I guess consent for this change can only come by no one objecting to it
> after several postings.

I will take this patch my dma-mapping-next tree and later send pull request
to Linus, so it will be handled in a similar way as all other changes to
generic dma-mapping subsystem done in last 2 years.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
