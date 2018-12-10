From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] asm-generic/ptrace.h: add a comment about frame_pointer
Date: Tue, 11 Dec 2018 00:31:50 +0300
Message-ID: <20181210213150.GA18226@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

I have been misled by comments in asm-generic/ptrace.h into thinking
that frame_pointer() is universally available across architectures,
which resulted in a wrong design decision.

Add a comment about frame_pointer in a hope that it will help others
to avoid this mistake in the future.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/asm-generic/ptrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/ptrace.h b/include/asm-generic/ptrace.h
index 82e674f6b337..3186c30bd50d 100644
--- a/include/asm-generic/ptrace.h
+++ b/include/asm-generic/ptrace.h
@@ -59,6 +59,10 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
 #define SET_FP(regs, val) (GET_FP(regs) = (val))
 #endif
 
+/*
+ * Unlike instruction_pointer and user_stack_pointer,
+ * frame_pointer is not universally available across architectures.
+ */
 static inline unsigned long frame_pointer(struct pt_regs *regs)
 {
 	return GET_FP(regs);
-- 
ldv
