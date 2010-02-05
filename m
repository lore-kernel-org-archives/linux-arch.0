From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 0/4] PIO drivers and cache coherency
Date: Fri, 05 Feb 2010 16:31:43 +0000
Message-ID: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51877 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754090Ab0BEQbp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2010 11:31:45 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o15GVieI005042
	for <linux-arch@vger.kernel.org>; Fri, 5 Feb 2010 16:31:44 GMT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Hi,

There were a couple of threads recently about PIO drivers and cache
coherency for page cache pages. I'll try to quickly summarise some of
the discussions and current API issues and propose some improvements
(please correct if I got it wrong). I'm assuming the key people are on
linux-arch but if I missed anyone please cc them.

In the ARM case, a PIO driver writes the data to a page cache page
dirtying the D-cache. This may cause either aliases with the user
mapping (if the hardware has such thing) or just incoherency with the
I-cache on Harvard architectures.

Two examples are the ISP1760 HCD driver and the libata-sff library for
PIO sector transfers. Without any changes to these drivers, rootfs on a
USB stick or CompactFlash (via pata-platform) cannot be used (it usually
fails in /sbin/init with illegal instruction).

Based on the Documentation/cachetlb.txt document, my first approach was
to use flush_dcache_page() in the corresponding drivers, though with
some drawbacks and this doesn't seem to be a popular choice.

These two examples actually have different ways of accessing the
transfer buffer. The HCD driver receives a pointer via
urb->transfer_buffer while libata-sff uses a page structure.

One of the proposals was to always use the kmap API even if the page
isn't a highmem one (or if the kernel doesn't support highmem) and do
the cache flushing in these functions. There may be performance
penalties with this approach on some architectures and for some drivers
the kmap() is called in upper layers (the HCD case).

Another proposal was to extend the kmap API with information about the
direction of the transfer so that it can be implemented more
efficiently (functions like kmap_pio_*). This approach requires the page
structure to always be available for passing to the kmap_pio_* functions
but that's not possible on HCD devices (and upper layers like USB mass
storage do not know whether the driver is going to use DMA or PIO).

IMHO, what we need is something that resembles the DMA API. Another
opinion (James Bottomley's) is that such API would be closer to the kmap
API. Any other suggestions are welcome.

My proposal is for a PIO mapping API similar to the DMA API that
architectures can implement as they like to deal with such situations.
The first patch is an example specification of such API intended to
start a discussion around it rather than a final proposal.

The second patch is a light-weight ARM implementation of such APIs.  It
is incomplete in the sense that it doesn't do additional checks for
highmem pages (that may be flushed via kunmap_atomic). It also doesn't
deal with D-cache aliasing correctly.

The third and fourth patches show example usages of such API in the HCD
and libata cases.

Regards.


Catalin Marinas (4):
      pio-mapping: Add generic support for PIO mapping API
      pio-mapping: Add ARM support for the PIO mapping API
      pio-mapping: Use the PIO mapping API in libata-sff.c
      pio-mapping: Use the PIO mapping API in the ISP1760 HCD driver


 arch/arm/Kconfig                   |    3 ++
 arch/arm/include/asm/pio-mapping.h |   52 +++++++++++++++++++++++++++++++
 drivers/ata/libata-sff.c           |   10 ++++--
 drivers/usb/host/isp1760-hcd.c     |    9 +++++
 include/linux/pio-mapping.h        |   61 ++++++++++++++++++++++++++++++++++++
 5 files changed, 131 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/pio-mapping.h
 create mode 100644 include/linux/pio-mapping.h

-- 
Catalin
