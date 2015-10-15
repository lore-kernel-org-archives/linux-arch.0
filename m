Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:52354 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbbJOGya (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Oct 2015 02:54:30 -0400
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v4 54/79] include/uapi/asm-generic/ucontext.h: include asm/signal.h and asm/sigcontext.h
Date: Thu, 15 Oct 2015 07:56:32 +0200
Message-ID: <1444888618-4506-55-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
References: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mikko.rapeli@iki.fi, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20151015055632.AJEqPIq5kqpjfzR1llMN-etpvuawTmKLXbBy06L1yyE@z>

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
index ad77343..4481528 100644
--- a/include/uapi/asm-generic/ucontext.h
+++ b/include/uapi/asm-generic/ucontext.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_GENERIC_UCONTEXT_H
 #define __ASM_GENERIC_UCONTEXT_H
 
+#include <asm/signal.h>
+#include <asm/sigcontext.h>
+
 struct ucontext {
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
-- 
2.5.0

