From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH v2 0/5] PIO drivers and cache coherency
Date: Thu, 11 Feb 2010 17:55:10 +0000
Message-ID: <20100211175417.7848.41807.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42984 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755272Ab0BKRzM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Feb 2010 12:55:12 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o1BHtBeI008471
	for <linux-arch@vger.kernel.org>; Thu, 11 Feb 2010 17:55:11 GMT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Hi,

These set of patches is the 2nd attempt at an API for PIO drivers.
Following James' suggestion on a kmap-like API, the pio_* functions no
longer look like the dma_map_* API.

There are situations where the page structure isn't available (the USB
HCD drivers) and I introduced the pio_begin()/pio_end() functions that
take care of the cache flushing.

I added another example for the mmci.c driver that is currently using
flush_dcache_page().

Thanks.


Catalin Marinas (5):
      pio-mapping: Add generic support for PIO mapping API
      pio-mapping: Add ARM support for the PIO mapping API
      pio-mapping: Use the PIO mapping API in libata-sff.c
      pio-mapping: Use the PIO mapping API in the ISP1760 HCD driver
      pio-mapping: Use the PIO mapping API in the MMCI PL18x driver


 arch/arm/Kconfig                   |    3 ++
 arch/arm/include/asm/pio-mapping.h |   66 ++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-sff.c           |    7 +++-
 drivers/mmc/host/mmci.c            |   17 ++++-----
 drivers/mmc/host/mmci.h            |   13 +++++--
 drivers/usb/host/isp1760-hcd.c     |    7 ++++
 include/linux/pio-mapping.h        |   65 +++++++++++++++++++++++++++++++++++
 7 files changed, 164 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/include/asm/pio-mapping.h
 create mode 100644 include/linux/pio-mapping.h

-- 
Catalin
