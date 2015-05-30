From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 37/98] asm-generic/sembuf.h: include asm/posix_types.h and asm/ipcbuf.h
Date: Sat, 30 May 2015 17:38:29 +0200
Message-ID: <1433000370-19509-38-git-send-email-mikko.rapeli@iki.fi>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:40195 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757878AbbE3PlC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 30 May 2015 11:41:02 -0400
In-Reply-To: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

=46ixes userspace compilation errors like:

error: field =E2=80=98msg_perm=E2=80=99 has incomplete type
struct ipc64_perm msg_perm;
error: unknown type name =E2=80=98__kernel_ulong_t=E2=80=99

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/sembuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-gener=
ic/sembuf.h
index 4cb2c13..17d523f 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -2,6 +2,8 @@
 #define __ASM_GENERIC_SEMBUF_H
=20
 #include <asm/bitsperlong.h>
+#include <asm/posix_types.h>
+#include <asm/ipcbuf.h>
=20
 /*
  * The semid64_ds structure for x86 architecture.
--=20
2.1.4
