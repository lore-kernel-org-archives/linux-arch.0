From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 27/28] MAINTAINERS: Add nios2 maintainer
Date: Fri, 18 Apr 2014 20:27:10 +0800
Message-ID: <1397824031-4892-24-git-send-email-lftan@altera.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0132.outbound.protection.outlook.com ([157.56.111.132]:7334
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753123AbaDRMnP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2014 08:43:15 -0400
In-Reply-To: <1397824031-4892-1-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80399ff..389f3d5315b69660060f34617df402e27323c543 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6247,6 +6247,13 @@ S:	Maintained
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
1.8.3.2
