Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46417 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfBVMxt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 07:53:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so2223905wrs.13
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 04:53:48 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 09/12] kernel, arm64: untag user pointers in prctl_set_mm*
Date: Fri, 22 Feb 2019 13:53:21 +0100
Message-ID: <d6febfc14cf0190f4ccd84fc1bf9bd077a6d6a9f.1550839937.git.andreyknvl@google.com>
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>
Message-ID: <20190222125321.hLopIenxHw2EwkqmAH8MF3LhTll5eOkb2NcoeqGmlUs@z>

prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/sys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index f7eb62eceb24..12910be94b7f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1992,6 +1992,18 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
 		return -EFAULT;
 
+	prctl_map->start_code	= untagged_addr(prctl_map.start_code);
+	prctl_map->end_code	= untagged_addr(prctl_map.end_code);
+	prctl_map->start_data	= untagged_addr(prctl_map.start_data);
+	prctl_map->end_data	= untagged_addr(prctl_map.end_data);
+	prctl_map->start_brk	= untagged_addr(prctl_map.start_brk);
+	prctl_map->brk		= untagged_addr(prctl_map.brk);
+	prctl_map->start_stack	= untagged_addr(prctl_map.start_stack);
+	prctl_map->arg_start	= untagged_addr(prctl_map.arg_start);
+	prctl_map->arg_end	= untagged_addr(prctl_map.arg_end);
+	prctl_map->env_start	= untagged_addr(prctl_map.env_start);
+	prctl_map->env_end	= untagged_addr(prctl_map.env_end);
+
 	error = validate_prctl_map(&prctl_map);
 	if (error)
 		return error;
@@ -2105,6 +2117,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
 			      opt != PR_SET_MM_MAP_SIZE)))
 		return -EINVAL;
 
+	addr = untagged_addr(addr);
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
 		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
-- 
2.21.0.rc0.258.g878e2cd30e-goog
