From: guoren@kernel.org
Subject: [PATCH] csky: Fixup libgcc unwind error
Date: Wed, 26 Jun 2019 13:51:36 +0800
Message-ID: <1561528296-27444-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Mao Han <han_mao@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The struct rt_sigframe is also defined in libgcc/config/csky/linux-unwind.h
of gcc. Although there is no use for the first three word space, we must
keep them the same with linux-unwind.h for member position.

The BUG is found in glibc test with the tst-cancel02.
The BUG is from commit:bf2416829362 of linux-5.2-rc1 merge window.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 04a43cf..d47a338 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -39,6 +39,11 @@ static int save_fpu_state(struct sigcontext __user *sc)
 #endif
 
 struct rt_sigframe {
+	/*
+	 * pad[3] is compatible with the same struct defined in
+	 * gcc/libgcc/config/csky/linux-unwind.h
+	 */
+	int pad[3];
 	struct siginfo info;
 	struct ucontext uc;
 };
-- 
2.7.4
