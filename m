Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35368 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfABPXX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:23:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so14721255pgs.2
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:23:22 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/2] ia64: remove nargs from __SYSCALL
Date: Wed,  2 Jan 2019 20:52:46 +0530
Message-ID: <1546442567-20637-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
References: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102152246.T4VJ2KU2L9bZAmMH9OdCbiodvFHYAKdsc63Km9drhB0@z>

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
 arch/ia64/kernel/entry.S                | 2 +-
 arch/ia64/kernel/syscalls/syscalltbl.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index a9992be..204b56d 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -1426,7 +1426,7 @@ END(ftrace_stub)
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
-#define __SYSCALL(nr, entry, nargs) data8 entry
+#define __SYSCALL(nr, entry)	data8 entry
 	.rodata
 	.align 8
 	.globl sys_call_table
diff --git a/arch/ia64/kernel/syscalls/syscalltbl.sh b/arch/ia64/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/ia64/kernel/syscalls/syscalltbl.sh
+++ b/arch/ia64/kernel/syscalls/syscalltbl.sh
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
