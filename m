Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46573 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfABP3W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:29:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so14625998ply.13
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:29:22 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
Date: Wed,  2 Jan 2019 20:58:31 +0530
Message-ID: <1546442912-20818-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102152831.iA0wwhnWNiTiIPNMoVy7rEmdqNHZR2ebH8wvsr4GFMM@z>

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
 arch/xtensa/kernel/syscall.c              | 2 +-
 arch/xtensa/kernel/syscalls/syscalltbl.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 2c415fc..0665339 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -31,7 +31,7 @@
 syscall_t sys_call_table[__NR_syscalls] /* FIXME __cacheline_aligned */= {
 	[0 ... __NR_syscalls - 1] = (syscall_t)&sys_ni_syscall,
 
-#define __SYSCALL(nr, entry, nargs)[nr] = (syscall_t)entry,
+#define __SYSCALL(nr, entry)[nr] = (syscall_t)entry,
 #include <asm/syscall_table.h>
 #undef __SYSCALL
 };
diff --git a/arch/xtensa/kernel/syscalls/syscalltbl.sh b/arch/xtensa/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/xtensa/kernel/syscalls/syscalltbl.sh
+++ b/arch/xtensa/kernel/syscalls/syscalltbl.sh
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
