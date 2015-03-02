From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [RFC PATCH 3/4] arm64: add support for memtest
Date: Mon,  2 Mar 2015 14:55:44 +0000
Message-ID: <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org
List-Id: linux-arch.vger.kernel.org

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


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
