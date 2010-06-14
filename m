From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 1/5] vmlinux.lds.h: Include *(.text.*) in TEXT_TEXT
Date: Mon, 14 Jun 2010 13:38:28 +0100
Message-ID: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Tim Abbott <tabbott@ksplice.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Matt Fleming <matthew.fleming@imgtec.com>

Many architectures collect text sections beginning with '.text.' in
their .text section, so move this pattern into TEXT_TEXT to stop them
all having to duplicate the pattern in their arch/ linker scripts.

Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
---
 include/asm-generic/vmlinux.lds.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 48c5299..08f4680 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -369,6 +369,7 @@
 		ALIGN_FUNCTION();					\
 		*(.text.hot)						\
 		*(.text)						\
+		*(.text.*)						\
 		*(.ref.text)						\
 	DEV_KEEP(init.text)						\
 	DEV_KEEP(exit.text)						\
-- 
1.6.6.1
