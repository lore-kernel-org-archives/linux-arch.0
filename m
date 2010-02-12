From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] preserve personality flag bits across exec
Date: Fri, 12 Feb 2010 14:22:37 -0800
Message-ID: <4b75d4ad110405a3ef@agluck-desktop.sc.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44681 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755802Ab0BLWYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Feb 2010 17:24:37 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Only x86, powerpc and sparc seem to preserve the upper bits
of personality across exec().  Whether this is important depends
on whether each architecture implements any bits in the upper
3 bytes of the personality.  For ia64 the problem showed up
when someone was trying to set ADDR_NO_RANDOMIZE and wanted
the setting to stick across exec.

I'm planning on apply the patch below for ia64. Other arch
maintainers should look to see if they need to do the same.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/arch/ia64/include/asm/elf.h b/arch/ia64/include/asm/elf.h
index e14108b..4c41656 100644
--- a/arch/ia64/include/asm/elf.h
+++ b/arch/ia64/include/asm/elf.h
@@ -201,7 +201,9 @@ extern void ia64_elf_core_copy_regs (struct pt_regs *src, elf_gregset_t dst);
    relevant until we have real hardware to play with... */
 #define ELF_PLATFORM	NULL
 
-#define SET_PERSONALITY(ex)	set_personality(PER_LINUX)
+#define SET_PERSONALITY(ex)	\
+	set_personality((current->personality & ~PER_MASK) | PER_LINUX)
+
 #define elf_read_implies_exec(ex, executable_stack)					\
 	((executable_stack!=EXSTACK_DISABLE_X) && ((ex).e_flags & EF_IA_64_LINUX_EXECUTABLE_STACK) != 0)
 
