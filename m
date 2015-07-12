From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] bug: Fix build error in V4.2-RC1
Date: Sun, 12 Jul 2015 10:00:36 -0500
Message-ID: <1436713236-26445-1-git-send-email-Larry.Finger@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34471 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbGLPBA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2015 11:01:00 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

If CONFIG_BUG is not defined, then macro __WARN is not defined. This sh=
ows
as the following build error:

  CC [M]  drivers/media/v4l2-core/videobuf2-core.o
drivers/media/v4l2-core/videobuf2-core.c: In function =E2=80=98vb2_warn=
_zero_bytesused=E2=80=99:
drivers/media/v4l2-core/videobuf2-core.c:1253:2: error: implicit declar=
ation of function =E2=80=98__WARN=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
  __WARN();
  ^
This problem has been bisected to commit 77a3c6fd90c94f635edb00d4a65f48=
5687538791.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/asm-generic/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 630dd23..c1cb4b3 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -137,6 +137,7 @@ extern void warn_slowpath_null(const char *file, co=
nst int line);
 })
=20
 #else /* !CONFIG_BUG */
+#define __WARN() do {} while (1)
 #ifndef HAVE_ARCH_BUG
 #define BUG() do {} while (1)
 #endif
--=20
2.1.4
