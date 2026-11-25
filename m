Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587366;
	b=Aitob6UGqQUfpzn36KA6UOJtsu0znVxKbY1MTkfsvYg6aKgBX70OMaMZzXACHYir5TYj
	 nBh/FJMw9Ac5NfH5cbPU4VOgk+D2z3w+a7x2+b4opb5XDwEHnWod+U52ioWX+fI8XM3TA
	 1o/0ndi5TqO2mLRW3sKYYeirIrOX6nx8xS8R/MxY1PY/i4JY/030dgL2FyVn1CYtNqsuC
	 qo/RIgo8gAAynbu1Q6mwm404iT1LfzPVZwT2dKcAXlah4w6wmHfW6X5BbYPGU3TQabv+v
	 cPLqenRceJUE/KYYnOh41Tf9pLJHFiVK3dCiYhpjIOMLWb+fJhmM/r8E9hrUwHu61zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
	b=sxMzYr70qXSE8peviMsmSWUv6ygLqd962eqg9QFd6WDCxxjw6PuLCUK9+9N1YTLmgwHf
	 p6XGWkXCkgycE3+vtR80Co+FVNdMXXiWUFFKcs7PJlQkwMuW3eFg3+G98OCrXBbRIBLpJ
	 fvAl6yg0u9Ek171g9eTS0g8Qyo111Qvv941pQ94E/Qyi0eZFwS99jQ4MDPEyxCa7VdYA2
	 vlv0OZjjTLSYrR57MP4PmDJboNbKK+xoXjAF8QWO8Q8ffKPB8bKr1Sr73Y59uGVJMrAhL
	 3X3lE5TM4ANT9Jna84fLMUmk/G8LSslgzR9M4ii30sug/KR9vMe11BjC0e6HzRADTVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XBc4yd4I;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A38606DE70
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 06:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77A38606DE70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XBc4yd4I
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-383ec96a7deso6021245eec.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 22:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587365; x=1796192165; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
        b=XBc4yd4IuYHvDt/TolT0eq4CqFjuUCPoHs1qRWCRIlkUa0/ma9Bz2B/ehlL4XD70+/
         L6+Ja9pugipWLAAQ5CWFoSAiRZ+G1rGhoR8HSno+f73YqXbyKxlpUifvKG4u34DS2l7r
         QNEfZcEmteBBKozX5KWdb9OM3f6HoyiBGSJEalQ4Kt6uL2rD4/1QQ0j/syZ8y2ohh1np
         NgY6X/O278pXS3bjNr3irHwfr0XCGHOGiJS+CY2d9wZ2yWz6tSDjK6XIYeK0FmHJ8k8c
         oGYnKF5qiMgoLWaXUf06OGasQXvEIcn5I64ilKLYya0QeFqeTbZsop9rltdvX4QNJpBc
         DV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587365; x=1796192165;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
        b=blfXFDP9IZtprDcuzviOuDopp88VLB7QD0WK6T+hjsvWcpvSe1v0508YNiD1l8d49J
         8v4Fk1bdYKPbsYFBlbjTIr0Dtts/Rp1NZPQC0jP6jGdqeveaWNcQ04RsUPM/1wieHLNC
         /M8KGIEJwT9r8Bw6Qv1cwV3XawQ83cj8KwiMI/0lKp5OE+T+5ZmQGX01lRFRzMswFSIX
         raRQvWKtO6RzKFQXmJslEni1uRlySTCOSre+/BwJEeEvFPMEzONCQQI3sRB8pbYHEPWs
         /LjEAhEk7TdbMVzPyoAkE9OF6x/2dJCq9onWjY8Uvm0MQ7rbKrQ4N/AvIaBu24KiKayg
         0nRQ==
