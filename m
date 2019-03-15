Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f201.google.com ([209.85.166.201]:51417 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfCOTwN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2019 15:52:13 -0400
Received: by mail-it1-f201.google.com with SMTP id o73so8609607itb.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Mar 2019 12:52:13 -0700 (PDT)
Date: Fri, 15 Mar 2019 20:51:33 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <c4d65de9867cb3349af6800242da0de751260c6c.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
Subject: [PATCH v11 09/14] kernel, arm64: untag user pointers in prctl_set_mm*
From: Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/sys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index 12df0e5434b8..8e56d87cc6db 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1993,6 +1993,18 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
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
@@ -2106,6 +2118,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
 			      opt != PR_SET_MM_MAP_SIZE)))
 		return -EINVAL;
 
+	addr = untagged_addr(addr);
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
 		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
-- 
2.21.0.360.g471c308f928-goog
