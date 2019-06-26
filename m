Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfFZFw0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 01:52:26 -0400
From: guoren@kernel.org
Subject: [PATCH] csky: Fixup libgcc unwind error
Date: Wed, 26 Jun 2019 13:51:36 +0800
Message-ID: <1561528296-27444-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Mao Han <han_mao@c-sky.com>
Message-ID: <20190626055136.fBTukM79qiv082UvwFvixSAu8pz2n2mu7O9OFA4qymg@z>

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
