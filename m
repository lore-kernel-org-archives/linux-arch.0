From: Tejun Heo <tj@kernel.org>
Subject: [PATCH percpu 1/2] microblaze: include EXIT_TEXT to _stext
Date: Wed, 08 Jul 2009 18:26:30 +0900
Message-ID: <4A546646.70305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48367 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbZGHJ1F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jul 2009 05:27:05 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au, Sam

From: Michal Simek <monstr@monstr.eu>

Microblaze wants to throw out EXIT_TEXT during runtime too.  This
hasn't caused trouble till now because the linker script didn't
discard EXIT_TEXT and it ended up in its default output section.  As
discard definition is about to be unified, include EXIT_TEXT into
_stext explicitly and while at it replace explicit exitcall definition
to EXIT_CALL.

Signed-off-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Michal, I added the commit messaeg and SOB.  If you don't like it
please let me know.

If there's no further objection, I'll commit this and the next patch
to percpu#for-next.

Thanks.

 arch/microblaze/kernel/vmlinux.lds.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work/arch/microblaze/kernel/vmlinux.lds.S
===================================================================
--- work.orig/arch/microblaze/kernel/vmlinux.lds.S
+++ work/arch/microblaze/kernel/vmlinux.lds.S
@@ -23,8 +23,8 @@ SECTIONS {
 		_stext = . ;
 		*(.text .text.*)
 		*(.fixup)
-
-		*(.exitcall.exit)
+               EXIT_TEXT
+               EXIT_CALL
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
