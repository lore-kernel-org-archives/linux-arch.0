Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:18560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750883AbdGGNpQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Jul 2017 09:45:16 -0400
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v9 37/38] compiler-gcc.h: Introduce __nostackp function
 attribute
Date: Fri, 07 Jul 2017 08:45:02 -0500
Message-ID: <20170707134502.29711.66274.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170707133804.29711.1616.stgit@tlendack-t1.amdoffice.net>
References: <20170707133804.29711.1616.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170707134502.1E929TTtei4rx2JcAt-G-evlhUSuRdqKY0yCQsfbQno@z>

Create a new function attribute, __nostackp, that can used to turn off
stack protection on a per function basis.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 include/linux/compiler-gcc.h |    2 ++
 include/linux/compiler.h     |    4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0efef9c..de48b32 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -162,6 +162,8 @@
 
 #if GCC_VERSION >= 40100
 # define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
+
+#define __nostackp	__attribute__((__optimize__("no-stack-protector")))
 #endif
 
 #if GCC_VERSION >= 40300
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 707242f..615d50d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -458,6 +458,10 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define __visible
 #endif
 
+#ifndef __nostackp
+#define __nostackp
+#endif
+
 /*
  * Assume alignment of return value.
  */
