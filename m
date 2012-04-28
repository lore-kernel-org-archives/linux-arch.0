From: Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCH] arch/tile: avoid calling do_signal() after fork from a kernel thread
Date: Sat, 28 Apr 2012 14:51:43 -0400
Message-ID: <201204281858.q3SIwC7H014319@farm-0027.internal.tilera.com>
References: <20120423180150.GA6871@ZenIV.linux.org.uk>
 <20120424072617.GB6871@ZenIV.linux.org.uk>
 <20120426183742.GA324@redhat.com>
 <20120426231942.GJ6871@ZenIV.linux.org.uk>
 <20120427172444.GA30267@redhat.com>
 <20120427184528.GL6871@ZenIV.linux.org.uk>
 <20120427202002.8ED632C0BF@topped-with-meat.com>
 <20120427211244.GO6871@ZenIV.linux.org.uk>
 <20120427212729.652542C0AF@topped-with-meat.com>
 <20120427231526.GP6871@ZenIV.linux.org.uk>
 <20120427235023.GR6871@ZenIV.linux.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from [12.216.194.150] ([12.216.194.150]:36125 "EHLO king.tilera.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab2D1TNZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Apr 2012 15:13:25 -0400
In-Reply-To: <20120427235023.GR6871@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Calling interrupt_return will check the privilege of the context we're
returning to avoid the possibility of kernel threads doing any kind
of userspace actions (including signal handling) after a fork.

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
Al, thanks for noticing this.  I've queued it up for 3.4.

Do you have a case that might provoke the signal behavior in the
unpatched code?  The patched code passes our internal regressions.

 arch/tile/kernel/intvec_32.S |    2 +-
 arch/tile/kernel/intvec_64.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/tile/kernel/intvec_32.S b/arch/tile/kernel/intvec_32.S
index 5d56a1e..d0f48ca 100644
--- a/arch/tile/kernel/intvec_32.S
+++ b/arch/tile/kernel/intvec_32.S
@@ -1274,7 +1274,7 @@ STD_ENTRY(ret_from_fork)
 	FEEDBACK_REENTER(ret_from_fork)
 	{
 	 movei  r30, 0               /* not an NMI */
-	 j      .Lresume_userspace   /* jump into middle of interrupt_return */
+	 j      interrupt_return
 	}
 	STD_ENDPROC(ret_from_fork)
 
diff --git a/arch/tile/kernel/intvec_64.S b/arch/tile/kernel/intvec_64.S
index 49d9d66..252924b 100644
--- a/arch/tile/kernel/intvec_64.S
+++ b/arch/tile/kernel/intvec_64.S
@@ -1120,7 +1120,7 @@ STD_ENTRY(ret_from_fork)
 	FEEDBACK_REENTER(ret_from_fork)
 	{
 	 movei  r30, 0               /* not an NMI */
-	 j      .Lresume_userspace   /* jump into middle of interrupt_return */
+	 j      interrupt_return
 	}
 	STD_ENDPROC(ret_from_fork)
 
-- 
1.6.5.2
