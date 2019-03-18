Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfCRQf7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Mar 2019 12:35:59 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 1/4] elf: Make AT_FLAGS arch configurable
Date: Mon, 18 Mar 2019 16:35:30 +0000
Message-ID: <20190318163533.26838-2-vincenzo.frascino@arm.com>
In-Reply-To: <20190318163533.26838-1-vincenzo.frascino@arm.com>
References: <cover.1552679409.git.andreyknvl@google.com>
 <20190318163533.26838-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Branislav Rankov <Branislav.Rankov@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Martin <Dave.Martin@arm.com>, "David S. Miller" <davem@davemloft.net>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Evgeniy Stepanov <eugenis@google.com>, Graeme Barnes <Graeme.Barnes@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Kevin Brodsky <kevin.brodsky@arm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Kostya Serebryany <kcc@google.com>, Lee Smith <Lee.Smith@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20190318163530.QWW4_CdDjlR8q3QP7P3V49VA6dsPHnNl3ZalBa4SDsE@z>

Currently, the AT_FLAGS in the elf auxiliary vector are set to 0
by default by the kernel.
Some architectures might need to expose to the userspace a non-zero
value to advertise some platform specific ABI functionalities.

Make AT_FLAGS configurable by the architectures that require it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 fs/binfmt_elf.c        | 6 +++++-
 fs/binfmt_elf_fdpic.c  | 6 +++++-
 fs/compat_binfmt_elf.c | 5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7d09d125f148..f699a9ef5112 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -84,6 +84,10 @@ static int elf_core_dump(struct coredump_params *cprm);
 #define ELF_CORE_EFLAGS	0
 #endif
 
+#ifndef ELF_AT_FLAGS
+#define ELF_AT_FLAGS	0
+#endif
+
 #define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
 #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
 #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
@@ -249,7 +253,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	NEW_AUX_ENT(AT_FLAGS, ELF_AT_FLAGS);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b53bb3729ac1..cf1e680a6b88 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -82,6 +82,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *,
 static int elf_fdpic_core_dump(struct coredump_params *cprm);
 #endif
 
+#ifndef ELF_AT_FLAGS
+#define ELF_AT_FLAGS	0
+#endif
+
 static struct linux_binfmt elf_fdpic_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_fdpic_binary,
@@ -651,7 +655,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	NEW_AUX_ENT(AT_FLAGS,	ELF_AT_FLAGS);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 15f6e96b3bd9..a21cf99701ae 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -79,6 +79,11 @@
 #define	ELF_HWCAP2		COMPAT_ELF_HWCAP2
 #endif
 
+#ifdef	COMPAT_ELF_AT_FLAGS
+#undef	ELF_AT_FLAGS
+#define	ELF_AT_FLAGS		COMPAT_ELF_AT_FLAGS
+#endif
+
 #ifdef	COMPAT_ARCH_DLINFO
 #undef	ARCH_DLINFO
 #define	ARCH_DLINFO		COMPAT_ARCH_DLINFO
-- 
2.21.0
