From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 5/7] lkdtm: verify that __ro_after_init works correctly
Date: Wed, 17 Feb 2016 14:41:16 -0800
Message-ID: <1455748879-21872-6-git-send-email-keescook@chromium.org>
References: <1455748879-21872-1-git-send-email-keescook@chromium.org>
Reply-To: kernel-hardening@lists.openwall.com
Return-path: <kernel-hardening-return-2659-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <1455748879-21872-1-git-send-email-keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, David Brown <david.brown@linaro.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

The new __ro_after_init section should be writable before init, but
not after. Validate that it gets updated at init and can't be written
to afterwards.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm.c b/drivers/misc/lkdtm.c
index 5c1351b19029..a77799d227ee 100644
--- a/drivers/misc/lkdtm.c
+++ b/drivers/misc/lkdtm.c
@@ -103,6 +103,7 @@ enum ctype {
 	CT_EXEC_USERSPACE,
 	CT_ACCESS_USERSPACE,
 	CT_WRITE_RO,
+	CT_WRITE_RO_AFTER_INIT,
 	CT_WRITE_KERN,
 };
 
@@ -140,6 +141,7 @@ static char* cp_type[] = {
 	"EXEC_USERSPACE",
 	"ACCESS_USERSPACE",
 	"WRITE_RO",
+	"WRITE_RO_AFTER_INIT",
 	"WRITE_KERN",
 };
 
@@ -162,6 +164,7 @@ static DEFINE_SPINLOCK(lock_me_up);
 static u8 data_area[EXEC_SIZE];
 
 static const unsigned long rodata = 0xAA55AA55;
+static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
 
 module_param(recur_count, int, 0644);
 MODULE_PARM_DESC(recur_count, " Recursion level for the stack overflow test");
@@ -503,11 +506,28 @@ static void lkdtm_do_action(enum ctype which)
 		break;
 	}
 	case CT_WRITE_RO: {
-		unsigned long *ptr;
+		/* Explicitly cast away "const" for the test. */
+		unsigned long *ptr = (unsigned long *)&rodata;
 
-		ptr = (unsigned long *)&rodata;
+		pr_info("attempting bad rodata write at %p\n", ptr);
+		*ptr ^= 0xabcd1234;
 
-		pr_info("attempting bad write at %p\n", ptr);
+		break;
+	}
+	case CT_WRITE_RO_AFTER_INIT: {
+		unsigned long *ptr = &ro_after_init;
+
+		/*
+		 * Verify we were written to during init. Since an Oops
+		 * is considered a "success", a failure is to just skip the
+		 * real test.
+		 */
+		if ((*ptr & 0xAA) != 0xAA) {
+			pr_info("%p was NOT written during init!?\n", ptr);
+			break;
+		}
+
+		pr_info("attempting bad ro_after_init write at %p\n", ptr);
 		*ptr ^= 0xabcd1234;
 
 		break;
@@ -817,6 +837,9 @@ static int __init lkdtm_module_init(void)
 	int n_debugfs_entries = 1; /* Assume only the direct entry */
 	int i;
 
+	/* Make sure we can write to __ro_after_init values during __init */
+	ro_after_init |= 0xAA;
+
 	/* Register debugfs interface */
 	lkdtm_debugfs_root = debugfs_create_dir("provoke-crash", NULL);
 	if (!lkdtm_debugfs_root) {
-- 
2.6.3
