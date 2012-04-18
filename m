From: Subash Patel <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv8 00/10] ARM: DMA-mapping framework redesign
Date: Wed, 18 Apr 2012 12:44:39 +0530
Message-ID: <4F8E69DF.9030003@gmail.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1334055852-19500-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chunsang Jeong <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hello Marek,

I have tested below patch series for vanilla 3.4-rc2 (without videobuf2 
support for dmabuf patches) with and without IOMMU support on origen 
board. These patches are good now. You can add:

Tested-By: Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> for whole series.

Regards,
Subash

On 04/10/2012 04:34 PM, Marek Szyprowski wrote:
> Hello,
>
> Linux v3.4-rc2, which include dma-mapping preparation patches, has been
> released two days ago, now it's time for the next spin of ARM
> dma-mapping redesign patches. This version includes various fixes posted
> separately to v7, mainly related to incorrect io address space bitmap
> setup and a major issue with broken mmap for memory which comes from
> dma_declare_coherent(). The patches have been also rebased onto Linux
> v3.4-rc2 which comes with dma_map_ops related changes.
>
> The code has been tested on Samsung Exynos4 'UniversalC210' and NURI
> boards with IOMMU driver posted by KyongHo Cho, I will put separate
> branch which shows how to integrate this driver with this patchset.
>
> The patches are also available on my git repository at:
> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git 3.4-rc2-arm-dma-v8
>
>
> History of the development:
>
> v1: (initial version of the DMA-mapping redesign patches):
> http://www.spinics.net/lists/linux-mm/msg21241.html
>
> v2:
> http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000571.html
> http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000577.html
>
> v3:
> http://www.spinics.net/lists/linux-mm/msg25490.html
>
> v4 and v5:
> http://www.spinics.net/lists/arm-kernel/msg151147.html
> http://www.spinics.net/lists/arm-kernel/msg154889.html
>
> v6:
> http://www.spinics.net/lists/linux-mm/msg29903.html
>
> v7:
> http://www.spinics.net/lists/arm-kernel/msg162149.html
>
> Best regards
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
> Patch summary:
>
> Marek Szyprowski (10):
>    common: add dma_mmap_from_coherent() function
>    ARM: dma-mapping: use pr_* instread of printk
>    ARM: dma-mapping: introduce ARM_DMA_ERROR constant
>    ARM: dma-mapping: remove offset parameter to prepare for generic
>      dma_ops
>    ARM: dma-mapping: use asm-generic/dma-mapping-common.h
>    ARM: dma-mapping: implement dma sg methods on top of any generic dma
>      ops
>    ARM: dma-mapping: move all dma bounce code to separate dma ops
>      structure
>    ARM: dma-mapping: remove redundant code and cleanup
>    ARM: dma-mapping: use alloc, mmap, free from dma_ops
>    ARM: dma-mapping: add support for IOMMU mapper
>
>   arch/arm/Kconfig                   |    9 +
>   arch/arm/common/dmabounce.c        |   84 +++-
>   arch/arm/include/asm/device.h      |    4 +
>   arch/arm/include/asm/dma-iommu.h   |   34 ++
>   arch/arm/include/asm/dma-mapping.h |  407 ++++-----------
>   arch/arm/mm/dma-mapping.c          | 1019 ++++++++++++++++++++++++++++++------
>   arch/arm/mm/vmregion.h             |    2 +-
>   drivers/base/dma-coherent.c        |   42 ++
>   include/asm-generic/dma-coherent.h |    4 +-
>   9 files changed, 1138 insertions(+), 467 deletions(-)
>   create mode 100644 arch/arm/include/asm/dma-iommu.h
>
