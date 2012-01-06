Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:6422 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab2AFMrs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2012 07:47:48 -0500
From: Ravi Kumar V <kumarrav@codeaurora.org>
Subject: [PATCH v2 0/2] Add Qualcomm MSM ADM DMAEngine driver
Date: Fri,  6 Jan 2012 18:17:30 +0530
Message-ID: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, linux@arm.linux.org.uk, tsoni@qualcomm.com, johlstei@qualcomm.com, Ravi Kumar V <kumarrav@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20120106124730.AD3LZtJrIMnfg_y_ytlZNIXWUf_cwWZkk4x5AwkL4fM@z>

Following are the changes we have done from the previous
v1 posted here: https://lkml.org/lkml/2011/12/22/148 

As our ADM Scatter-gather hardware needs
-32-bit command configuration parameter
 apart from 
-32-bit source address
-32-bit destination address
-16-bit length

So,we have added new parameter in struct scatterlist to support xfer descriptor
specific private data, and for supporting ADM Box mode DMA we added new
API and data structure.
  
Ravi Kumar V (2):
  dmaengine: Add support for per xfer specific privatedata & box dma
  msm: DMAEngine: Add DMAEngine driver based on old MSM DMA APIs

 arch/arm/mach-msm/include/mach/dma.h |   33 ++
 drivers/dma/Kconfig                  |   12 +
 drivers/dma/Makefile                 |    1 +
 drivers/dma/msm-dma.c                |  764 ++++++++++++++++++++++++++++++++++
 include/asm-generic/scatterlist.h    |    1 +
 include/linux/dmaengine.h            |   17 +-
 6 files changed, 827 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dma/msm-dma.c

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

