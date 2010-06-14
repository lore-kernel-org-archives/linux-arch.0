From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 4/5] parisc: Remove *(.text.*) pattern from the linker script
Date: Mon, 14 Jun 2010 13:38:31 +0100
Message-ID: <1276519112-11649-4-git-send-email-matt@console-pimps.org>
References: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276519112-11649-1-git-send-email-matt@console-pimps.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Matt Fleming <matthew.fleming@imgtec.com>

Drop the pattern from the linker script because the pattern is now
provided by TEXT_TEXT.

Signed-off-by: Matt Fleming <matthew.fleming@imgtec.com>
---
 arch/parisc/kernel/vmlinux.lds.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index d64a6bb..6784e39 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -61,7 +61,6 @@ SECTIONS
 		*(.text.sys_exit)
 		*(.text.do_sigaltstack)
 		*(.text.do_fork)
-		*(.text.*)
 		*(.fixup)
 		*(.lock.text)		/* out-of-line lock text */
 		*(.gnu.warning)
-- 
1.6.6.1
