From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Wed, 21 Mar 2012 08:56:51 +0900
Message-ID: <CAHQjnOMjSPDOymJe356AWnJszQv+X-QWrVrB7ahYDkXBr5HrQw@mail.gmail.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
	<1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
	<CAHQjnOO5DLOj8Fw=ZriSnXg8W3k7y8Dnu--Peqe6JJX0xGMhoQ@mail.gmail.com>
	<4F688B2D.20808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F688B2D.20808@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Subash Patel <subashrp@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Shariq Hasnain <shariq.hasnain@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Krishna Reddy <vdumpa@nvidia.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 20, 2012 at 10:50 PM, Subash Patel <subashrp@gmail.com> wrote:
> Sorry for digging this very late. But as part of integrating dma_map v7 &
> sysmmu v12 on 3.3-rc5, I am facing below issue:
>
> a) By un-selecting IOMMU in menu config, I am able to allocate memory in
> vb2-dma-contig
>
> b) When I enable SYSMMU support for the IP's, I am receiving below fault:
>
> Unhandled fault: external abort on non-linefetch (0x818) at 0xb6f55000
>
> I think this has something to do with the access to the SYSMMU registers for
> writing the page table. Has anyone of you faced this issue while testing
> these(dma_map+iommu) patches on kernel mentioned above? This must be
> something related to recent changes, as I didn't have issues with these
> patches on 3.2 kernel.
>

0xb6f55000 is not an address of SYSMMU register if your kernel starts
at 0xc0000000.

Can you tell me any detailed information or situation?

Regards,

KyongHo.
