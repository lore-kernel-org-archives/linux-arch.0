Return-Path: <SRS0=AQMQ=AK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 16/41] arm64: sanitize compat_ptrace_write_user()
Date: Mon, 29 Jun 2020 19:26:03 +0100
Message-ID: <20200629182628.529995-16-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Message-ID: <20200629182603.u8YBVMckYjOX8F4U5p0QePQgKkY340No_AKTyArlgdU@z>

From: Al Viro <viro@zeniv.linux.org.uk>

don't bother with copy_regset_from_user() (not to mention
set_fs())

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d5f3da5197a1..9f769e862f68 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1553,8 +1553,8 @@ static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
 static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 				    compat_ulong_t val)
 {
-	int ret;
-	mm_segment_t old_fs = get_fs();
+	struct pt_regs newregs = *task_pt_regs(tsk);
+	unsigned int idx = off / 4;
 
 	if (off & 3 || off >= COMPAT_USER_SZ)
 		return -EIO;
@@ -1562,14 +1562,25 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 	if (off >= sizeof(compat_elf_gregset_t))
 		return 0;
 
-	set_fs(KERNEL_DS);
-	ret = copy_regset_from_user(tsk, &user_aarch32_view,
-				    REGSET_COMPAT_GPR, off,
-				    sizeof(compat_ulong_t),
-				    &val);
-	set_fs(old_fs);
+	switch (idx) {
+	case 15:
+		newregs.pc = val;
+		break;
+	case 16:
+		newregs.pstate = compat_psr_to_pstate(val);
+		break;
+	case 17:
+		newregs.orig_x0 = val;
+		break;
+	default:
+		newregs.regs[idx] = val;
+	}
+
+	if (!valid_user_regs(&newregs.user_regs, tsk))
+		return -EINVAL;
 
-	return ret;
+	*task_pt_regs(tsk) = newregs;
+	return 0;
 }
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-- 
2.11.0
