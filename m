From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/5] RISC-V: Use the new generic devmem_is_allowed()
Date: Thu,  9 Jul 2020 13:05:49 -0700
Message-ID: <20200709200552.1910298-3-palmer@dabbelt.com>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200709200552.1910298-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-riscv@lists.infradead.org, zong.li@sifive.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu, gxt@pku.edu.cn, Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, linus.walleij@linaro.org, rppt@linux.ibm.com, mchehab+samsung@kernel.org, gregory.0xf0@gmail.com, masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>, bgolaszewski@baylibre.com, tglx@linutronix.de, steve@sk2.org, keescook@chromium.org, mcgrof@kernel.org, alex@ghiti.fr, mark.rutland@arm.com, james.morse@arm.com, andriy.shevchenko@linux.intel.com, alex.shi@linux.alibaba.com, davem@davemloft.net, rdunlap@infradead.org, broonie@kernel.org, uwe@kleine-koenig.org, rostedt@goodmis.org, dan.j.williams@intel.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This allows us to enable STRICT_DEVMEM.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 089293e4ad46..8ff368a65a07 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
-- 
2.27.0.383.g050319c2ae-goog
