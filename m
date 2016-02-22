From: =?UTF-8?B?dGlwLWJvdCBmb3IgS2VlcyBDb29rIDx0aXBib3RAenl0b3IuY29tPg==?=@zytor.com
Subject: =?UTF-8?B?W3RpcDptbS9yZWFkb25seV0geDg2L3Zkc286IE1hcmsgdGhlIHZEU08gY29kZSA=?=
 =?UTF-8?B?cmVhZC1vbmx5IGFmdGVyIGluaXQ=?=
Date: Mon, 22 Feb 2016 04:20:21 -0800
Message-ID: <tip-018ef8dcf3de5f62e2cc1a9273cc27e1c6ba8de5@git.kernel.org>
References: <1455748879-21872-7-git-send-email-keescook@chromium.org>
Reply-To: arnd@arndb.de, brgerst@gmail.com, re.emese@gmail.com,
	  tglx@linutronix.de, pageexec@freemail.hu,
	  torvalds@linux-foundation.org, minipli@googlemail.com,
	  hpa@zytor.com, peterz@infradead.org, bp@alien8.de,
	  linux-kernel@vger.kernel.org, luto@kernel.org,
	  spender@grsecurity.net, dvlasenk@redhat.com, mingo@kernel.org,
	  luto@amacapital.net, david.brown@linaro.org, mpe@ellerman.id.au,
	  keescook@chromium.org, hpa@linux.intel.com,
	  linux-arch@vger.kernel.org
Mime-Version: =?UTF-8?B?MS4w?=
Content-Type: =?UTF-8?B?dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA==?=
Content-Transfer-Encoding: =?UTF-8?B?OGJpdA==?=
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455748879-21872-7-git-send-email-keescook@chromium.org>
Content-Disposition: =?UTF-8?B?aW5saW5l?=
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?bGludXgtdGlwLWNvbW1pdHNAdmdlci5rZXJuZWwub3Jn?=@zytor.com
Cc: luto@amacapital.net, david.brown@linaro.org, mpe@ellerman.id.au, keescook@chromium.org, hpa@linux.intel.com, linux-arch@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org, luto@kernel.org, spender@grsecurity.net, dvlasenk@redhat.com, mingo@kernel.org, pageexec@freemail.hu, tglx@linutronix.de, hpa@zytor.com, minipli@googlemail.com, torvalds@linux-foundation.org, peterz@infradead.org, arnd@arndb.de, brgerst@gmail.com, re.emese@gmail.com
List-Id: linux-arch.vger.kernel.org

Commit-ID:  018ef8dcf3de5f62e2cc1a9273cc27e1c6ba8de5
Gitweb:     http://git.kernel.org/tip/018ef8dcf3de5f62e2cc1a9273cc27e1c6ba8de5
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 17 Feb 2016 14:41:17 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Feb 2016 08:51:39 +0100

x86/vdso: Mark the vDSO code read-only after init

The vDSO does not need to be writable after __init, so mark it as
__ro_after_init. The result kills the exploit method of writing to the
vDSO from kernel space resulting in userspace executing the modified code,
as shown here to bypass SMEP restrictions: http://itszn.com/blog/?p=21

The memory map (with added vDSO address reporting) shows the vDSO moving
into read-only memory:

Before:
	[    0.143067] vDSO @ ffffffff82004000
	[    0.143551] vDSO @ ffffffff82006000
	---[ High Kernel Mapping ]---
	0xffffffff80000000-0xffffffff81000000      16M                         pmd
	0xffffffff81000000-0xffffffff81800000       8M   ro     PSE     GLB x  pmd
	0xffffffff81800000-0xffffffff819f3000    1996K   ro             GLB x  pte
	0xffffffff819f3000-0xffffffff81a00000      52K   ro                 NX pte
	0xffffffff81a00000-0xffffffff81e00000       4M   ro     PSE     GLB NX pmd
	0xffffffff81e00000-0xffffffff81e05000      20K   ro             GLB NX pte
	0xffffffff81e05000-0xffffffff82000000    2028K   ro                 NX pte
	0xffffffff82000000-0xffffffff8214f000    1340K   RW             GLB NX pte
	0xffffffff8214f000-0xffffffff82281000    1224K   RW                 NX pte
	0xffffffff82281000-0xffffffff82400000    1532K   RW             GLB NX pte
	0xffffffff82400000-0xffffffff83200000      14M   RW     PSE     GLB NX pmd
	0xffffffff83200000-0xffffffffc0000000     974M                         pmd

After:
	[    0.145062] vDSO @ ffffffff81da1000
	[    0.146057] vDSO @ ffffffff81da4000
	---[ High Kernel Mapping ]---
	0xffffffff80000000-0xffffffff81000000      16M                         pmd
	0xffffffff81000000-0xffffffff81800000       8M   ro     PSE     GLB x  pmd
	0xffffffff81800000-0xffffffff819f3000    1996K   ro             GLB x  pte
	0xffffffff819f3000-0xffffffff81a00000      52K   ro                 NX pte
	0xffffffff81a00000-0xffffffff81e00000       4M   ro     PSE     GLB NX pmd
	0xffffffff81e00000-0xffffffff81e0b000      44K   ro             GLB NX pte
	0xffffffff81e0b000-0xffffffff82000000    2004K   ro                 NX pte
	0xffffffff82000000-0xffffffff8214c000    1328K   RW             GLB NX pte
	0xffffffff8214c000-0xffffffff8227e000    1224K   RW                 NX pte
	0xffffffff8227e000-0xffffffff82400000    1544K   RW             GLB NX pte
	0xffffffff82400000-0xffffffff83200000      14M   RW     PSE     GLB NX pmd
	0xffffffff83200000-0xffffffffc0000000     974M                         pmd

Based on work by PaX Team and Brad Spengler.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: H. Peter Anvin <hpa@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brad Spengler <spender@grsecurity.net>
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
Link: http://lkml.kernel.org/r/1455748879-21872-7-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vdso2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 0224987..3f69326 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -140,7 +140,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "#include <asm/vdso.h>\n");
 	fprintf(outfile, "\n");
 	fprintf(outfile,
-		"static unsigned char raw_data[%lu] __page_aligned_data = {",
+		"static unsigned char raw_data[%lu] __ro_after_init __aligned(PAGE_SIZE) = {",
 		mapping_size);
 	for (j = 0; j < stripped_len; j++) {
 		if (j % 10 == 0)
