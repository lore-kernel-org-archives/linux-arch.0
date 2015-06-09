From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 24/28] ARCv2: All bits in place, allow ARCv2 builds
Date: Tue, 9 Jun 2015 17:18:24 +0530
Message-ID: <1433850508-26317-25-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33127 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933034AbbFILvg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:51:36 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 1b684595e258..e7cee0a5c56d 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -97,11 +97,10 @@ config ISA_ARCOMPACT
 	help
 	  The original ARC ISA of ARC600/700 cores
 
-### For bisectability, disable ARCv2 support until we have all the bits in place
-#config ISA_ARCV2
-#	bool "ARC ISA v2"
-#	help
-#	  ISA for the Next Generation ARC-HS cores
+config ISA_ARCV2
+	bool "ARC ISA v2"
+	help
+	  ISA for the Next Generation ARC-HS cores
 
 endchoice
 
-- 
1.9.1
