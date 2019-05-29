From: Marco Elver <elver@google.com>
Subject: [PATCH 2/3] x86: Move CPU feature test out of uaccess region
Date: Wed, 29 May 2019 16:15:00 +0200
Message-ID: <20190529141500.193390-3-elver@google.com>
References: <20190529141500.193390-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529141500.193390-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, Marco Elver <elver@google.com>
List-Id: linux-arch.vger.kernel.org

This patch is a pre-requisite for enabling KASAN bitops instrumentation:
moves boot_cpu_has feature test out of the uaccess region, as
boot_cpu_has uses test_bit. With instrumentation, the KASAN check would
otherwise be flagged by objtool.

This approach is preferred over adding the explicit kasan_check_*
functions to the uaccess whitelist of objtool, as the case here appears
to be the only one.

Signed-off-by: Marco Elver <elver@google.com>
---
v1:
* This patch replaces patch: 'tools/objtool: add kasan_check_* to
  uaccess whitelist'
---
 arch/x86/ia32/ia32_signal.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 629d1ee05599..12264e3c9c43 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -333,6 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	void __user *restorer;
 	int err = 0;
 	void __user *fpstate = NULL;
+	bool has_xsave;
 
 	/* __copy_to_user optimizes that into a single 8 byte store */
 	static const struct {
@@ -352,13 +353,19 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (!access_ok(frame, sizeof(*frame)))
 		return -EFAULT;
 
+	/*
+	 * Move non-uaccess accesses out of uaccess region if not strictly
+	 * required; this also helps avoid objtool flagging these accesses with
+	 * instrumentation enabled.
+	 */
+	has_xsave = boot_cpu_has(X86_FEATURE_XSAVE);
 	put_user_try {
 		put_user_ex(sig, &frame->sig);
 		put_user_ex(ptr_to_compat(&frame->info), &frame->pinfo);
 		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
 
 		/* Create the ucontext.  */
-		if (boot_cpu_has(X86_FEATURE_XSAVE))
+		if (has_xsave)
 			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
-- 
2.22.0.rc1.257.g3120a18244-goog
