From: =?UTF-8?B?dGlwLWJvdCBmb3IgS2VlcyBDb29rIDx0aXBib3RAenl0b3IuY29tPg==?=@zytor.com
Subject: =?UTF-8?B?W3RpcDptbS9yZWFkb25seV0gbGtkdG06IFZlcmlmeSB0aGF0ICdfX3JvX2FmdGU=?=
 =?UTF-8?B?cl9pbml0JyB3b3JrcyBjb3JyZWN0bHk=?=
Date: Mon, 22 Feb 2016 04:19:57 -0800
Message-ID: <tip-7cca071ccbd2a293ea69168ace6abbcdce53098e@git.kernel.org>
References: <1455748879-21872-6-git-send-email-keescook@chromium.org>
Reply-To: minipli@googlemail.com, linux-arch@vger.kernel.org,
	  torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	  bp@alien8.de, brgerst@gmail.com, peterz@infradead.org,
	  mingo@kernel.org, dvlasenk@redhat.com, tglx@linutronix.de,
	  arnd@arndb.de, david.brown@linaro.org, luto@amacapital.net,
	  pageexec@freemail.hu, keescook@chromium.org, re.emese@gmail.com,
	  mpe@ellerman.id.au, hpa@zytor.com
Mime-Version: =?UTF-8?B?MS4w?=
Content-Type: =?UTF-8?B?dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA==?=
Content-Transfer-Encoding: =?UTF-8?B?OGJpdA==?=
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455748879-21872-6-git-send-email-keescook@chromium.org>
Content-Disposition: =?UTF-8?B?aW5saW5l?=
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?bGludXgtdGlwLWNvbW1pdHNAdmdlci5rZXJuZWwub3Jn?=@zytor.com
Cc: linux-kernel@vger.kernel.org, brgerst@gmail.com, bp@alien8.de, peterz@infradead.org, mingo@kernel.org, dvlasenk@redhat.com, minipli@googlemail.com, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, mpe@ellerman.id.au, hpa@zytor.com, tglx@linutronix.de, arnd@arndb.de, david.brown@linaro.org, luto@amacapital.net, pageexec@freemail.hu, keescook@chromium.org, re.emese@gmail.com
List-Id: linux-arch.vger.kernel.org

Commit-ID:  7cca071ccbd2a293ea69168ace6abbcdce53098e
Gitweb:     http://git.kernel.org/tip/7cca071ccbd2a293ea69168ace6abbcdce53098e
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 17 Feb 2016 14:41:16 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Feb 2016 08:51:38 +0100

lkdtm: Verify that '__ro_after_init' works correctly

The new __ro_after_init section should be writable before init, but
not after. Validate that it gets updated at init and can't be written
to afterwards.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Brown <david.brown@linaro.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: PaX Team <pageexec@freemail.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-arch <linux-arch@vger.kernel.org>
Link: http://lkml.kernel.org/r/1455748879-21872-6-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/misc/lkdtm.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm.c b/drivers/misc/lkdtm.c
index 11fdadc..2a6eaf1 100644
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
