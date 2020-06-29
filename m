Return-Path: <SRS0=AQMQ=AK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgF2Smm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:42 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 07/41] [ia64] access_uarea(): stop bothering with gpregs_[gs]et()
Date: Mon, 29 Jun 2020 19:25:54 +0100
Message-ID: <20200629182628.529995-7-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Message-ID: <20200629182554.Jkrqawyx3F8jGzPjwUxsDWMkDpl-MTn70cKxd9AT_8k@z>

From: Al Viro <viro@zeniv.linux.org.uk>

We know this won't be called for child == current, so we don't need
to bother with callbacks, etc. - just do unw_init_from_blocked_task(),
unw_unwind_to_user() and do the payload of gpregs_[gs]et().  For
one register.  Which is to say, access_elf_reg().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/ptrace.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index be635f6f93c9..e0813c8e4b47 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1936,15 +1936,14 @@ access_uarea(struct task_struct *child, unsigned long addr,
 	}
 
 	if (pos != -1) {
-		if (write_access)
-			ret = gpregs_set(child, NULL, pos,
-				sizeof(unsigned long), data, NULL);
-		else
-			ret = gpregs_get(child, NULL, pos,
-				sizeof(unsigned long), data, NULL);
-		if (ret != 0)
-			return -1;
-		return 0;
+		struct unw_frame_info info;
+
+		memset(&info, 0, sizeof(info));
+		unw_init_from_blocked_task(&info, child);
+		if (unw_unwind_to_user(&info) < 0)
+			return 0;
+
+		return access_elf_reg(child, &info, pos, data, write_access);
 	}
 
 	/* access debug registers */
-- 
2.11.0
