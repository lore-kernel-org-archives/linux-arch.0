From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: c6x: mm: include "asm/uaccess.h" to pass compiling
Date: Tue, 25 Jun 2013 10:01:48 +0800
Message-ID: <51C8FA0C.5090202@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:26419 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3FYCCl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 22:02:41 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: msalter@redhat.com, a-jacquiot@ti.com
Cc: Andrew Morton <akpm@linux-foundation.org>, jiang.liu@huawei.com, "dhowells@redhat.com" <dhowells@redhat.com>, linux-c6x-dev@linux-c6x.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Need include "asm/uaccess.h" to pass compiling.

The related error (with allmodconfig):
  arch/c6x/mm/init.c: In function =91paging_init=92:
  arch/c6x/mm/init.c:46:2: error: implicit declaration of function =91s=
et_fs=92 [-Werror=3Dimplicit-function-declaration]
  arch/c6x/mm/init.c:46:9: error: =91KERNEL_DS=92 undeclared (first use=
 in this function)
  arch/c6x/mm/init.c:46:9: note: each undeclared identifier is reported=
 only once for each function it appears in

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/c6x/mm/init.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index e524fde..63f5560 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -18,6 +18,7 @@
 #include <linux/initrd.h>
=20
 #include <asm/sections.h>
+#include <asm/uaccess.h>
=20
 /*
  * ZERO_PAGE is a special page that is used for zero-initialized
--=20
1.7.7.6
