From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 33/36] x86/boot/compressed: Remove, discard, or assert for unwanted sections
Date: Fri, 31 Jul 2020 16:08:17 -0700
Message-ID: <20200731230820.1742553-34-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In preparation for warning on orphan sections, stop the linker from
generating the .eh_frame* sections, discard unwanted non-zero-sized
generated sections, and enforce other expected-to-be-zero-sized sections
(since discarding them might hide problems with them suddenly gaining
unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile      |  1 +
 arch/x86/boot/compressed/vmlinux.lds.S | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 96d53e300ab6..43b49e1f5b6d 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -49,6 +49,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 42dea70a5091..1fb9809a9e61 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -83,6 +83,11 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
+	/DISCARD/ : {
+		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
+		*(.hash) *(.gnu.hash)
+		*(.note.*)
+	}
 
 	/*
 	 * Sections that should stay zero sized, which is safer to
@@ -93,13 +98,18 @@ SECTIONS
 	}
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 
+	.plt (NOLOAD) : {
+		*(.plt) *(.plt.*)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
 	/* ld.lld does not like .rel* sections being made "NOLOAD". */
 	.rel.dyn : {
-		*(.rel.*)
+		*(.rel.*) *(.rel_*)
 	}
 	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 	.rela.dyn : {
-		*(.rela.*)
+		*(.rela.*) *(.rela_*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
-- 
2.25.1
