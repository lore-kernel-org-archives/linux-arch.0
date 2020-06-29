From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 07/41] [ia64] access_uarea(): stop bothering with gpregs_[gs]et()
Date: Mon, 29 Jun 2020 19:25:54 +0100
Message-ID: <20200629182628.529995-7-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

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
