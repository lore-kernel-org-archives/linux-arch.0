Return-Path: <SRS0=PuGS=4H=kvack.org=owner-linux-mm@kernel.org>
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 1/6] asm/sections: Add COMPARE_SECTIONS macro
Date: Tue, 18 Feb 2020 21:54:18 -0700
Message-ID: <20200219045423.54190-2-natechancellor@gmail.com>
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200219045418.7yBEVrMnVjNmTH6cGgFdsBr4V1wkJZQx_HNcBROUyb8@z>

When building with clang's -Wtautological-compare, there are a few
warnings around the comparison of section boundaries, which are linker
defined symbols and just contain an address. Clang says that these
comparisons always evaluate to a constant because it thinks they are
regular arrays. This result is expected and reasonable since we just
care about its boolean value. The kernel does this to figure out how
exactly it was laid out during link time so that it can make certain
run time decisions without hard coding them via preprocessor macros.

These comparisons always evaluate the way that the kernel wants (done by
comparing a Clang built kernel to a GCC built kernel). As a result, this
warning should be silenced in these particular instances so that
-Wtautological-compare can be enabled for the kernel globally since it
brings several useful warnings within its group. In other words, by
disabling -Wtautological-compare, the kernel misses out on several
useful subwarnings that are found with existing static checkers;
catching things with the compiler at build time will make it easier to
catch issues, especially as clang starts to be integrated into CI
systems.

The warnings can be silenced by casting the linked defined symbols to
unsigned long (normally uintptr_t but the kernel typedef's uintptr_t to
unsigned long and some kernel developers prefer unsigned long) to make
them purely numeric comparisons, which will be converted to a boolean
without any warning from Clang. The casting is done within a macro so
that it can be documented why this casting happens, rather than
sprinkling random casts in the few places that this happens within the
kernel.

Link: https://github.com/ClangBuiltLinux/linux/issues/765
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/asm-generic/sections.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/section=
s.h
index d1779d442aa5..e1f3095a50c1 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -169,4 +169,11 @@ static inline bool is_kernel_rodata(unsigned long ad=
dr)
 	       addr < (unsigned long)__end_rodata;
 }
=20
+/*
+ * Comparing section boundaries trips clang's -Wtautological-compare
+ * This silences that warning by making the comparisons purely numeric
+ */
+#define COMPARE_SECTIONS(section_one, op, section_two) \
+	((unsigned long)(section_one) op (unsigned long)(section_two))
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
--=20
2.25.1
