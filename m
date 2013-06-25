From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: c6x: kernel: include "linux/console.h" when 'VT' and
 'DUMMY_CONSOLE' enabled.
Date: Tue, 25 Jun 2013 09:58:32 +0800
Message-ID: <51C8F948.2040204@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:9601 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3FYB7Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 21:59:24 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: msalter@redhat.com, a-jacquiot@ti.com
Cc: jkc@redhat.com, linux-c6x-dev@linux-c6x.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Need include "linux/console.h" when 'VT' and 'DUMMY_CONSOLE' enabled
(e.g allmodconfig).

The related error:
  arch/c6x/kernel/setup.c: In function =91setup_arch=92:
  arch/c6x/kernel/setup.c:442:2: error: =91conswitchp=92 undeclared (fi=
rst use in this function)
  arch/c6x/kernel/setup.c:442:2: note: each undeclared identifier is re=
ported only once for each function it appears in
  arch/c6x/kernel/setup.c:442:16: error: =91dummy_con=92 undeclared (fi=
rst use in this function)

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/c6x/kernel/setup.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
index f4e72bd..1411141 100644
--- a/arch/c6x/kernel/setup.c
+++ b/arch/c6x/kernel/setup.c
@@ -26,6 +26,9 @@
 #include <linux/cpu.h>
 #include <linux/fs.h>
 #include <linux/of.h>
+#if defined(CONFIG_VT) && defined(CONFIG_DUMMY_CONSOLE)
+#include <linux/console.h>
+#endif
=20
=20
 #include <asm/sections.h>
--=20
1.7.7.6
