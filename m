From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/2] mips: remove nargs from __SYSCALL
Date: Wed,  2 Jan 2019 20:26:17 +0530
Message-ID: <1546440978-19569-2-git-send-email-firoz.khan@linaro.org>
References: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

The __SYSCALL macro's arguments are system call number,
system call entry name and number of arguments for the
system call.

Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
calculated nor used anywhere. So it would be better to
keep the implementaion as  __SYSCALL(nr, entry). This will
unifies the implementation with some other architetures
too.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/kernel/scall32-o32.S          | 2 +-
 arch/mips/kernel/scall64-n32.S          | 2 +-
 arch/mips/kernel/scall64-n64.S          | 2 +-
 arch/mips/kernel/scall64-o32.S          | 2 +-
 arch/mips/kernel/syscalls/syscalltbl.sh | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index d9434cd..b449b68 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -217,7 +217,7 @@ einval: li	v0, -ENOSYS
 #define sys_sched_getaffinity	mipsmt_sys_sched_getaffinity
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
-#define __SYSCALL(nr, entry, nargs)	PTR entry
+#define __SYSCALL(nr, entry) 	PTR entry
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c761ddf..35d8c86 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -101,7 +101,7 @@ not_n32_scall:
 
 	END(handle_sysn32)
 
-#define __SYSCALL(nr, entry, nargs) PTR entry
+#define __SYSCALL(nr, entry)	PTR entry
 	.type	sysn32_call_table, @object
 EXPORT(sysn32_call_table)
 #include <asm/syscall_table_64_n32.h>
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 727fb8a..23b2e2b 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -109,7 +109,7 @@ illegal_syscall:
 	j	n64_syscall_exit
 	END(handle_sys64)
 
-#define __SYSCALL(nr, entry, nargs) PTR entry
+#define __SYSCALL(nr, entry)	PTR entry
 	.align	3
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f158c58..e229155 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -213,7 +213,7 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys32_syscall)
 
-#define __SYSCALL(nr, entry, nargs) PTR entry
+#define __SYSCALL(nr, entry)	PTR entry
 	.align	3
 	.type	sys32_call_table,@object
 EXPORT(sys32_call_table)
diff --git a/arch/mips/kernel/syscalls/syscalltbl.sh b/arch/mips/kernel/syscalls/syscalltbl.sh
index acd338d..1e25707 100644
--- a/arch/mips/kernel/syscalls/syscalltbl.sh
+++ b/arch/mips/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-- 
1.9.1
