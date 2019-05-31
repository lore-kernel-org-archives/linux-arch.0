Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfEaTXy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 15:23:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so6783849pff.4
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 12:23:53 -0700 (PDT)
Subject: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
Date: Fri, 31 May 2019 12:12:02 -0700
Message-ID: <20190531191204.4044-4-palmer@sifive.com>
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20190531191202.YbWCymjqtK7TC1jUOOPGmU_FPe426ZFHyP6o4xLnnFU@z>

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/uapi/asm-generic/unistd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..f0f4cad4c416 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -833,8 +833,11 @@ __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 
+#define __NR_fchmodat4 428
+__SYSCALL(__NR_fchmodat4, sys_fchmodat4)
+
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 429
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0
