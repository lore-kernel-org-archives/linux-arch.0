Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44527 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab2CVN7u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2012 09:59:50 -0400
Message-ID: <4F6B304E.5010402@gmail.com>
Date: Thu, 22 Mar 2012 19:29:42 +0530
From: Subash Patel <subashrp@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com> <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com> <CAHQjnOO5DLOj8Fw=ZriSnXg8W3k7y8Dnu--Peqe6JJX0xGMhoQ@mail.gmail.com> <4F688B2D.20808@gmail.com> <CAHQjnOMjSPDOymJe356AWnJszQv+X-QWrVrB7ahYDkXBr5HrQw@mail.gmail.com>
In-Reply-To: <CAHQjnOMjSPDOymJe356AWnJszQv+X-QWrVrB7ahYDkXBr5HrQw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Krishna Reddy <vdumpa@nvidia.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>
Message-ID: <20120322135942.KG0MDdsaGrFQ55ucvtma50gjSSKzzwoXdip7ZKrPrG0@z>

Hi KyongHo,

On 03/21/2012 05:26 AM, KyongHo Cho wrote:
> On Tue, Mar 20, 2012 at 10:50 PM, Subash Patel<subashrp@gmail.com>  wrote:
>> Sorry for digging this very late. But as part of integrating dma_map v7&
>> sysmmu v12 on 3.3-rc5, I am facing below issue:
>>
>> a) By un-selecting IOMMU in menu config, I am able to allocate memory in
>> vb2-dma-contig
>>
>> b) When I enable SYSMMU support for the IP's, I am receiving below fault:
>>
>> Unhandled fault: external abort on non-linefetch (0x818) at 0xb6f55000
>>
>> I think this has something to do with the access to the SYSMMU registers for
>> writing the page table. Has anyone of you faced this issue while testing
>> these(dma_map+iommu) patches on kernel mentioned above? This must be
>> something related to recent changes, as I didn't have issues with these
>> patches on 3.2 kernel.
>>
>
> 0xb6f55000 is not an address of SYSMMU register if your kernel starts
> at 0xc0000000.
>
> Can you tell me any detailed information or situation?
I hate to say this, but I am not able to catch the fault location even 
with JTAG. Once the fault comes, the debugger looses all control over. I 
think now possible method is reproduction at your end :)
>
> Regards,
>
> KyongHo.
Regards,
Subash
