From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 10/20] signal/x86/traps: Use force_sig instead of open coding it.
Date: Tue, 18 Sep 2018 02:05:36 +0200
Message-ID: <20180918000546.12552-10-ebiederm@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The function "force_sig(sig, tsk)" is equivalent to "
force_sig_info(sig, SEND_SIG_PRIV, tsk)".  Using the siginfo variants can
be error prone so use the simpler old fashioned force_sig variant,
and with luck the force_sig_info variant can go away.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9f7b3831fb7e..3e4a3172d711 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -582,7 +582,7 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
-	force_sig_info(SIGSEGV, SEND_SIG_PRIV, tsk);
+	force_sig(SIGSEGV, tsk);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-- 
2.17.1
