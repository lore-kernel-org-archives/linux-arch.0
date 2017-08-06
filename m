From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v06 11/36] uapi asm-generic/ucontext.h: include asm/signal.h and asm/sigcontext.h
Date: Sun,  6 Aug 2017 18:44:02 +0200
Message-ID: <20170806164428.2273-12-mikko.rapeli@iki.fi>
References: <20170806164428.2273-1-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:58819 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdHFRUo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Aug 2017 13:20:44 -0400
In-Reply-To: <20170806164428.2273-1-mikko.rapeli@iki.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org

Fixes userspace compiler errors:

error: unknown type name ‘stack_t’
error: field ‘uc_mcontext’ has incomplete type
struct sigcontext uc_mcontext;
error: unknown type name ‘sigset_t’

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 include/uapi/asm-generic/ucontext.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/asm-generic/ucontext.h b/include/uapi/asm-generic/ucontext.h
index ad77343e8a9a..448152801c4f 100644
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
2.13.3
