From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] arm64: Removed unused variable
Date: Mon, 13 Apr 2015 20:52:18 +0200
Message-ID: <1428951138-26046-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:14385 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbbDMSw3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2015 14:52:29 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, catalin.marinas@arm.com, thierry.reding@gmail.com, linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>

arch/arm64/kernel/signal.c: In function =E2=80=98handle_signal=E2=80=99=
:
arch/arm64/kernel/signal.c:290:22: warning: unused variable =E2=80=98th=
read=E2=80=99 [-Wunused-variable]

=46ixes: arm64: Remove signal translation and exec_domain
Reported-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
Will be applied on top of my execdomain removal series.

Thanks,
//richard
---
 arch/arm64/kernel/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 9f28eaa..e18c48c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -287,7 +287,6 @@ static void setup_restart_syscall(struct pt_regs *r=
egs)
  */
 static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
-	struct thread_info *thread =3D current_thread_info();
 	struct task_struct *tsk =3D current;
 	sigset_t *oldset =3D sigmask_to_save();
 	int usig =3D ksig->sig;
--=20
1.8.4.5
