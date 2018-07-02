From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 5/8] x86: jump_label: switch to jump_entry accessors
Date: Mon,  2 Jul 2018 20:11:42 +0200
Message-ID: <20180702181145.4799-6-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Will Deacon <will.deacon@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

In preparation of switching x86 to use place-relative references for
the code, target and key members of struct jump_entry, replace direct
references to the struct members with invocations of the new accessors.
This will allow us to make the switch by modifying the accessors only.

This incorporates a cleanup of __jump_label_transform() proposed by
Peter.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/kernel/jump_label.c | 62 ++++++++------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..023768222a94 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -42,52 +42,37 @@ static void __jump_label_transform(struct jump_entry *entry,
 				   void *(*poker)(void *, const void *, size_t),
 				   int init)
 {
-	union jump_code_union code;
+	union jump_code_union jmp;
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+	const void *expect, *code;
+	int line;
+
+	jmp.jump = 0xe9;
+	jmp.offset = jump_entry_target(entry) -
+		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
-			/*
-			 * Jump label is enabled for the first time.
-			 * So we expect a default_nop...
-			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = default_nop; line = __LINE__;
 		} else {
-			/*
-			 * ...otherwise expect an ideal_nop. Otherwise
-			 * something went horribly wrong.
-			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = ideal_nop; line = __LINE__;
 		}
 
-		code.jump = 0xe9;
-		code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
+		code = &jmp.code;
 	} else {
-		/*
-		 * We are disabling this jump label. If it is not what
-		 * we think it is, then something must have gone wrong.
-		 * If this is the first initialization call, then we
-		 * are converting the default nop to the ideal nop.
-		 */
 		if (init) {
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = default_nop; line = __LINE__;
 		} else {
-			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
-			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = &jmp.code; line = __LINE__;
 		}
-		memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
+
+		code = ideal_nop;
 	}
 
+	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
+		bug_at((void *)jump_entry_code(entry), line);
+
 	/*
 	 * Make text_poke_bp() a default fallback poker.
 	 *
@@ -96,11 +81,14 @@ static void __jump_label_transform(struct jump_entry *entry,
 	 * always nop being the 'currently valid' instruction
 	 *
 	 */
-	if (poker)
-		(*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
-	else
-		text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
-			     (void *)entry->code + JUMP_LABEL_NOP_SIZE);
+	if (poker) {
+		(*poker)((void *)jump_entry_code(entry), code,
+			 JUMP_LABEL_NOP_SIZE);
+		return;
+	}
+
+	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
-- 
2.17.1
