From: guoren@kernel.org
Subject: [PATCH] MAINTAINERS: csky: Add mailing list for csky
Date: Tue,  8 Oct 2019 14:45:08 +0800
Message-ID: <1570517108-29147-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, robh@kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add mailing list and it's convenient for maintain C-SKY
subsystem.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..d8fc16d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3556,6 +3556,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.7.4
