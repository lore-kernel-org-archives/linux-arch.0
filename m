Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:56159 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab2DRAVH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Apr 2012 20:21:07 -0400
Message-ID: <8675ae$5bugqf@wolverine02.qualcomm.com>
From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 10 Nov 2011 21:07:47 +0100
Subject: [PATCH 02/10] hexagon: drop selects of bogus Kconfig symbols
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20111110200747.V2D40yJMlQ_3t-RaXYLkQjWBgRWJK90dvk1_abhFKto@z>

There are no Kconfig symbols named GENERIC_HARDIRQS_NO__DO_IRQ and
GENERIC_HARDIRQS_NO_DEPRECATED. The two select statements for these
symbols are nops. Drop these.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 9059e39..3126fc6 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -18,8 +18,6 @@ config HEXAGON
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	select HAVE_GENERIC_HARDIRQS
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select GENERIC_HARDIRQS_NO_DEPRECATED
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_SHOW
-- 
1.7.1


--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
