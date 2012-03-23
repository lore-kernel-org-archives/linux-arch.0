From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/2] ARM: dma-mapping: Fix mmap support for coherent buffers
Date: Fri, 23 Mar 2012 13:26:01 +0100
Message-ID: <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
References: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
Sender: owner-linux-mm@kvack.org
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
List-Id: linux-arch.vger.kernel.org

Hello,

This patchset contains patches to fix broken mmap operation for memory
buffers allocated from 'dma_declare_coherent' pool after applying my dma
mapping redesign patches [1]. These issues have been reported by Subash
Patel.

[1] http://thread.gmane.org/gmane.linux.kernel.cross-arch/12819 

Patch summary:

Marek Szyprowski (2):
  common: add dma_mmap_from_coherent() function
  arm: dma-mapping: use dma_mmap_from_coherent()

 arch/arm/mm/dma-mapping.c          |    3 ++
 drivers/base/dma-coherent.c        |   42 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/dma-coherent.h |    4 ++-
 3 files changed, 48 insertions(+), 1 deletions(-)

-- 
1.7.1.569.g6f426

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
