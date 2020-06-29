From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 02/17] vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
Date: Sun, 28 Jun 2020 23:18:25 -0700
Message-ID: <20200629061840.4065483-3-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

KASAN (-fsanitize=kernel-address) and KCSAN (-fsanitize=thread) produce
unwanted[1] .eh_frame and .init_array.* sections. Add them to DISCARDS,
except with CONFIG_CONSTRUCTORS, which wants to keep .init_array.*
sections.

[1] https://bugs.llvm.org/show_bug.cgi?id=46478

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1248a206be8d..e53a2d4f47f6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -927,10 +927,30 @@
 	EXIT_DATA
 #endif
 
+/*
+ * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
+ * unwanted sections (.eh_frame and .init_array.*), but
+ * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * https://bugs.llvm.org/show_bug.cgi?id=46478
+ */
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
+# ifdef CONFIG_CONSTRUCTORS
+#  define KASAN_DISCARDS						\
+	*(.eh_frame)
+# else
+#  define KASAN_DISCARDS						\
+	*(.init_array) *(.init_array.*)					\
+	*(.eh_frame)
+# endif
+#else
+# define KASAN_DISCARDS
+#endif
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
+	KASAN_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
-- 
2.25.1
