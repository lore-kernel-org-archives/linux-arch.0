Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:50783 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab0FNMs6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2010 08:48:58 -0400
From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 1/5] vmlinux.lds.h: Include *(.text.*) in TEXT_TEXT
Date: Mon, 14 Jun 2010 13:38:28 +0100
Message-ID: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Tim Abbott <tabbott@ksplice.com>, linux-kernel@vger.kernel.org
Message-ID: <20100614123828.pgkd_iwWH41PYadJbTiAlNVb0a0EKEo-3l18mtLvwFw@z>

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

