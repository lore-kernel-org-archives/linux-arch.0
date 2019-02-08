Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43819 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfBHGC4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 01:02:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so2691212qtc.10
        for <linux-arch@vger.kernel.org>; Thu, 07 Feb 2019 22:02:55 -0800 (PST)
Date: Fri, 8 Feb 2019 01:02:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] x86/mpx: tweak header name
Message-ID: <20190124142448.23243-2-mst@redhat.com>
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190208060253.5ajdhppofeu9RJbt43urGDhuufk0sjH79_k6eONbR7o@z>

Use linux/mman.h to make sure we get all mmap flags we need.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/mm/mpx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index de1851d15699..c805db6236b4 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -9,12 +9,12 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/mm_types.h>
+#include <linux/mman.h>
 #include <linux/syscalls.h>
 #include <linux/sched/sysctl.h>
 
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
-#include <asm/mman.h>
 #include <asm/mmu_context.h>
 #include <asm/mpx.h>
 #include <asm/processor.h>
-- 
MST
