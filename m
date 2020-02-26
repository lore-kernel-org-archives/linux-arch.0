From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 06/11] arm64: BTI: Decode BYTPE bits when printing PSTATE
Date: Wed, 26 Feb 2020 15:57:09 +0000
Message-ID: <20200226155714.43937-7-broonie@kernel.org>
References: <20200226155714.43937-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200226155714.43937-1-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-a
List-Id: linux-arch.vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

The current code to print PSTATE symbolically when generating
backtraces etc., does not include the BYTPE field used by Branch
Target Identification.

So, decode BYTPE and print it too.

In the interests of human-readability, print the classes of BTI
matched.  The symbolic notation, BYTPE (PSTATE[11:10]) and
permitted classes of subsequent instruction are:

    -- (BTYPE=0b00): any insn
    jc (BTYPE=0b01): BTI jc, BTI j, BTI c, PACIxSP
    -c (BYTPE=0b10): BTI jc, BTI c, PACIxSP
    j- (BTYPE=0b11): BTI jc, BTI j

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/process.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b8e3faa8d406..24af13d7bde6 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -211,6 +211,15 @@ void machine_restart(char *cmd)
 	while (1);
 }
 
+#define bstr(suffix, str) [PSR_BTYPE_ ## suffix >> PSR_BTYPE_SHIFT] = str
+static const char *const btypes[] = {
+	bstr(NONE, "--"),
+	bstr(  JC, "jc"),
+	bstr(   C, "-c"),
+	bstr(  J , "j-")
+};
+#undef bstr
+
 static void print_pstate(struct pt_regs *regs)
 {
 	u64 pstate = regs->pstate;
@@ -229,7 +238,10 @@ static void print_pstate(struct pt_regs *regs)
 			pstate & PSR_AA32_I_BIT ? 'I' : 'i',
 			pstate & PSR_AA32_F_BIT ? 'F' : 'f');
 	} else {
-		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO)\n",
+		const char *btype_str = btypes[(pstate & PSR_BTYPE_MASK) >>
+					       PSR_BTYPE_SHIFT];
+
+		printk("pstate: %08llx (%c%c%c%c %c%c%c%c %cPAN %cUAO BTYPE=%s)\n",
 			pstate,
 			pstate & PSR_N_BIT ? 'N' : 'n',
 			pstate & PSR_Z_BIT ? 'Z' : 'z',
@@ -240,7 +252,8 @@ static void print_pstate(struct pt_regs *regs)
 			pstate & PSR_I_BIT ? 'I' : 'i',
 			pstate & PSR_F_BIT ? 'F' : 'f',
 			pstate & PSR_PAN_BIT ? '+' : '-',
-			pstate & PSR_UAO_BIT ? '+' : '-');
+			pstate & PSR_UAO_BIT ? '+' : '-',
+			btype_str);
 	}
 }
 
-- 
2.20.1
