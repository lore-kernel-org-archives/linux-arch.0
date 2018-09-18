From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 8/9] signal/powerpc: Simplify _exception_pkey by using force_sig_pkuerr
Date: Tue, 18 Sep 2018 19:58:49 +0200
Message-ID: <20180918175850.4437-8-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878t3yitze.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Call force_sig_pkuerr directly instead of rolling it by hand
in _exception_pkey.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/kernel/traps.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e5ea69222459..ab1bd06d7c44 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -364,18 +364,10 @@ static bool exception_common(int signr, struct pt_regs *regs, int code,
 
 void _exception_pkey(struct pt_regs *regs, unsigned long addr, int key)
 {
-	siginfo_t info;
-
 	if (!exception_common(SIGSEGV, regs, SEGV_PKUERR, addr))
 		return;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGSEGV;
-	info.si_code = SEGV_PKUERR;
-	info.si_addr = (void __user *) addr;
-	info.si_pkey = key;
-
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_pkuerr((void __user *) addr, key);
 }
 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
-- 
2.17.1
