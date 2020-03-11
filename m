From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v9 13/13] arm64: BTI: Add Kconfig entry for userspace BTI
Date: Wed, 11 Mar 2020 19:26:08 +0000
Message-ID: <20200311192608.40095-14-broonie@kernel.org>
References: <20200311192608.40095-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200311192608.40095-1-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-a
List-Id: linux-arch.vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

Now that the code for userspace BTI support is in the kernel add the
Kconfig entry so that it can be built and used.

[Split out of "arm64: Basic Branch Target Identification support" --
broonie]

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8a15bc68dadd..d65d226a77ec 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1522,6 +1522,28 @@ endmenu
 
 menu "ARMv8.5 architectural features"
 
+config ARM64_BTI
+	bool "Branch Target Identification support"
+	default y
+	help
+	  Branch Target Identification (part of the ARMv8.5 Extensions)
+	  provides a mechanism to limit the set of locations to which computed
+	  branch instructions such as BR or BLR can jump.
+
+	  To make use of BTI on CPUs that support it, say Y.
+
+	  BTI is intended to provide complementary protection to other control
+	  flow integrity protection mechanisms, such as the Pointer
+	  authentication mechanism provided as part of the ARMv8.3 Extensions.
+	  For this reason, it does not make sense to enable this option without
+	  also enabling support for pointer authentication.  Thus, when
+	  enabling this option you should also select ARM64_PTR_AUTH=y.
+
+	  Userspace binaries must also be specifically compiled to make use of
+	  this mechanism.  If you say N here or the hardware does not support
+	  BTI, such binaries can still run, but you get no additional
+	  enforcement of branch destinations.
+
 config ARM64_E0PD
 	bool "Enable support for E0PD"
 	default y
-- 
2.20.1
