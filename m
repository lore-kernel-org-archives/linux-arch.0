From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 08/10] ARM: dma-mapping: remove redundant code and cleanup
Date: Tue, 10 Apr 2012 12:22:23 +0000
Message-ID: <201204101222.23522.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com> <1334055852-19500-9-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1334055852-19500-9-git-send-email-m.szyprowski@samsung.com>
Sender: owner-linux-mm@kvack.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> 
> This patch just performs a global cleanup in DMA mapping implementation
> for ARM architecture. Some of the tiny helper functions have been moved
> to the caller code, some have been merged together.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
