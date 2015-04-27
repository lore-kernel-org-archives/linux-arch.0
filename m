From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v9 17/17] Add H8/300 entry
Date: Mon, 27 Apr 2015 14:35:24 +0900
Message-ID: <1430112924-1134-18-git-send-email-ysato@users.sourceforge.jp>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:60151 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbD0Ffg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2015 01:35:36 -0400
In-Reply-To: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 CREDITS     |  5 -----
 MAINTAINERS | 11 +++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/CREDITS b/CREDITS
index 40cc4bf..e88b597 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3219,11 +3219,6 @@ N: Dipankar Sarma
 E: dipankar@in.ibm.com
 D: RCU
 
-N: Yoshinori Sato
-E: ysato@users.sourceforge.jp
-D: uClinux for Renesas H8/300 (H8300)
-D: http://uclinux-h8.sourceforge.jp/
-
 N: Hannu Savolainen
 E: hannu@opensound.com
 D: Maintainer of the sound drivers until 2.1.x days.
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e5bbc0..3c9c6f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4473,6 +4473,17 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/usb/stk1160/
 
+H8/300 ARCHITECTURE
+M:	Yoshinori Sato <ysato@users.sourceforge.jp>
+L:	uclinux-h8-devel@lists.sourceforge.jp
+W:	http://uclinux-h8.sourceforge.jp
+T:	git git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git
+S:	Maintained
+F:	arch/h8300/
+F:	drivers/clocksource/h8300/
+F:	drivers/clk/clk-h83069.c
+F:	drivers/clk/clk-h8s2678.c
+
 HARD DRIVE ACTIVE PROTECTION SYSTEM (HDAPS) DRIVER
 M:	Frank Seidel <frank@f-seidel.de>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.1.4
