From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v8 17/17] Add H8/300 entry
Date: Mon, 20 Apr 2015 15:13:33 +0900
Message-ID: <1429510413-14869-18-git-send-email-ysato@users.sourceforge.jp>
References: <1429510413-14869-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429510413-14869-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 CREDITS     |  5 -----
 MAINTAINERS | 11 +++++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/CREDITS b/CREDITS
index 96935df..3bea091 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3194,11 +3194,6 @@ N: Dipankar Sarma
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
index efbcb50..14a2c51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4444,6 +4444,17 @@ T:	git git://linuxtv.org/media_tree.git
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
