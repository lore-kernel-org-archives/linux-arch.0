From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: c6x: platforms: include "asm/special_insns.h" to pass
 compiling
Date: Tue, 25 Jun 2013 10:05:32 +0800
Message-ID: <51C8FAEC.10101@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:26546 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab3FYCGY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 22:06:24 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: msalter@redhat.com, a-jacquiot@ti.com
Cc: jkc@redhat.com, linux-c6x-dev@linux-c6x.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Include "asm/special_insns.h" to pass compiling.

The related error (with allmodconfig):
  arch/c6x/platforms/plldata.c: In function =91c6472_setup_clocks=92:
  arch/c6x/platforms/plldata.c:279:2: error: implicit declaration of fu=
nction =91get_coreid=92 [-Werror=3Dimplicit-function-declaration]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/c6x/platforms/plldata.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/c6x/platforms/plldata.c b/arch/c6x/platforms/plldata.=
c
index 755359e..ddd1441 100644
--- a/arch/c6x/platforms/plldata.c
+++ b/arch/c6x/platforms/plldata.c
@@ -20,6 +20,7 @@
 #include <asm/clock.h>
 #include <asm/setup.h>
 #include <asm/irq.h>
+#include <asm/special_insns.h>
=20
 /*
  * Common SoC clock support.
--=20
1.7.7.6
