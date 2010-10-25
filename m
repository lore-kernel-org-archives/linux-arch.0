From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Partially revert patch that encloses asm-offset.h numbers
 in brackets
Date: Mon, 25 Oct 2010 15:02:18 +0100
Message-ID: <20101025140218.5092.74117.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31316 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871Ab0JYODp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2010 10:03:45 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@osdl.org, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@fastmail.fm>, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@linux.intel.com>

Partially revert patch:

	commit 3234282f33b29d349bcada40204fc7c8fda7fe72
	Author: Jan Beulich <JBeulich@novell.com>
	Date:   Tue Oct 19 14:52:26 2010 +0100
	x86, asm: Fix CFI macro invocations to deal with shortcomings in gas

This breaks MN10300 arch as this changes many instances of instructions
similar to the following:

	MOV	number,D0

which represents an immediate value load into:

	MOV	(number),D0

which the assembler then interprets as a load from absolute address.

arch/mn10300/kernel/entry.S:64: Error: Invalid opcode/operands
arch/mn10300/kernel/entry.S:65: Error: junk at end of line, first unrecognized character is `0'
arch/mn10300/kernel/entry.S:74: Error: Invalid opcode/operands
arch/mn10300/kernel/entry.S:74: Error: junk at end of line, first unrecognized character is `1'
arch/mn10300/kernel/entry.S:75: Error: Invalid opcode/operands
arch/mn10300/kernel/entry.S:76: Error: junk at end of line, first unrecognized character is `0'

cc: Jan Beulich <jbeulich@novell.com>
cc: Alexander van Heukelum <heukelum@fastmail.fm>
cc: H. Peter Anvin <hpa@linux.intel.com>
cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 Kbuild |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/Kbuild b/Kbuild
index 431f7ca..b00037a 100644
--- a/Kbuild
+++ b/Kbuild
@@ -53,7 +53,7 @@ targets += arch/$(SRCARCH)/kernel/asm-offsets.s
 # Default sed regexp - multiline due to syntax constraints
 define sed-y
 	"/^->/{s:->#\(.*\):/* \1 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 (\2) /* \3 */:; \
+	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \
 	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
 	s:->::; p;}"
 endef
