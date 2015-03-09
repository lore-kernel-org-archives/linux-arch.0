Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50653 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbbCIK1f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 06:27:35 -0400
From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 5/6] Kconfig: memtest: update number of test patterns up to 17
Date: Mon,  9 Mar 2015 10:27:09 +0000
Message-ID: <1425896830-19705-6-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org, baruch@tkos.co.il, rdunlap@infradead.org
Message-ID: <20150309102709.QaJvm9Gjvd8OdMIoSVHQ5NzcI7hestPn2l_zk7emE7c@z>

Additional test patterns for memtest were introduced since 63823126
"x86: memtest: add additional (regular) test patterns", but looks like
Kconfig was not updated that time.

Update Kconfig entry with the actual number of maximum test patterns.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8eb064fd..2832b0e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1740,7 +1740,7 @@ config MEMTEST
 =09        memtest=3D0, mean disabled; -- default
 =09        memtest=3D1, mean do 1 test pattern;
 =09        ...
-=09        memtest=3D4, mean do 4 test patterns.
+=09        memtest=3D17, mean do 17 test patterns.
 =09  If you are unsure how to answer this question, answer N.
=20
 source "samples/Kconfig"
--=20
1.7.9.5


