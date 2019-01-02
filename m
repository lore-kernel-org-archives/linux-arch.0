Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbfABQDC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 11:03:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so14742922pga.9
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 08:03:01 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 1/2] parisc: remove nargs from __SYSCALL
Date: Wed,  2 Jan 2019 21:32:32 +0530
Message-ID: <1546444953-21630-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
References: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>, Matthew Wilcox <willy@infradead.org>, linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102160232.78i1DNnEp36Am6OQXcSiCQ0TUtj8DJBitSvxh48TUcU@z>

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
 arch/parisc/kernel/syscall.S              | 2 +-
 arch/parisc/kernel/syscalls/syscalltbl.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 4f77bd9..e843151 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -923,7 +923,7 @@ ENTRY(lws_table)
 END(lws_table)
 	/* End of lws table */
 
-#define __SYSCALL(nr, entry, nargs) ASM_ULONG_INSN entry
+#define __SYSCALL(nr, entry)	ASM_ULONG_INSN entry
 	.align 8
 ENTRY(sys_call_table)
 	.export sys_call_table,data
diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/kernel/syscalls/syscalltbl.sh
index 45b5bae..f7393a7 100644
--- a/arch/parisc/kernel/syscalls/syscalltbl.sh
+++ b/arch/parisc/kernel/syscalls/syscalltbl.sh
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
