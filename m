Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50546 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbCIK1d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 06:27:33 -0400
From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 4/6] arm: add support for memtest
Date: Mon,  9 Mar 2015 10:27:08 +0000
Message-ID: <1425896830-19705-5-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org, baruch@tkos.co.il, rdunlap@infradead.org
Message-ID: <20150309102708.jU8dGKb_LcIEhQ1n4Rh4cMAeqJjWjOAs8iz2ajzjQ8o@z>

Add support for memtest command line option.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/init.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 1609b02..3d0e9ae 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -335,6 +335,9 @@ void __init bootmem_init(void)
=20
 =09find_limits(&min, &max_low, &max_high);
=20
+=09early_memtest((phys_addr_t)min << PAGE_SHIFT,
+=09=09      (phys_addr_t)max_low << PAGE_SHIFT);
+
 =09/*
 =09 * Sparsemem tries to allocate bootmem in memory_present(),
 =09 * so must be done after the fixed reservations
--=20
1.7.9.5


