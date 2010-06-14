From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 3/5] mips: Remove *(.text.*) pattern from the linker script
Date: Mon, 14 Jun 2010 13:38:30 +0100
Message-ID: <1276519112-11649-3-git-send-email-matt@console-pimps.org>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Matt Fleming <matthew.fleming@imgtec.com>

Drop the pattern from the linker script because the pattern is now
provided by TEXT_TEXT.

Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
---
 arch/mips/kernel/vmlinux.lds.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index f25df73..f51bca8 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -47,7 +47,6 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
-		*(.text.*)
 		*(.fixup)
 		*(.gnu.warning)
 	} :text = 0
-- 
1.6.6.1
