From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/22] h8300: Fix die()
Date: Fri, 27 Aug 2010 02:59:52 +0100
Message-ID: <20100827015952.27277.25309.stgit@warthog.procyon.org.uk>
References: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19631 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802Ab0H0B7z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Aug 2010 21:59:55 -0400
In-Reply-To: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org

Fix h8300's die() to take care of a number of problems:

  CC      arch/h8300/kernel/traps.o
In file included from /warthog/nfs/linux-2.6-fscache/arch/h8300/include/asm/bitops.h:10,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:17,
                 from include/linux/sched.h:54,
                 from arch/h8300/kernel/traps.c:18:
/warthog/nfs/linux-2.6-fscache/arch/h8300/include/asm/system.h:136: warning: 'struct pt_regs' declared inside parameter list
/warthog/nfs/linux-2.6-fscache/arch/h8300/include/asm/system.h:136: warning: its scope is only this definition or declaration, which is probably not what you want
arch/h8300/kernel/traps.c:100: error: conflicting types for 'die'
/warthog/nfs/linux-2.6-fscache/arch/h8300/include/asm/system.h:136: error: previous declaration of 'die' was here
make[2]: *** [arch/h8300/kernel/traps.o] Error 1

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/h8300/include/asm/system.h |    4 +++-
 arch/h8300/kernel/traps.c       |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/include/asm/system.h b/arch/h8300/include/asm/system.h
index d98d976..16bf156 100644
--- a/arch/h8300/include/asm/system.h
+++ b/arch/h8300/include/asm/system.h
@@ -3,6 +3,8 @@
 
 #include <linux/linkage.h>
 
+struct pt_regs;
+
 /*
  * switch_to(n) should switch tasks to task ptr, first checking that
  * ptr isn't the current task, in which case it does nothing.  This
@@ -155,6 +157,6 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 
 #define arch_align_stack(x) (x)
 
-void die(char *str, struct pt_regs *fp, unsigned long err);
+extern void die(const char *str, struct pt_regs *fp, unsigned long err);
 
 #endif /* _H8300_SYSTEM_H */
diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index 3c0b66b..dfa05bd 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -96,7 +96,7 @@ static void dump(struct pt_regs *fp)
 	printk("\n\n");
 }
 
-void die(char *str, struct pt_regs *fp, unsigned long err)
+void die(const char *str, struct pt_regs *fp, unsigned long err)
 {
 	static int diecount;
 
