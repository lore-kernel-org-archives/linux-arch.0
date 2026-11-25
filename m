Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587374;
	b=Gx02OHB1dt28+gGZZktOhb4SU1SQ/yOW/H/iGU1AGZ5za/PF7pnCncbyZLpiEf4eQwrW
	 M8DorMr7X8YF5Yy0NmNEDDH1XLBRDPRcx3staWqk0BBjU5hNH3I07AIjkABLNHpydEGt3
	 MoH9AYeJgMoRielxUC3RcuLkfo8E49RyCv4zJfLY5m2k1ybetpa9kfeHdtI2g02iUxGB6
	 ygkJpFB1yRRmoNQPwzuf1Ce4NhatcGpPgjgVVdfTtRiWlXTOfV7Lv/cBJZgIDzNrf8Q/Y
	 eRXGmj4Q7VbOYbwK0GRbgP3jLN5Cz7WBRA4Kv7U/Jhl2plO8HmvKrgeL8/ZNF6/OgMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+3YNbw7npHYIz6vJpu6w5t/t1EQu1XAkIQnaB2DVcXE=;
	b=orVpGgzRd/D2J4RD/uM8HEC/5V3djRq/iWJHWBdNojx9TT6jtceqyO4CrbXN8RMnonSR
	 evSh65MyivFVImKtlnvPA/Z6285zHLE7QLgvNXkudnGBZFIJCKdR6bcvJ804s5v+a4FVu
	 EUg24gxxtU4OqJaDk/pmhJsEg7Ihq8qV0aopWIULi+ZUValOPhEgri/JcDz/SQDm9LvHT
	 52vrSJ65B7faYUgacIyqHjjUnOjYEIY1TWN1IPc+TsHvzrc11ZfuP1Ccf3CoQqTHtODmH
	 M9DWWO21ZpvaWUkN5E7t8f61Xv9vUjYRoKXJpWBeJTBZhs1hxo2exK+s591Sute5leA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iLdYEq6j;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A760A262F
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 06:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073A760A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iLdYEq6j
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386c3309469so1559969eec.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 22:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587373; x=1796192173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3YNbw7npHYIz6vJpu6w5t/t1EQu1XAkIQnaB2DVcXE=;
        b=iLdYEq6jPFG1k6lRURVTYgkpU0tn2xfKdgxbC9QNFC6g3K7bQcnhf9FCdYqi9Xo5uo
         SBN5Gv4/P2cgIp08qAw8QZoMsboROqKfZkGHPwrTxb0h0vSuGg6jqfV7Pdsi5ps2gvAH
         OdOhZYiJQTNxO6ZwFaUem9SrQ3LA7rcXlYT8RxQANhUprqB2xFBi/FVwPlL4f59N8akj
         B398DOc9rQ7NbwrKpH2N76vv0eAPJUQve1bVdW9SfzaT6L7W8lPsXM/WaRPCqvSfTtUy
         Gbw8nVhHeASvK7e1vBllLSDnJplJRmM16lY1l5+ob+71ZDXfeVq7x0A0bpDEjTwFslrT
         ATvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587373; x=1796192173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3YNbw7npHYIz6vJpu6w5t/t1EQu1XAkIQnaB2DVcXE=;
        b=dcHyD/rLMIQf+5ZdoAKBmKwzdhZtaOYkHF0ky68Iiz/OSZPZwz5cn9mP8bRVQVCXdm
         5N71UapJoAiqLw+jJrJNkUtoDpcDhAwLNAKmuNmNPUBMOjXQ54WfgZgH/8yJ1wOT8spv
         ve6vsDzs+YlGwyYXm5Om2Sl62NLksra8fRIZP0CUUzsMSCRSs9LEjB5vf8YVFpeQ3mDe
         cA9i4m1O9Vikb7b01Qrl+598iAwmQ3enTJVlKx4Tukvz53rUry2PqMfU3VSnEase4b9D
         6AxCiaTc/rQed2JQIy0zmbnlJMdGfo6/VxNJUvZ8CH+kaCnH+ZvZH/ie7TedEzosbU6Y
         gpZQ==
X-Forwarded-Encrypted: i=1; AL+hErEEk6T0TPlSFrmQzW/JSUfMsQhSV0CEFciag8n7Xqx7URscR04N+/KeW0Z5dfF9Y/+U+vtxDxo1yjQT@vger.kernel.org
X-Gm-Message-State: APuU4Z8UajAQ5wXaphCF7v/kUGTmeYlv7vhkwW1RWh/pV4uMYccgypBh
	iRdyULZ/atrp2ov9qhOtinVvDYwC/ifBQALL3X91xSwssvSawptzJB0F9AU9XI332Fs/it373Iz
	eNzg5mDgIow==
X-Received: from dybou2.prod.google.com ([2002:a05:7300:e5c2:b0:384:c70c:3c65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d809:20b0:386:b070:6f1c
 with SMTP id 5a478bee46e88-386b0707151mr8742111eec.21.1795587372849; Tue, 24
 Nov 2026 22:16:12 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:01 -0800
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
Message-ID: <20261125061523.1540234-9-irogers@google.com>
Subject: [RFC PATCH v2 08/30] vmlinux.lds.h: Allow architectures to emit
 custom RO_DATA sections
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

Add an optional ARCH_RODATA_SECTIONS hook inside RO_DATA() so
architectures using runtime .eh_frame / .eh_frame_hdr kernel unwinding
can place unwind tables inside write-protected RO_DATA without leaving
them in unmapped rodata/data gap pages.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/asm-generic/vmlinux.lds.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..1bde7a2a19d0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -472,6 +472,10 @@
 #endif
 #endif
 
+#ifndef ARCH_RODATA_SECTIONS
+#define ARCH_RODATA_SECTIONS
+#endif
+
 /*
  * Read only Data
  */
@@ -554,6 +558,7 @@
 	RO_EXCEPTION_TABLE						\
 	NOTES								\
 	BTF								\
+	ARCH_RODATA_SECTIONS						\
 									\
 	. = ALIGN((align));						\
 	__end_rodata = .;
-- 
2.56.1.831.g720f3f5937-goog

