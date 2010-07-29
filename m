From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 2/2] PCI: add PCI DMA unamp state API to feature-removal-schedule.txt
Date: Thu, 29 Jul 2010 19:45:08 +0900
Message-ID: <1280400308-16114-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1280400308-16114-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280400308-16114-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, fujita.tomonori@lab.ntt.co.jp
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

It was replaced with the DMA unamp state API (which can be used for
any bus).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 887c668..23a8f8d 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -532,3 +532,12 @@ Why:	superseded by acpi_sleep=nonvs
 Who:	Rafael J. Wysocki <rjw@sisk.pl>
 
 ----------------------------
+
+What: 	PCI DMA unmap state API
+When:	August 2012
+Why:	PCI DMA unmap state API (include/linux/pci-dma.h) was replaced
+	with DMA unmap state API (DMA unmap state API can be used for
+	any bus).
+Who:	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
+
+----------------------------
-- 
1.6.5
