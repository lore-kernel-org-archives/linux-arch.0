Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52012 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbbCBOz6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2015 09:55:58 -0500
From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [RFC PATCH 3/4] arm64: add support for memtest
Date: Mon,  2 Mar 2015 14:55:44 +0000
Message-ID: <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org
Message-ID: <20150302145544.km-iU437apTxcnjG8v5llorLwzDiuof89L1l-Sh1iiM@z>

Add support for memtest command line option.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm64/mm/init.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ae85da6..597831b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -190,6 +190,8 @@ void __init bootmem_init(void)
 =09min =3D PFN_UP(memblock_start_of_DRAM());
 =09max =3D PFN_DOWN(memblock_end_of_DRAM());
=20
+=09early_memtest(min << PAGE_SHIFT, max << PAGE_SHIFT);
+
 =09/*
 =09 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 =09 * done after the fixed reservations.
--=20
1.7.9.5


