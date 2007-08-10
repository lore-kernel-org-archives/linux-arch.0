Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36534 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763320AbXHJU4z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Aug 2007 16:56:55 -0400
Message-Id: <200708102056.l7AKuZx3008465@imap1.linux-foundation.org>
Subject: [patch 1/6] Pass -g to assembler under CONFIG_DEBUG_INFO
From: akpm@linux-foundation.org
Date: Fri, 10 Aug 2007 13:56:35 -0700
Sender: linux-arch-owner@vger.kernel.org
To: sam@ravnborg.org
Cc: akpm@linux-foundation.org, roland@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Roland McGrath <roland@redhat.com>

The assembler for a while now supports -gdwarf to generate source line info
just like the C compiler does.  Source-level assembly debugging sounds like an
oxymoron, but it is handy to be able to see the right source file and read its
comments rather than just the disassembly.  This patch enables -gdwarf for
assembly files when CONFIG_DEBUG_INFO=y and the assembler supports the option.

Signed-off-by: Roland McGrath <roland@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Makefile |    1 +
 1 files changed, 1 insertion(+)

diff -puN Makefile~pass-g-to-assembler-under-config_debug_info Makefile
--- a/Makefile~pass-g-to-assembler-under-config_debug_info
+++ a/Makefile
@@ -499,6 +499,7 @@ endif
 
 ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
+AFLAGS		+= $(call as-option, -gdwarf2)
 endif
 
 # Force gcc to behave correct even for buggy distributions
_
