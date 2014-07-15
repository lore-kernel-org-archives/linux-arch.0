Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:22397
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932461AbaGOItA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 04:49:00 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 27/29] MAINTAINERS: Add nios2 maintainer
Date: Tue, 15 Jul 2014 16:45:54 +0800
Message-ID: <1405413956-2772-28-git-send-email-lftan@altera.com>
In-Reply-To: <1405413956-2772-1-git-send-email-lftan@altera.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140715084554.iko6ChMLCOZcbf_Aex7bIn0QQTTNo9ix8tve7thPS3o@z>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e31c874..db2bdf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6350,6 +6350,13 @@ S:	Maintained
 F:	Documentation/scsi/NinjaSCSI.txt
 F:	drivers/scsi/nsp32*
 
+NIOS2 ARCHITECTURE
+M:	Ley Foon Tan <lftan@altera.com>
+L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
+T:	git://git.rocketboards.org/linux-socfpga.git
+S:	Maintained
+F:	arch/nios2/
+
 NTB DRIVER
 M:	Jon Mason <jon.mason@intel.com>
 S:	Supported
-- 
1.8.2.1

