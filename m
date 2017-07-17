Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:47168
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751343AbdGQVM0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jul 2017 17:12:26 -0400
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v10 23/38] x86/realmode: Decrypt trampoline area if memory encryption is active
Date: Mon, 17 Jul 2017 16:10:20 -0500
Message-ID: <c70ffd2614fa77e80df31c9169ca98a9b16ff97c.1500319216.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1500319216.git.thomas.lendacky@amd.com>
References: <cover.1500319216.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, kasan-dev@googlegroups.com
Cc: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Rik van Riel <riel@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Dave Young <dyoung@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, "Michael S. Tsirkin" <mst@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <20170717211020.meFbLsKFKqkswlNfrH87GiwBwuaKN1Xs6JsbLreKs-Y@z>

When Secure Memory Encryption is enabled, the trampoline area must not
be encrypted. A CPU running in real mode will not be able to decrypt
memory that has been encrypted because it will not be able to use addresses
with the memory encryption mask.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/realmode/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index cd4be19..d6ddc7e 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -1,6 +1,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/mem_encrypt.h>
 
 #include <asm/set_memory.h>
 #include <asm/pgtable.h>
@@ -59,6 +60,13 @@ static void __init setup_real_mode(void)
 
 	base = (unsigned char *)real_mode_header;
 
+	/*
+	 * If SME is active, the trampoline area will need to be in
+	 * decrypted memory in order to bring up other processors
+	 * successfully.
+	 */
+	set_memory_decrypted((unsigned long)base, size >> PAGE_SHIFT);
+
 	memcpy(base, real_mode_blob, size);
 
 	phys_base = __pa(base);
-- 
1.9.1
