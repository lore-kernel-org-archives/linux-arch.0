From: <Vineet.Gupta1@synopsys.com>
Subject: [RFC Patch v1 55/55] ARC: Add self to MAINTAINERS
Date: Mon, 12 Nov 2012 17:19:13 +0530
Message-ID: <1352720953-24321-25-git-send-email-vgupta@synopsys.com>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352720953-24321-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, arnd@arndb.de, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fa9074..e933489 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7073,6 +7073,12 @@ F:	lib/swiotlb.c
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
