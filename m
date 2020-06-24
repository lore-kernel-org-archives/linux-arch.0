From: Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 06/22] kbuild: lto: limit inlining
Date: Wed, 24 Jun 2020 13:31:44 -0700
Message-ID: <20200624203200.78870-7-samitolvanen@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, George Burgess IV <gbiv@google.com>
List-Id: linux-arch.vger.kernel.org

This change limits function inlining across translation unit
boundaries in order to reduce the binary size with LTO.

The -import-instr-limit flag defines a size limit, as the number
of LLVM IR instructions, for importing functions from other TUs.
The default value is 100, and decreasing it to 5 reduces the size
of a stripped arm64 defconfig vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 3a7e5e5c17b9..ee66513a5b66 100644
--- a/Makefile
+++ b/Makefile
@@ -894,6 +894,10 @@ else
 CC_FLAGS_LTO_CLANG := -flto
 endif
 CC_FLAGS_LTO_CLANG += -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
+KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
 endif
 
 ifdef CONFIG_LTO
-- 
2.27.0.212.ge8ba1cc988-goog
