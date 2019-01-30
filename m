From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 02/28] x86/asm/suspend: drop ENTRY from local data
Date: Wed, 30 Jan 2019 13:46:45 +0100
Message-ID: <20190130124711.12463-3-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

ENTRY was intended for functions and shall be paired with ENDPROC.
ENTRY also aligns symbols which creates unnecessary holes here between
data.

So drop ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64,
as these symbols are local only.

We could use SYM_DATA_LOCAL for these symbols, but it was discouraged
earlier [1].

[1] https://lkml.org/lkml/2017/4/27/244

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_32.S |  2 +-
 arch/x86/kernel/acpi/wakeup_64.S | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 0c26b1b44e51..4203d4f0c68d 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -90,7 +90,7 @@ ret_point:
 .data
 ALIGN
 ENTRY(saved_magic)	.long	0
-ENTRY(saved_eip)	.long	0
+saved_eip:		.long 0
 
 # saved registers
 saved_idt:	.long	0,0
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 50b8ed0317a3..510fa12aab73 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
 ENDPROC(do_suspend_lowlevel)
 
 .data
-ENTRY(saved_rbp)	.quad	0
-ENTRY(saved_rsi)	.quad	0
-ENTRY(saved_rdi)	.quad	0
-ENTRY(saved_rbx)	.quad	0
+saved_rbp:		.quad	0
+saved_rsi:		.quad	0
+saved_rdi:		.quad	0
+saved_rbx:		.quad	0
 
-ENTRY(saved_rip)	.quad	0
-ENTRY(saved_rsp)	.quad	0
+saved_rip:		.quad	0
+saved_rsp:		.quad	0
 
 ENTRY(saved_magic)	.quad	0
-- 
2.20.1
