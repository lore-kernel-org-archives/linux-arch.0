Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPd7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Dec 2018 10:33:59 -0500
From: guoren@kernel.org
Subject: [PATCH 03/14] csky: fixup remove vdsp implement for kernel.
Date: Mon, 31 Dec 2018 23:32:55 +0800
Message-ID: <1546270384-4590-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20181231153255.cRuVbnKq9Ai7Go7Be6Gw26HTVCDcZ5gH-7OuJ7x-pMA@z>

From: Guo Ren <ren_guo@c-sky.com>

The vr regs for vdsp only saved in task_switch not in every
exception trap-in. The memcpy with vdsp instructions will
destroy the vr regs for user space applications.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv2/memcpy.S | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/csky/abiv2/memcpy.S b/arch/csky/abiv2/memcpy.S
index 987fec6..145bf3a 100644
--- a/arch/csky/abiv2/memcpy.S
+++ b/arch/csky/abiv2/memcpy.S
@@ -27,13 +27,7 @@ ENTRY(memcpy)
 
 	LABLE_ALIGN
 .L_len_larger_16bytes:
-#if defined(__CSKY_VDSPV2__)
-	vldx.8	vr0, (r1), r19
-	PRE_BNEZAD (r18)
-	addi	r1, 16
-	vstx.8	vr0, (r0), r19
-	addi	r0, 16
-#elif defined(__CK860__)
+#if defined(__CK860__)
 	ldw	r3, (r1, 0)
 	stw	r3, (r0, 0)
 	ldw	r3, (r1, 4)
-- 
2.7.4
