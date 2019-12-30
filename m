From: guoren@kernel.org
Subject: [PATCH 1/5] MAINTAINERS: csky: Add mailing list for csky
Date: Mon, 30 Dec 2019 16:23:27 +0800
Message-ID: <20191230082331.30976-1-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add mailing list and it's convenient for maintain C-SKY
subsystem.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f170d8bc29..1b0e8dcefb94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3553,6 +3553,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.17.0
