From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: mips: kernel: using strlcpy() instead of strncpy()
Date: Sun, 26 May 2013 16:06:06 +0800
Message-ID: <51A1C26E.5000609@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:32774 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221Ab3EZIG5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 26 May 2013 04:06:57 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ralf@linux-mips.org, blogic@openwrt.org, david.daney@cavium.com
Cc: linux-mips@linux-mips.org, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


For NUL terminated string, need always be sure of ended by zero.

Or the next pr_info() will cause issue.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/mips/kernel/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 5712bb5..7e95404 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -30,7 +30,7 @@ __init void mips_set_machine_name(const char *name)
 	if (name == NULL)
 		return;
 
-	strncpy(mips_machine_name, name, sizeof(mips_machine_name));
+	strlcpy(mips_machine_name, name, sizeof(mips_machine_name));
 	pr_info("MIPS: machine is %s\n", mips_get_machine_name());
 }
 
-- 
1.7.7.6
