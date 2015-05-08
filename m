Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:14381 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbbEHPEw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 May 2015 11:04:52 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v11 01/19] MAINTAINERS: Add H8/300 entry
Date: Sat,  9 May 2015 00:04:21 +0900
Message-ID: <1431097479-21101-2-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150508150421.XNxGD9zKdVEzaRF4-jH6NTGD-sieib4F1S1s8hqm7JM@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 CREDITS     |  5 -----
 MAINTAINERS | 10 ++++++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

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
index 781e099..25d6bb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4480,6 +4480,16 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/usb/stk1160/
 
+H8/300 ARCHITECTURE
+M:	Yoshinori Sato <ysato@users.sourceforge.jp>
+L:	uclinux-h8-devel@lists.sourceforge.jp
+W:	http://uclinux-h8.sourceforge.jp
+T:	git git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git
+S:	Maintained
+F:	arch/h8300/
+F:	drivers/clocksource/h8300_*.c
+F:	drivers/clk/h8300/
+
 HARD DRIVE ACTIVE PROTECTION SYSTEM (HDAPS) DRIVER
 M:	Frank Seidel <frank@f-seidel.de>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.1.4

