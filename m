From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 15/41] arm64: get rid of copy_regset_to_user() in compat_ptrace_read_user()
Date: Mon, 29 Jun 2020 19:26:02 +0100
Message-ID: <20200629182628.529995-15-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgF2Smu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:50 -0400
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm64/kernel/ptrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5b837741ab76..d5f3da5197a1 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1541,9 +1541,7 @@ static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
 	else if (off == COMPAT_PT_TEXT_END_ADDR)
 		tmp = tsk->mm->end_code;
 	else if (off < sizeof(compat_elf_gregset_t))
-		return copy_regset_to_user(tsk, &user_aarch32_view,
-					   REGSET_COMPAT_GPR, off,
-					   sizeof(compat_ulong_t), ret);
+		tmp = compat_get_user_reg(tsk, off >> 2);
 	else if (off >= COMPAT_USER_SZ)
 		return -EIO;
 	else
-- 
2.11.0
