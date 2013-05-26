From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: mips: ralink: using strlcpy() instead of strncpy()
Date: Sun, 26 May 2013 16:01:46 +0800
Message-ID: <51A1C16A.6050808@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:32762 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759141Ab3EZICh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 May 2013 04:02:37 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ralf@linux-mips.org, blogic@openwrt.org, juhosg@openwrt.org
Cc: linux-mips@linux-mips.org, Linux-Arch <linux-arch@vger.kernel.org>


'compatible' is used by strlen() in __of_device_is_compatible().

So for NUL terminated string, need always be sure of ended by zero.

'of_ids' is not a structure in "include/uapi/*", so not need initialize
all bytes, just use strlcpy() instead of strncpy().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/mips/ralink/of.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index fb15695..508f28f 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -104,7 +104,7 @@ static int __init plat_of_setup(void)
 	if (!of_have_populated_dt())
 		panic("device tree not present");
 
-	strncpy(of_ids[0].compatible, soc_info.compatible, len);
+	strlcpy(of_ids[0].compatible, soc_info.compatible, len);
 	strncpy(of_ids[1].compatible, "palmbus", len);
 
 	if (of_platform_populate(NULL, of_ids, NULL, NULL))
-- 
1.7.7.6
