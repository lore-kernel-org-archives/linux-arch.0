From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 15/36] arm64/mm: Remove needless section quotes
Date: Fri, 31 Jul 2020 16:07:59 -0700
Message-ID: <20200731230820.1742553-16-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Fix a case of needless quotes in __section(), which Clang doesn't like.

Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1df25f26571d..dce024ea6084 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,7 +42,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
-- 
2.25.1
