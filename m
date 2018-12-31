From: guoren@kernel.org
Subject: [PATCH 02/14] csky: bugfix gdb coredump error.
Date: Mon, 31 Dec 2018 23:32:54 +0800
Message-ID: <1546270384-4590-2-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

In gdb/bfd elf32-csky.c, csky_elf_grok_prstatus() use fixed size of
elf_prstatus. It's 148 for abiv1 and 220 for abiv2, the size is enough
for coredump and no need full sizeof(struct pt_regs).

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Lu Baoquan <lu.baoquan@intellif.com>
Reported-by: Liu Mao <liu.mao@intellif.com>
---
 arch/csky/include/asm/elf.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/elf.h b/arch/csky/include/asm/elf.h
index 48b5366..d6dbc00 100644
--- a/arch/csky/include/asm/elf.h
+++ b/arch/csky/include/asm/elf.h
@@ -31,7 +31,12 @@ typedef unsigned long elf_greg_t;
 
 typedef struct user_fp elf_fpregset_t;
 
-#define ELF_NGREG (sizeof(struct pt_regs) / sizeof(elf_greg_t))
+/*
+ * In gdb/bfd elf32-csky.c, csky_elf_grok_prstatus() use fixed size of
+ * elf_prstatus. It's 148 for abiv1 and 220 for abiv2, the size is enough
+ * for coredump and no need full sizeof(struct pt_regs).
+ */
+#define ELF_NGREG ((sizeof(struct pt_regs) / sizeof(elf_greg_t)) - 2)
 
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
-- 
2.7.4
