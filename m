From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 5/5] m32r: fix breakage from "m32r: use generic ptrace_resume
 code"
Date: Fri, 24 Sep 2010 06:25:34 +0100
Message-ID: <20100924052534.GP19804@ZenIV.linux.org.uk>
References: <20100924052035.GL19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34717 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0IXFZi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2010 01:25:38 -0400
Content-Disposition: inline
In-Reply-To: <20100924052035.GL19804@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hirokazu Takata <takata@linux-m32r.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m32r/kernel/ptrace.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
index e555091..0021ade 100644
--- a/arch/m32r/kernel/ptrace.c
+++ b/arch/m32r/kernel/ptrace.c
@@ -592,16 +592,17 @@ void user_enable_single_step(struct task_struct *child)
 
 	if (access_process_vm(child, pc&~3, &insn, sizeof(insn), 0)
 	    != sizeof(insn))
-		break;
+		return -EIO;
 
 	compute_next_pc(insn, pc, &next_pc, child);
 	if (next_pc & 0x80000000)
-		break;
+		return -EIO;
 
 	if (embed_debug_trap(child, next_pc))
-		break;
+		return -EIO;
 
 	invalidate_cache();
+	return 0;
 }
 
 void user_disable_single_step(struct task_struct *child)
-- 
1.5.6.5
