Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:39086
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752293AbdGQVNP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jul 2017 17:13:15 -0400
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v10 34/38] x86/mm: Create native_make_p4d() for PGTABLE_LEVELS <= 4
Date: Mon, 17 Jul 2017 16:10:31 -0500
Message-ID: <b645e14f9e73731023694494860ceab73feff777.1500319216.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1500319216.git.thomas.lendacky@amd.com>
References: <cover.1500319216.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, kasan-dev@googlegroups.com
Cc: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Rik van Riel <riel@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Dave Young <dyoung@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, "Michael S. Tsirkin" <mst@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <20170717211031.jT-88HVoM5JeDGLhonjoxe5nZTFWSZavjFtc5yJ7i1U@z>

Currently, native_make_p4d() is only defined when CONFIG_PGTABLE_LEVELS
is greater than 4. Create a macro that will allow for defining and using
native_make_p4d() when CONFIG_PGTABLES_LEVELS is not greater than 4.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/pgtable_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 830992f..6c55973 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -309,6 +309,11 @@ static inline p4dval_t native_p4d_val(p4d_t p4d)
 #else
 #include <asm-generic/pgtable-nop4d.h>
 
+static inline p4d_t native_make_p4d(pudval_t val)
+{
+	return (p4d_t) { .pgd = native_make_pgd((pgdval_t)val) };
+}
+
 static inline p4dval_t native_p4d_val(p4d_t p4d)
 {
 	return native_pgd_val(p4d.pgd);
-- 
1.9.1
