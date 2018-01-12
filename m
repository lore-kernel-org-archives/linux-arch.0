From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and SIGFPE,SIGTRAP,SIGBUS
Date: Thu, 11 Jan 2018 18:59:36 -0600
Message-ID: <20180112005940.23279-7-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, James Morse <james.morse@arm.com>, Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nico@linaro.org>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
that uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME, BUS_FIXME, TRAP_FIXME siginfo_layout will now return
SIL_FAULT and the appropriate fields will be reliably copied.

But folks this is a new and unique kind of bad.  This is massively
untested code bad.  This is inventing new and unique was to get
siginfo wrong bad.  This is don't even think about Posix or what
siginfo means bad.  This is lots of eyeballs all missing the fact
that the code does the wrong thing bad.  This is getting stuck
and keep making the same mistake bad.

I really hope we can find a non userspace breaking fix for this on a
port as new as arm64.

Possible ABI fixes include:
- Send the signal without siginfo
- Don't generate a signal
- Possibly assign and use an appropriate si_code
- Don't handle cases which can't happen

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Ref: 53631b54c870 ("arm64: Floating point and SIMD")
Ref: 32015c235603 ("arm64: exception: handle Synchronous External Abort")
Ref: 1d18c47c735e ("arm64: MMU fault handling and page table management")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/uapi/asm/siginfo.h |  21 +++++++
 arch/arm64/kernel/fpsimd.c            |   2 +-
 arch/arm64/mm/fault.c                 | 114 +++++++++++++++++-----------------
 kernel/signal.c                       |   4 ++
 4 files changed, 83 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/siginfo.h b/arch/arm64/include/uapi/asm/siginfo.h
index 574d12f86039..9b4d91277742 100644
--- a/arch/arm64/include/uapi/asm/siginfo.h
+++ b/arch/arm64/include/uapi/asm/siginfo.h
@@ -21,4 +21,25 @@
 
 #include <asm-generic/siginfo.h>
 
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+/*
+ * SIGBUS si_codes
+ */
+#ifdef __KERNEL__
+#define BUS_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+/*
+ * SIGTRAP si_codes
+ */
+#ifdef __KERNEL__
+#define TRAP_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
 #endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index fae81f7964b4..ad0edf31e247 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -867,7 +867,7 @@ asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 {
 	siginfo_t info;
-	unsigned int si_code = 0;
+	unsigned int si_code = FPE_FIXME;
 
 	if (esr & FPEXC_IOF)
 		si_code = FPE_FLTINV;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9b7f89df49db..abe200587334 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -596,7 +596,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
-	info.si_code  = 0;
+	info.si_code  = BUS_FIXME;
 	if (esr & ESR_ELx_FnV)
 		info.si_addr = NULL;
 	else
