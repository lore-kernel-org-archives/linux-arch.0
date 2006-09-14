Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:59040 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932069AbWINWh6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Sep 2006 18:37:58 -0400
Subject: [PATCH] [5/5] Fix 'make headers_check' on i386 for 2.6.18
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 23:37:55 +0100
Message-Id: <1158273475.4312.144.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This brings i386 asm/unistd.h into consistency with other architectures
by not exporting functionality which is not necessary.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index d983b74..fc1c8dd 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -324,6 +324,8 @@ #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
 
+#ifdef __KERNEL__
+
 #define NR_syscalls 318
 
 /*
@@ -423,8 +425,6 @@ __asm__ volatile ("push %%ebp ; push %%e
 __syscall_return(type,__res); \
 }
 
-#ifdef __KERNEL__
-
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT

-- 
dwmw2

