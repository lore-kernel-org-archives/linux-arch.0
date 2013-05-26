From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: mips: lantiq: using strlcpy() instead of strncpy()
Date: Sun, 26 May 2013 15:51:49 +0800
Message-ID: <51A1BF15.7070905@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:39418 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136Ab3EZHwl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 May 2013 03:52:41 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ralf@linux-mips.org, blogic@openwrt.org
Cc: linux-mips@linux-mips.org, Linux-Arch <linux-arch@vger.kernel.org>


'compatible' is used by strlen() in __of_device_is_compatible().

So for NUL terminated string, need always be sure of ended by zero.

'of_ids' is not a structure in "include/uapi/*", so not need initialize
all bytes, just use strlcpy() instead of strncpy().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/mips/lantiq/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 9f9e875..49c4603 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -112,7 +112,7 @@ int __init plat_of_setup(void)
 	if (!of_have_populated_dt())
 		panic("device tree not present");
 
-	strncpy(of_ids[0].compatible, soc_info.compatible,
+	strlcpy(of_ids[0].compatible, soc_info.compatible,
 		sizeof(of_ids[0].compatible));
 	strncpy(of_ids[1].compatible, "simple-bus",
 		sizeof(of_ids[1].compatible));
-- 
1.7.7.6