X-Forwarded-Encrypted: i=1; AL+hErHudhSf5kPTk2UNwnWuVIRuEEzYAIBD+oRENyzEiQJJ2NW/rxc5BSSa1KFjFcPSk/OUYPt06cgtKAQS@vger.kernel.org
X-Gm-Message-State: APuU4Z961CU2wAHm6k36VkQS7g8LzSt7nrBW6X1nsbXN+1ervgU4ON+i
	wS5EByIXx/ydWwVFZCAqO9pkfW48BELJ4YNWdRkvJyC7yxSEXOPG1onWKhomMve42/A7PJywXGk
	Ddnc0qjKh8w==
X-Received: from dyckx5.prod.google.com ([2002:a05:7300:c7c5:b0:386:c57e:ee36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4201:b0:385:b8f4:755d
 with SMTP id 5a478bee46e88-385b8f47ad3mr17347048eec.20.1795587364179; Tue, 24
 Nov 2026 22:16:04 -0800 (PST)
Date: Tue, 24 Nov 2026 22:14:57 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-5-irogers@google.com>
Subject: [RFC PATCH v2 04/30] x86: unwind_user: Support Minimal DWARF CFI user unwinding
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Provide unwind_user_cfi_arch() in arch/x86/include/asm/unwind_user.h for
both 64-bit x86-64 (%rsp=7, %rbp=6, %rip=16) and 32-bit IA-32 compat
(%esp=4, %ebp=5, %eip=8) user tasks, and select HAVE_UNWIND_USER_CFI on
X86_64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 47 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..c8096cf66c38 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -300,6 +300,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_CFI		if X86_64
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 6e469044e4de..1a6be08968c3 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -4,9 +4,17 @@
 
 #ifdef CONFIG_UNWIND_USER
 
+#include <linux/unwind_dwarf_cfi.h>
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
 
+/**
+ * unwind_user_word_size() - Return the user-space word size in bytes on x86
+ * @regs: User-mode register state.
+ *
+ * Return: 8 for 64-bit user mode, 4 for 32-bit IA-32/compat mode, or 0 for
+ * VM86 mode stacks which cannot be unwound.
+ */
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
 	/* We can't unwind VM86 stacks */
@@ -15,22 +23,61 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	return user_64bit_mode(regs) ? 8 : 4;
 }
 
+/**
+ * unwind_user_cfi_arch() - Populate x86/x86-64 DWARF register numbers
+ * @ws: User word size in bytes (8 for x86-64, 4 for i386).
+ * @arch: Output DWARF CFI architecture descriptor.
+ *
+ * Return: true if @ws is 4 or 8, false otherwise.
+ */
+static inline bool unwind_user_cfi_arch(unsigned int ws,
+					struct dwarf_cfi_arch *arch)
+{
+	if (ws == 8) {
+		*arch = (struct dwarf_cfi_arch){
+			.ws	= 8,
+			.sp_reg	= 7,	/* %rsp */
+			.fp_reg	= 6,	/* %rbp */
+			.ra_reg	= 16,	/* %rip */
+		};
+		return true;
+	}
+	if (ws == 4) {
+		*arch = (struct dwarf_cfi_arch){
+			.ws	= 4,
+			.sp_reg	= 4,	/* %esp */
+			.fp_reg	= 5,	/* %ebp */
+			.ra_reg	= 8,	/* %eip */
+		};
+		return true;
+	}
+	return false;
+}
+
 #endif /* CONFIG_UNWIND_USER */
 
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
 
+/* Standard x86 frame record: {saved_bp, ret_addr} at [bp, bp + 2 * ws). */
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
 	.use_fp		= true,
 
+/* At function entry before push %rbp: return address is at [sp, sp + ws). */
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= 0,				\
 	.use_fp		= false,
 
+/**
+ * unwind_user_at_function_start() - Check if @regs is at a function entry point
+ * @regs: User-mode register state.
+ *
+ * Return: true if stopped on an entry uprobe before the frame prologue ran.
+ */
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
-- 
2.56.1.831.g720f3f5937-goog

