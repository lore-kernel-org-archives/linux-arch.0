From: GuanXuetao <gxt@mprc.pku.edu.cn>
Subject: [PATCH 3/6] unicore32: change zImage physical address, though it's PIC codes
Date: Thu, 26 May 2011 11:36:55 +0000
Message-ID: <fdc74810f3d2f8c0835f164197875bf86ce13d55.1306408804.git.gxt@mprc.pku.edu.cn>
References: <cover.1306408804.git.gxt@mprc.pku.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1306408804.git.gxt@mprc.pku.edu.cn>
In-Reply-To: <cover.1306408804.git.gxt@mprc.pku.edu.cn>
References: <cover.1306408804.git.gxt@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com
List-Id: linux-arch.vger.kernel.org

From: Guan Xuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 arch/unicore32/boot/compressed/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/unicore32/boot/compressed/Makefile b/arch/unicore32/boot/compressed/Makefile
index 9537342..b0954a2 100644
--- a/arch/unicore32/boot/compressed/Makefile
+++ b/arch/unicore32/boot/compressed/Makefile
@@ -59,7 +59,7 @@ $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/head.o $(obj)/piggy.o \
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
 # from ROM or Flash must define ZTEXTADDR (preferably via the config)
-ZTEXTADDR	:= 0
+ZTEXTADDR	:= 0x03000000
 ZBSSADDR	:= ALIGN(4)
 
 SEDFLAGS_lds	= s/TEXT_START/$(ZTEXTADDR)/;s/BSS_START/$(ZBSSADDR)/
-- 
1.7.5.2
