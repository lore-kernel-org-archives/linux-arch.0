From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v05 35/72] include/uapi/asm-generic/ucontext.h: include asm/signal.h and asm/sigcontext.h
Date: Mon, 22 Aug 2016 20:32:52 +0200
Message-ID: <1471890809-4383-36-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
2.8.1
