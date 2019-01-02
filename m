From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/2] sh: remove nargs from __SYSCALL
Date: Wed,  2 Jan 2019 21:07:24 +0530
Message-ID: <1546443445-21075-2-git-send-email-firoz.khan@linaro.org>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
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
 arch/sh/kernel/syscalls/syscalltbl.sh | 4 ++--
 arch/sh/kernel/syscalls_32.S          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/syscalls/syscalltbl.sh b/arch/sh/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/sh/kernel/syscalls/syscalltbl.sh
+++ b/arch/sh/kernel/syscalls/syscalltbl.sh
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
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index 96e9c54..bd1a9c5 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -10,7 +10,7 @@
 #include <linux/sys.h>
 #include <linux/linkage.h>
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 	.data
 ENTRY(sys_call_table)
 #include <asm/syscall_table.h>
-- 
1.9.1
