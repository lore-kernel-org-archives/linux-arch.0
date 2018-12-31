From: guoren@kernel.org
Subject: [PATCH 03/14] csky: fixup remove vdsp implement for kernel.
Date: Mon, 31 Dec 2018 23:32:55 +0800
Message-ID: <1546270384-4590-3-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

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
