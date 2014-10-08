From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v4 27/29] MAINTAINERS: Add nios2 maintainer
Date: Wed, 8 Oct 2014 17:29:53 +0800
Message-ID: <1412760595-3935-28-git-send-email-lftan@altera.com>
References: <1412760595-3935-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412760595-3935-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a12edf2..580499e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6421,6 +6421,13 @@ S:	Maintained
 F:	Documentation/scsi/NinjaSCSI.txt
 F:	drivers/scsi/nsp32*
 
+NIOS2 ARCHITECTURE
+M:	Ley Foon Tan <lftan@altera.com>
+L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
+T:	git git://git.rocketboards.org/linux-socfpga.git
+S:	Maintained
+F:	arch/nios2/
+
 NTB DRIVER
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
-- 
1.7.7.4
