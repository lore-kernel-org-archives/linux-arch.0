Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0070.outbound.protection.outlook.com ([157.56.110.70]:41568
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753974AbaIHJjc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Sep 2014 05:39:32 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v3 27/29] MAINTAINERS: Add nios2 maintainer
Date: Mon, 8 Sep 2014 17:22:38 +0800
Message-ID: <1410168160-3624-28-git-send-email-lftan@altera.com>
In-Reply-To: <1410168160-3624-1-git-send-email-lftan@altera.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140908092238.bTMnidWyUwMZWUseqF9D0sGzfg3snbLjO5uhDvChG7w@z>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf24bb5..01a509c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6423,6 +6423,13 @@ S:	Maintained
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
 M:	Jon Mason <jon.mason@intel.com>
 S:	Supported
-- 
1.8.2.1

