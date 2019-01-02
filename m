Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37787 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbfABPHd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:07:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so15300708pfb.4
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:07:32 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/2] alpha: remove nargs from __SYSCALL
Date: Wed,  2 Jan 2019 20:36:58 +0530
Message-ID: <1546441619-19977-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
References: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102150658.9eqBeGeoSGEDON8NySyKW8meQH1GloK18yogTX2FJ9w@z>

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
 arch/alpha/kernel/syscalls/syscalltbl.sh | 4 ++--
 arch/alpha/kernel/systbls.S              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscalltbl.sh b/arch/alpha/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/alpha/kernel/syscalls/syscalltbl.sh
+++ b/arch/alpha/kernel/syscalls/syscalltbl.sh
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
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 9704f22..36c94c8 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -7,7 +7,7 @@
 
 #include <asm/unistd.h>
 
-#define __SYSCALL(nr, entry, nargs) .quad entry
+#define __SYSCALL(nr, entry)	.quad entry
 	.data
 	.align 3
 	.globl sys_call_table
-- 
1.9.1
