From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] x86: add frame annotation for call_rwsem_down_write_failed_killable
Date: Wed, 13 Apr 2016 11:57:12 +0200
Message-ID: <1460541432-21631-1-git-send-email-mhocko@kernel.org>
References: <1460041951-22347-11-git-send-email-mhocko@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32883 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030543AbcDMJ5V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2016 05:57:21 -0400
In-Reply-To: <1460041951-22347-11-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>

From: Michal Hocko <mhocko@suse.com>

3387a535ce62 ("x86/asm: Create stack frames in rwsem functions") has
added FRAME_{BEGIN,END} annotations to rwsem asm stubs. The patch
which has added call_rwsem_down_write_failed_killable was based on an
older tree so it didn't know about annotations. Let's add them.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi Ingo,
please apply this on top of [1] when merging to tip/locking/rwsem.
Thanks!

[1] http://lkml.kernel.org/r/1460041951-22347-11-git-send-email-mhocko@kernel.org
 arch/x86/lib/rwsem.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/rwsem.S b/arch/x86/lib/rwsem.S
index 4534a7e912f3..a37462a23546 100644
--- a/arch/x86/lib/rwsem.S
+++ b/arch/x86/lib/rwsem.S
@@ -107,10 +107,12 @@ ENTRY(call_rwsem_down_write_failed)
 ENDPROC(call_rwsem_down_write_failed)
 
 ENTRY(call_rwsem_down_write_failed_killable)
+	FRAME_BEGIN
 	save_common_regs
 	movq %rax,%rdi
 	call rwsem_down_write_failed_killable
 	restore_common_regs
+	FRAME_END
 	ret
 ENDPROC(call_rwsem_down_write_failed_killable)
 
-- 
2.8.0.rc3
