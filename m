Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587408;
	b=c7JTVmlYl0IUEFtp2v43cGez1TD0+bEHRSG4lsKsa9AzE9a/FZjMa+8c3nKZfYQtktMm
	 gj6XKOs41ZdsUWHrbCiQ9syfEXkOJtNO9AqsoQ2B8JSUkFqhLw4vwCS48wIk0Eb5VjWow
	 8SumZQ6s03GD3h+BXeR0+pnWOHRf7GiinRk/Vf+FiPG/p83XmCRYeLhtRfvyAG6AnGV5C
	 h1124MgaTli+aNCSVTml7IsMFdopmVtYBqLxhyqfsfLhOfeeMB3oozz+TAzbIOJLYGk9h
	 s+PF7JbGxIqGeIaRBQepu+foC4PSShG2B8Z3M0fZj2WJf3cX4+vMHsHLHMd1BhKKU/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XJ5Bj2HUeqnSIN+0jmezTl4ea1LIGCfrIoPbd+y7XVY=;
	b=yJnvt98lTM/dqEZ/nQ0NbG7ETonFOzyyq8JC4LzUPuuxcjFKo8BNoZWDOHL/pRoB5Br6
	 JugeWAbQ7YB6dZriERLEPlEENW7zhLkuMYZ62zTvj0azMD0+JswMVcI+6PNhxRbytwc1r
	 CB8FRA79jSK6VKlAvuzs8/D2OsQCjufMEOxkQAiiHJq5/VQ+PFug+b5+L2ZYjJUxELhoD
	 w0J432If+OXvMyo8+B5uz7WE0dOB8f6gfIi2t65k9wmOfh8XEs3xqD0wQ1cFQKy/Rlmtu
	 CCvpIqVScRaLOMjvM6rrOb9hGosXv9jhxdK7X7A1D0gCIMEvm2z6MHKVOTgG+ja8X4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gsUjsxJz;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748F607AC02
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 06:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5748F607AC02
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gsUjsxJz
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso5633011c88.0
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 22:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587407; x=1796192207; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJ5Bj2HUeqnSIN+0jmezTl4ea1LIGCfrIoPbd+y7XVY=;
        b=gsUjsxJzxqbgYYkDSx9uXucgzZ5AeLgCj1D+KrrG5svWAHGAA4GODKnBkdm2Tiv0gw
         IiEI8E4vsnQ8k65vGaOpqpaPHJU2pdFcUZ+qRJJkHZMcQqdZrL/aHRGUTQByUqNhq3iT
         1Qd8suAqAONYzmciLD0Mk+aC8VP5TFpaUhgE+sA4LrXZhYf+MBCiCmdLf29PGauN2aOE
         GCUoHTMbh4CM0Nmm6dR/fHc2oH5cc2tfVHxQL2eg6dFmMAl+tMcuL88x9zhB+mXBHqkm
         wCKYstkzIyLefoBkh8OJrGXanJDHjoZT3IVpJHybG1NAjyBmGwy+nPKPqVhFeRJzMK4I
         3pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587407; x=1796192207;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJ5Bj2HUeqnSIN+0jmezTl4ea1LIGCfrIoPbd+y7XVY=;
        b=XiaDr8eQH/4itj69KiinCqiMJAr0iYigS3FKeUWPw+1siuuHQoc6ZU3GalfAeH2ZSV
         PeH+KPLEcZeHwTUc/8zxzQC4drB+eq88MoW4OfE7Nb1iAgml16u5T7zhn14S6VuF3gvE
         2uSkGqdGJwcI2jFwiOtKjNLzVrcTTjWwlcWZn0/+NYzZK4fu+0bn3jTnmWkWLWKbzNqH
         ZPdnOlNESp8tly8dRr8UFN6efR+8hKTpf32hw2Ho8OUpqzlGtrtvXFgbehGTfJUht2+I
         3qIR7+egR3vWN37XrwtzHXXH86F0qJR28n9txBm21RwUdaQY93wKLDz4VyDzM48Vgkxz
         5pOQ==
X-Forwarded-Encrypted: i=1; AL+hErHy0/ELgzE9A7nCW1/6QGCxXW2ezRVPWa+nkZWYWe78Zvg2vFVPd729Akv+Xc75y5m7fOryXKMGVGHd@vger.kernel.org
X-Gm-Message-State: APuU4Z94cFh21dGyOUaxIau5mN4KGSHIFO+9wgWbssKpZ6p4pBq9I8gu
	GOIx0Zn+RK2EGENz4ny2ffA/YuTuKO4F+WM3lO380viHq4qfkC2mxrLuGhXoR3ASJStadckN6FA
	0ZTfAdeSbzQ==
X-Received: from dlar8.prod.google.com ([2002:a05:701b:21c8:b0:1b5:345d:ed30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:cc88:10b0:151:6e80:ba7e
 with SMTP id a92af1059eb24-1b5567dcec1mr15970822c88.4.1795587407220; Tue, 24
 Nov 2026 22:16:47 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:18 -0800
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
Message-ID: <20261125061523.1540234-26-irogers@google.com>
Subject: [RFC PATCH v2 25/30] tools include: Add linux/uaccess.h stub for
 userspace tools
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

Add a minimal tools/include/linux/uaccess.h providing a no-op
might_fault() stub so userspace tools under tools/ can compile shared
kernel code that includes <linux/uaccess.h>.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/uaccess.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 tools/include/linux/uaccess.h

diff --git a/tools/include/linux/uaccess.h b/tools/include/linux/uaccess.h
new file mode 100644
index 000000000000..5a9e6bf4cfb5
--- /dev/null
+++ b/tools/include/linux/uaccess.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+#ifndef _TOOLS_INCLUDE_LINUX_UACCESS_H
+#define _TOOLS_INCLUDE_LINUX_UACCESS_H
+
+#ifndef might_fault
+#define might_fault() do { } while (0)
+#endif
+
+#endif /* _TOOLS_INCLUDE_LINUX_UACCESS_H */
-- 
2.56.1.831.g720f3f5937-goog

