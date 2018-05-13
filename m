From: tip-bot for Masahiro Yamada <tipbot@zytor.com>
Subject: [tip:x86/build] x86/build: Remove no-op macro VMLINUX_SYMBOL()
Date: Sun, 13 May 2018 06:15:47 -0700
Message-ID: <tip-2a7ffe465769bc15cb4a77f6a71e6f071d644068@git.kernel.org>
References: <1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com>
Reply-To: linux-arch@vger.kernel.org, yamada.masahiro@socionext.com,
          hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, linux-arch@vger.kernel.org, yamada.masahiro@socionext.com, tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Commit-ID:  2a7ffe465769bc15cb4a77f6a71e6f071d644068
Gitweb:     https://git.kernel.org/tip/2a7ffe465769bc15cb4a77f6a71e6f071d644068
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Wed, 9 May 2018 16:49:34 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:11:34 +0200

x86/build: Remove no-op macro VMLINUX_SYMBOL()

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for x86-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch <linux-arch@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com

---
 arch/x86/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 795f3a80e576..5e1458f609a1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -117,11 +117,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
+		__entry_trampoline_start = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
+		__entry_trampoline_end = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
