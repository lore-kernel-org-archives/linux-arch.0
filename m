Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:38526 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbcEIQzH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2016 12:55:07 -0400
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv6 0/8] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Mon,  9 May 2016 18:43:59 +0200
Message-ID: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160509164359.Sjrp8ZaCq725r-oEBmOGO2rcFYWjuajiKREsJBWjP2c@z>

Hi,

This series tries to solve the problem with DMA with device registers
(MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
recent patch '9575632 (dmaengine: make slave address physical)'
clarifies that DMA slave address provided by clients is the physical
address. This puts the task of mapping the DMA slave address from a
phys_addr_t to a dma_addr_t on the DMA engine.

Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
the same and no special care is needed. However if you have a IOMMU you
need to map the DMA slave phys_addr_t to a dma_addr_t using something
like this.

This series is based on top of and requires the patches from Robin
Murphy in the tag 'arm/io-pgtable' from the iommu repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git

It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling the
ipmmu_ds node in r8a7791.dtsi. I verified operation by interacting with
/dev/mmcblk1 and the serial console which both are devices behind the
iommu.

Furthermore I have audited to the best of my ability all call paths
involved to make sure that the dma_addr_t obtained from
dma_map_resource() to is not used in a way where it would be expected
for the mapping to be RAM (have a struct page). Many thanks to Christoph
Hellwig and Laurent Pinchart for there input in this effort.

  * drivers/dma/sh/rcar-dmac.c
    Once the phys_addr_t is mapped to a dma_addr_t using
    dma_map_resource() it is only used to check that the transferee do not
    cross 4GB boundaries and then only directly written to HW registers.

  * drivers/iommu/iommu.c
    - iommu_map()
      Check that it's align to min page size or return -EINVAL then calls
      domain->ops->map()

  * drivers/iommu/ipmmu-vmsa.c
    - ipmmu_map()
      No logic only calls domain->ops->map()

  * drivers/iommu/io-pgtable-arm.c
    - arm_lpae_map()
      No logic only calls __arm_lpae_map()
    - __arm_lpae_map()
      No logic only calls arm_lpae_init_pte()
    - arm_lpae_init_pte()
      Used to get a pte:
        pte |= pfn_to_iopte(paddr >> data->pg_shift, data);

  * drivers/iommu/io-pgtable-arm-v7s.c
    - arm_v7s_map()
      No logic only calls __arm_v7s_map()
    - __arm_v7s_map()
      No logic only calls arm_v7s_init_pte()
    - arm_v7s_init_pte
      Used to get a pte:
        pte |= paddr & ARM_V7S_LVL_MASK(lvl);

  * ARM dma-mapping
    - dma_unmap_*
      Only valid unmap is dma_unmap_resource() all others are an invalid
      use case.
    - dma_sync_single_*
      Invalid use case, memory that is mapped is device memory
    - dma_common_mmap() and dma_mmap_attrs()
      Invalid use case
    - dma_common_get_sgtable() and dma_get_sgtable_attrs()
      Invalid use case, only for dma_alloc_* allocated memory,
    - dma_mapping_error()
      OK

While working on the dma-debug parts of this series I found an unrelated
issue with drivers/iommu/io-pgtable-arm.c and CONFIG_DMA_API_DEBUG on
the Koelsch. I tried to address this in the thread
https://lkml.org/lkml/2016/5/8/33 , however it turned out my solution
was not the correct one. I have not tried to address this further so
running this series with CONFIG_DMA_API_DEBUG will trigger this warning
but is unrelated to this work.

* Changes since v5
- Add dma-debug work which adds a new mapping type for the resource
  mapping which correctly can be translated to a physical address.
- Drop patches from Robin Murphy since they now are accepted in the
  iommu repository and base the series on that tree instead.
- Add a review tag from Laurent.

* Changes since v4
- Move the mapping from phys_addr_t to dma_addr_t from slave_config to the
  prepare calls. This way we know the direction of the mapping and don't have
  to use DMA_BIDIRECTIONAL. Thanks Vinod for suggesting this.
- To be clear that the data type for slave addresses are changed add a patch
  that only changes the data type to phys_addr_t.
- Fixed up commit messages.

* Changes since v3
- Folded in a fix from Robin to his patch.
- Added a check to make sure dma_map_resource can not be used to map RAM as
  pointed out by Robin. I use BUG_ON to enforce this. It might not be the best
  method but I saw no other good way since DMA_ERROR_CODE might not be defined
  on all platforms.
- Added comment about that DTS changes will disable 2 DMA channels due to a HW
  (?) but in the DMAC.
- Dropped the use of dma_attrs, no longer needed.
- Collected Acked-by and Reviewed-by from Laurent.
- Various indentation fix ups.

* Changes since v2
- Drop patch to add dma_{map,unmap}_page_attrs.
- Add dma_{map,unmap}_resource to handle the mapping without involving a
  'struct page'. Thanks Laurent and Robin for pointing this out.
- Use size instead of address to keep track of if a mapping exist or not
  since addr == 0 is valid. Thanks Laurent.
- Pick up patch from Robin with Laurents ack (hope it's OK for me to
  attach the ack?) to add IOMMU_MMIO.
- Fix bug in rcar_dmac_device_config where the error check where
  inverted.
- Use DMA_BIDIRECTIONAL in rcar_dmac_device_config since we at that
  point can't be sure what direction the mapping is going to be used.

* Changes since v1
- Add and use a dma_{map,unmap}_page_attrs to be able to map the page
  using attributes DMA_ATTR_NO_KERNEL_MAPPING and
  DMA_ATTR_SKIP_CPU_SYNC. Thanks Laurent.
- Drop check if dmac is part of a iommu group or not, let the DMA
  mapping api handle it.
- Move slave configuration data around in rcar-dmac to avoid code
  duplication.
- Fix build issue reported by 'kbuild test robot' regarding phys_to_page
  not availability on some configurations.
- Add DT information for r8a7791.

* Changes since RFC
- Switch to use the dma-mapping api instead of using the iommu_map()
  directly. Turns out the dma-mapper is much smarter then me...
- Dropped the patch to expose domain->ops->pgsize_bitmap from within the
  iommu api.
- Dropped the patch showing how I tested the RFC.

Niklas Söderlund (8):
  dma-mapping: add {map,unmap}_resource to dma_map_ops
  dma-debug: add support for resource mappings
  dma-mapping: add dma_{map,unmap}_resource
  arm: dma-mapping: add {map,unmap}_resource for iommu ops
  dmaengine: rcar-dmac: group slave configuration
  dmaengine: rcar-dmac: add iommu support for slave transfers
  ARM: dts: r8a7790: add iommus to dmac0 and dmac1
  ARM: dts: r8a7791: add iommus to dmac0 and dmac1

 Documentation/DMA-API.txt      |  22 ++++++--
 arch/arm/boot/dts/r8a7790.dtsi |  30 +++++++++++
 arch/arm/boot/dts/r8a7791.dtsi |  30 +++++++++++
 arch/arm/mm/dma-mapping.c      |  63 ++++++++++++++++++++++
 drivers/dma/sh/rcar-dmac.c     | 116 +++++++++++++++++++++++++++++++++--------
 include/linux/dma-debug.h      |  19 +++++++
 include/linux/dma-mapping.h    |  42 +++++++++++++++
 lib/dma-debug.c                |  52 +++++++++++++++++-
 8 files changed, 345 insertions(+), 29 deletions(-)

-- 
2.8.2

