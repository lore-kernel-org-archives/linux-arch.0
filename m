Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:58850 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbbBPXIP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Feb 2015 18:08:15 -0500
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 45/45] include/uapi/asm-generic/ucontext.h: include signal.h and sigcontext.h
Date: Tue, 17 Feb 2015 00:05:48 +0100
Message-ID: <1424127948-22484-46-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150216230548.Y4VQOp6Yr1b6POd7Geqh_rfXs3DvHuz_CVguBgvTfCc@z>

Fixes userspace compiler errors:

error: unknown type name ‘stack_t’
error: field ‘uc_mcontext’ has incomplete type
struct sigcontext uc_mcontext;
error: unknown type name ‘sigset_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/ucontext.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/asm-generic/ucontext.h b/include/uapi/asm-generic/ucontext.h
index ad77343..31ece341 100644
--- a/include/uapi/asm-generic/ucontext.h
+++ b/include/uapi/asm-generic/ucontext.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_GENERIC_UCONTEXT_H
 #define __ASM_GENERIC_UCONTEXT_H
 
+#include <asm-generic/signal.h>
+#include <asm/sigcontext.h>
+
 struct ucontext {
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
-- 
2.1.4

