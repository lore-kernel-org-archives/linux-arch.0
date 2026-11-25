Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587418;
	b=oxhstdj4T092HNvyGDfqpEnFI7lzRbWF2D+Qg1cHnbLNQDnbWgsTsHa0Jn9IpqyViYh2
	 oatIgRhsbD/tGkGTfB1anhCoVMylGw1iTy0CRMSKAIQ2WBrMNbCyEExEamKUjXgUXxkys
	 1NUUUuQ1gWej72ZDFT2qi85RoFObhqAnF9v9EiE6s0/9D9lz+eMJtIsBLa1vviQL+IOjr
	 WoQpOqSVCIDmjUmOnbdUokIO/SAKXyoYgqF4ydOMAwpcwSw1SLZhO5+e8bmahsqzDHRaR
	 lsCM5N0NKBO9UTLZ1T52l1/7PNRw54y76vlhJqE4qACnvVk4D2Gg8V3sE+SNmyveUJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=B0szZcyaY7NP1HowgKnJWSVhbM1uN8jco8rE2rfxzUA=;
	b=2CMlcjjNdRxiQu3n0Gq/cGQ8ZO20T90BRAT3NqiTGSzxbjhVjELywaPqB8tv/msjYpmK
	 cVpsflgOTaU9tHNDxgc7jFZUDPJlNrjPgFT+u1hHTrR7uox0WBvDw5J7FaGKV/vLF2Oqu
	 F+DX2H+PRnaJe/EoktG3ulg4SeIiAg25Qz9iFp6ZWTcNQTNTdX2cIXjHfRF0L11iHfhE5
	 iHUfXuYQeZ29yj4DLfM5Qgk1qGhxaI/KkptaIxTIcW6M3VTHo9nBqua95jCdF5sztgsJ9
	 MnEY14AoBZJ15Yx4VFGE/SHHs9wnmJZKBVmsHc9+oad6JmWh6goMO7NjTOZ15oxLERw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kna0ptG2;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32A607AC37
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 06:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C32A607AC37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kna0ptG2
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b7614e9762so3912102b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 22:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587417; x=1796192217; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0szZcyaY7NP1HowgKnJWSVhbM1uN8jco8rE2rfxzUA=;
        b=kna0ptG2rOD+u8BFm9rkIM0G8vfVVG1IDhNUJYlA2YjOUj4U282XBMzTnLlyyjh9g7
         wf93+5GO27bEibDKxNqEVpHm71vN2SrwbYXVkVaFTMNSVuhGlVOX77uQVFhRbGV7JysN
         pJvO5GhFVOwWv3AY/yX1KTD0XsomdfaT97hrTb6Mstpe6XtR1DZK3o20g9LkLlQy19+P
         jUaMSt7hcJ0DQlmmAjWcEP4c2BVIDNCQdlrPTXIM96nOxcOTDeGpKvi+D1XBo4yVS8R+
         b+IOnhKSSbjaowvXOFXbuLs4Zk/hhGEvJWCJr+erxxJV9gjCsrNsBAKOeR1cwy1LpOS5
         xFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587417; x=1796192217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B0szZcyaY7NP1HowgKnJWSVhbM1uN8jco8rE2rfxzUA=;
        b=F7WxokGddmOXiwsE1kKRddypMR1i9T9lXi0zF0C1+R80gRKzK/ae2R2w8bY1o7fkA4
         ilrmpFERd+WEp5NcqNUj04EKLRjI6g7YEk6U5/t+cO7CNmkJ+O9rOkOXhy25/MoYjaWU
         1Ar+hSKQIUg/5tyc61lCS2gqTzqniLNpmSMZerHvyE1rmgjTXJMwIUiNCbEN3TGI+A7T
         XP+BM2oyxR4OztZBkJxBMvx8HoxeAG5Ytc/BlDCrHXCsBWi7PCRQGFrxVBht5dEdb+lR
         AojJtaN+5yPJFyxQhQgtW5G2MMbetJak1f/O79nLUBZA0RoLaQDffSIH/Swt6nbNABwC
         0F8Q==
X-Forwarded-Encrypted: i=1; AL+hErHffh88Jqep46MiCaI+dUASGgjwSaCEVyR+j0fHj9pGO4WSEvejJAy13iLWp37m5/E6wNKYT9VXikyW@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y1G7M+wEcer8tDLY3EVvnndo1KtJIh5vnxwTX8AirJ+egvH3h
	lzClPMtH1Q+0e3uIlgF406u0Pjd9SFqW0eBfPvHm8DMXb5ALsqN5L0bJ+C1r6VCwQg4cnVQ60sh
	c6We5Pn3ewQ==
X-Received: from pgin21-n1.prod.google.com ([2002:a05:6a02:8795:10b0:cdb:932c:948b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8095:b0:3dd:85a8:cac8
 with SMTP id adf61e73a8af0-4014c949c92mr14160775637.31.1795587417428; Tue, 24
 Nov 2026 22:16:57 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:23 -0800
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
Message-ID: <20261125061523.1540234-31-irogers@google.com>
Subject: [RFC PATCH v2 30/30] MAINTAINERS: Add DWARF CFI stack unwinding entry
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

Add a MAINTAINERS entry for Minimal DWARF CFI stack unwinding covering
the core .eh_frame / .eh_frame_hdr bytecode interpreter and KUnit tests,
the user-space PT_GNU_EH_FRAME VMA unwinder, the x86-64 DWARF CFI kernel
unwinder, the build-time .eh_frame minifier and analyzer scripts, the
standalone tools/unwind/ CFI verifier, and the deferred user-space CFI
kselftest.

Also add arch/*/include/asm/unwind_user*.h to USERSPACE STACK UNWINDING
so architectural unwind_user headers on x86, arm64, riscv, and future
ports are routed to the user-space unwinding maintainers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8..0584279d745e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9496,6 +9496,21 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/usb/dvb-usb-v2/dvb_usb*
 F:	drivers/media/usb/dvb-usb-v2/usb_urb.c
 
+DWARF CFI STACK UNWINDING
+M:	Ian Rogers <irogers@google.com>
+L:	linux-trace-kernel@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	arch/x86/kernel/unwind_dwarf.c
+F:	include/linux/unwind_dwarf_cfi.h
+F:	kernel/unwind/dwarf_cfi*.c
+F:	kernel/unwind/user_cfi.c
+F:	scripts/eh_frame_min.py
+F:	scripts/min_eh_frame.c
+F:	tools/include/linux/unwind_dwarf_cfi.h
+F:	tools/testing/selftests/perf_events/unwind_user_cfi.c
+F:	tools/unwind/
+
 DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
@@ -29300,6 +29315,7 @@ USERSPACE STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	arch/*/include/asm/unwind_user*.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
-- 
2.56.1.831.g720f3f5937-goog

