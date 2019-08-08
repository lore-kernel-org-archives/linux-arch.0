From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 08/28] x86/uaccess: annotate local function
Date: Thu,  8 Aug 2019 12:38:34 +0200
Message-ID: <20190808103854.6192-9-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-arch.vger.kernel.org

copy_user_handle_tail is a self-standing local function, annotate it as
such using SYM_FUNC_START_LOCAL.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/lib/copy_user_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 4fe1601dbc5d..d163c9566abe 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -230,8 +230,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Output:
  * eax uncopied bytes or 0 if successful.
  */
-ALIGN;
-copy_user_handle_tail:
+SYM_CODE_START_LOCAL(copy_user_handle_tail)
 	movl %edx,%ecx
 1:	rep movsb
 2:	mov %ecx,%eax
@@ -239,7 +238,7 @@ copy_user_handle_tail:
 	ret
 
 	_ASM_EXTABLE_UA(1b, 2b)
-END(copy_user_handle_tail)
+SYM_CODE_END(copy_user_handle_tail)
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
-- 
2.22.0