@@ -607,70 +607,70 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 }
 
 static const struct fault_info fault_info[] = {
-	{ do_bad,		SIGBUS,  0,		"ttbr address size fault"	},
-	{ do_bad,		SIGBUS,  0,		"level 1 address size fault"	},
-	{ do_bad,		SIGBUS,  0,		"level 2 address size fault"	},
-	{ do_bad,		SIGBUS,  0,		"level 3 address size fault"	},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"ttbr address size fault"	},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"level 1 address size fault"	},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"level 2 address size fault"	},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"level 3 address size fault"	},
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 0 translation fault"	},
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 1 translation fault"	},
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 2 translation fault"	},
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 3 translation fault"	},
-	{ do_bad,		SIGBUS,  0,		"unknown 8"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 8"			},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 access flag fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 access flag fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 access flag fault"	},
-	{ do_bad,		SIGBUS,  0,		"unknown 12"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 12"			},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
-	{ do_sea,		SIGBUS,  0,		"synchronous external abort"	},
-	{ do_bad,		SIGBUS,  0,		"unknown 17"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
-	{ do_sea,		SIGBUS,  0,		"level 0 (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"level 1 (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"level 2 (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"level 3 (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"synchronous parity or ECC error" },	// Reserved when RAS is implemented
-	{ do_bad,		SIGBUS,  0,		"unknown 25"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 26"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 27"			},
-	{ do_sea,		SIGBUS,  0,		"level 0 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
-	{ do_sea,		SIGBUS,  0,		"level 1 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
-	{ do_sea,		SIGBUS,  0,		"level 2 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
-	{ do_sea,		SIGBUS,  0,		"level 3 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
-	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"synchronous external abort"	},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 17"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 18"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 19"			},
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 0 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 1 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 2 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 3 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"synchronous parity or ECC error" },	// Reserved when RAS is implemented
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 25"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 26"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 27"			},
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 0 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 1 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 2 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
+	{ do_sea,		SIGBUS,  BUS_FIXME,	"level 3 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 32"			},
 	{ do_alignment_fault,	SIGBUS,  BUS_ADRALN,	"alignment fault"		},
-	{ do_bad,		SIGBUS,  0,		"unknown 34"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 35"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 36"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 37"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 38"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 39"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 40"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 41"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 42"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 43"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 44"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 45"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 46"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 47"			},
-	{ do_bad,		SIGBUS,  0,		"TLB conflict abort"		},
-	{ do_bad,		SIGBUS,  0,		"Unsupported atomic hardware update fault"	},
-	{ do_bad,		SIGBUS,  0,		"unknown 50"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 51"			},
-	{ do_bad,		SIGBUS,  0,		"implementation fault (lockdown abort)" },
-	{ do_bad,		SIGBUS,  0,		"implementation fault (unsupported exclusive)" },
-	{ do_bad,		SIGBUS,  0,		"unknown 54"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 55"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 56"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 57"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 58" 			},
-	{ do_bad,		SIGBUS,  0,		"unknown 59"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 60"			},
-	{ do_bad,		SIGBUS,  0,		"section domain fault"		},
-	{ do_bad,		SIGBUS,  0,		"page domain fault"		},
-	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 34"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 35"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 36"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 37"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 38"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 39"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 40"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 41"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 42"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 43"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 44"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 45"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 46"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 47"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"TLB conflict abort"		},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"Unsupported atomic hardware update fault"	},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 50"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 51"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"implementation fault (lockdown abort)" },
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"implementation fault (unsupported exclusive)" },
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 54"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 55"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 56"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 57"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 58" 			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 59"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 60"			},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"section domain fault"		},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"page domain fault"		},
+	{ do_bad,		SIGBUS,  BUS_FIXME,	"unknown 63"			},
 };
 
 int handle_guest_sea(phys_addr_t addr, unsigned int esr)
@@ -739,11 +739,11 @@ static struct fault_info __refdata debug_fault_info[] = {
 	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware breakpoint"	},
 	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware single-step"	},
 	{ do_bad,	SIGTRAP,	TRAP_HWBKPT,	"hardware watchpoint"	},
-	{ do_bad,	SIGBUS,		0,		"unknown 3"		},
+	{ do_bad,	SIGBUS,		BUS_FIXME,	"unknown 3"		},
 	{ do_bad,	SIGTRAP,	TRAP_BRKPT,	"aarch32 BKPT"		},
-	{ do_bad,	SIGTRAP,	0,		"aarch32 vector catch"	},
+	{ do_bad,	SIGTRAP,	TRAP_FIXME,	"aarch32 vector catch"	},
 	{ early_brk64,	SIGTRAP,	TRAP_BRKPT,	"aarch64 BRK"		},
-	{ do_bad,	SIGBUS,		0,		"unknown 7"		},
+	{ do_bad,	SIGBUS,		BUS_FIXME,	"unknown 7"		},
 };
 
 void __init hook_debug_fault_code(int nr,
diff --git a/kernel/signal.c b/kernel/signal.c
index c894162ec96c..fd182a845490 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2711,6 +2711,10 @@ enum siginfo_layout siginfo_layout(int sig, int si_code)
 #ifdef FPE_FIXME
 		if ((sig == SIGFPE) && (si_code == FPE_FIXME))
 			layout = SIL_FAULT;
+#endif
+#ifdef BUS_FIXME
+		if ((sig == SIGBUS) && (si_code == BUS_FIXME))
+			layout = SIL_FAULT;
 #endif
 	}
 	return layout;
-- 
2.14.1
