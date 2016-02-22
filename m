From: =?UTF-8?B?dGlwLWJvdCBmb3IgRGF2aWQgQnJvd24gPHRpcGJvdEB6eXRvci5jb20+?=@zytor.com
Subject: =?UTF-8?B?W3RpcDptbS9yZWFkb25seV0gQVJNL3Zkc286IE1hcmsgdGhlIHZEU08gY29kZSA=?=
 =?UTF-8?B?cmVhZC1vbmx5IGFmdGVyIGluaXQ=?=
Date: Mon, 22 Feb 2016 04:20:45 -0800
Message-ID: <tip-11bf9b865898961cee60a41c483c9f27ec76e12e@git.kernel.org>
References: <1455748879-21872-8-git-send-email-keescook@chromium.org>
Reply-To: tglx@linutronix.de, keescook@chromium.org, re.emese@gmail.com,
	  pageexec@freemail.hu, bp@alien8.de, linux-arch@vger.kernel.org,
	  hpa@zytor.com, luto@amacapital.net, arnd@arndb.de,
	  linux-kernel@vger.kernel.org, david.brown@linaro.org,
	  torvalds@linux-foundation.org, brgerst@gmail.com,
	  minipli@googlemail.com, linux@arm.linux.org.uk,
	  dvlasenk@redhat.com, nathan_lynch@mentor.com, mpe@ellerman.id.au,
	  spender@grsecurity.net, mingo@kernel.org, peterz@infradead.org
Mime-Version: =?UTF-8?B?MS4w?=
Content-Type: =?UTF-8?B?dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA==?=
Content-Transfer-Encoding: =?UTF-8?B?OGJpdA==?=
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455748879-21872-8-git-send-email-keescook@chromium.org>
Content-Disposition: =?UTF-8?B?aW5saW5l?=
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?bGludXgtdGlwLWNvbW1pdHNAdmdlci5rZXJuZWwub3Jn?=@zytor.com
Cc: hpa@zytor.com, linux-arch@vger.kernel.org, bp@alien8.de, re.emese@gmail.com, pageexec@freemail.hu, keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org, spender@grsecurity.net, mpe@ellerman.id.au, mingo@kernel.org, dvlasenk@redhat.com, nathan_lynch@mentor.com, linux@arm.linux.org.uk, brgerst@gmail.com, minipli@googlemail.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, david.brown@linaro.org, luto@amacapital.net, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

Commit-ID:  11bf9b865898961cee60a41c483c9f27ec76e12e
Gitweb:     http://git.kernel.org/tip/11bf9b865898961cee60a41c483c9f27ec76e12e
Author:     David Brown <david.brown@linaro.org>
AuthorDate: Wed, 17 Feb 2016 14:41:18 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Feb 2016 08:51:39 +0100

ARM/vdso: Mark the vDSO code read-only after init

Although the ARM vDSO is cleanly separated by code/data with the code
being read-only in userspace mappings, the code page is still writable
from the kernel.

There have been exploits (such as http://itszn.com/blog/?p=21) that
take advantage of this on x86 to go from a bad kernel write to full
root.

Prevent this specific exploit class on ARM as well by putting the vDSO
code page in post-init read-only memory as well.

Before:
	vdso: 1 text pages at base 80927000
	root@Vexpress:/ cat /sys/kernel/debug/kernel_page_tables
	---[ Modules ]---
	---[ Kernel Mapping ]---
	0x80000000-0x80100000           1M     RW NX SHD
	0x80100000-0x80600000           5M     ro x  SHD
	0x80600000-0x80800000           2M     ro NX SHD
	0x80800000-0xbe000000         984M     RW NX SHD

After:
	vdso: 1 text pages at base 8072b000
	root@Vexpress:/ cat /sys/kernel/debug/kernel_page_tables
	---[ Modules ]---
	---[ Kernel Mapping ]---
	0x80000000-0x80100000           1M     RW NX SHD
	0x80100000-0x80600000           5M     ro x  SHD
	0x80600000-0x80800000           2M     ro NX SHD
	0x80800000-0xbe000000         984M     RW NX SHD

Inspired by https://lkml.org/lkml/2016/1/19/494 based on work by the
PaX Team, Brad Spengler, and Kees Cook.

Signed-off-by: David Brown <david.brown@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brad Spengler <spender@grsecurity.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: PaX Team <pageexec@freemail.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-arch <linux-arch@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/1455748879-21872-8-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/vdso/vdso.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/vdso/vdso.S b/arch/arm/vdso/vdso.S
index b2b97e3..a62a7b6 100644
--- a/arch/arm/vdso/vdso.S
+++ b/arch/arm/vdso/vdso.S
@@ -23,9 +23,8 @@
 #include <linux/const.h>
 #include <asm/page.h>
 
-	__PAGE_ALIGNED_DATA
-
 	.globl vdso_start, vdso_end
+	.section .data..ro_after_init
 	.balign PAGE_SIZE
 vdso_start:
 	.incbin "arch/arm/vdso/vdso.so"
