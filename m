From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 71/71] ARC: Add self to MAINTAINERS
Date: Thu, 24 Jan 2013 16:36:29 +0530
Message-ID: <1359025589-22277-46-git-send-email-vgupta@synopsys.com>
References: <1359025589-22277-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:34248 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123Ab3AXLOm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jan 2013 06:14:42 -0500
In-Reply-To: <1359025589-22277-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3105c48..05cdc99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7418,6 +7418,12 @@ F:	lib/swiotlb.c
 F:	arch/*/kernel/pci-swiotlb.c
 F:	include/linux/swiotlb.h
 
+SYNOPSYS ARC ARCHITECTURE
+M:	Vineet Gupta <vgupta@synopsys.com>
+L:	linux-snps-arc@vger.kernel.org
+S:	Supported
+F:	arch/arc/
+
 SYSV FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 S:	Maintained
-- 
1.7.4.1
