From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v5 27/29] MAINTAINERS: Add nios2 maintainer
Date: Fri, 24 Oct 2014 16:24:29 +0800
Message-ID: <1414139071-3818-28-git-send-email-lftan@altera.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0056.outbound.protection.outlook.com ([157.56.110.56]:25760
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932317AbaJXI0y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Oct 2014 04:26:54 -0400
In-Reply-To: <1414139071-3818-1-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9b..3179a0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6525,6 +6525,13 @@ S:	Maintained
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
1.8.2.1
