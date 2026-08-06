Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38F175A5
	for <linux-arch@vger.kernel.org>; Thu,  6 Aug 2026 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996386; cv=none; b=L9VI6QycoimyL6hY8ZlsfTaTBuL9bi6c7xJEvagHlWur6K6/j8Y5eHAjWYF6uhOy7I9juDAOKaYwKP/yFaoJ9jh+rTT+VIEKrjTUmaWUm0DXgv8zU7yJkbr8TF/x1JlaDf35pJkuuQ3GZPTnWPqMmu3w31Go9IrYu+pFmVvHN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996386; c=relaxed/simple;
	bh=pHCAvs03OzSFVX+qIPqa6foOPR/K8ZFGe2uSb09lYXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CbzRPBtoc786dNlli8lRrdh+Wzn/bZz/rOc4o6UsbU5XVi8ZpQohBluxlsrAhdkcwzfzZmzAxG+xsTpaaefx6pF6xM0jl+10aVDHSArf4ZP2xJzdY3XxiIFqSC1VdJW6sF3trpDMe6VSbpuzjBViUhHw2kihUXcdu+x+8zHi5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBFlo68w; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBFlo68w"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e0234967aso1657304b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 05 Aug 2026 23:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785996384; x=1786601184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aF1RSvmX8B7rc4Kxz4SwFfxHIvmLzbvgGhhj59rMhOs=;
        b=eBFlo68wEacs8ey3Kqj6qN9wfBUsgwYM4GYtzmC7D7GsK982/H1MV07dsxvj5mHPak
         PRKAvXUTZsgtaqnkQpXo23vcRMefGudboybpH5p5gVoxDfGN9EvwbzZKqNHbAaJUbQOD
         7QKMvcL5s6xegmokDUq0HdJVTxJHXA5wC4h2MFqCQtddDcOmca6GlqRJAb9LCwXepnzo
         wqYaAxlM8yBwCGr5PRk+L1mFtlNO12fel7Lxr96SF2kzQZtXLNHj6ZIITjU9XucrMxDp
         Q0zguIJtbtgmik34DwyjdoWE7mARihNb4yFl1VVHrKhe1zfTLjMFKSKjnG70y71AJQmY
         3TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996384; x=1786601184;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aF1RSvmX8B7rc4Kxz4SwFfxHIvmLzbvgGhhj59rMhOs=;
        b=hP7u2Wqusn6ZhOlDi/6jBqvPUXETI43/Kp65Ykcx4BS4cQxn8S3buYkNwZTrjwy+sH
         ZC88Ewseu2SzpzR57WPaCGYWxrI9dm3BhN7HB6Fn2ceziNs0J9dJAKMnQ1XJhrUxE3Vu
         /lJmtgl/j/F46MDat2H1y9vJMo2OA1fsxPIKEFxA1nHQ0y1+eEhReomo7il1tPFfgq2w
         ND+4WviRieBoS4ziYXukHhkk6WId2DhjX1g6v7LMeI0HcNCgXX41RyMIUzb7ttoQ8p1s
         bJOV/00SMEbzKHxziDeJcjLzCLSh7qubUV0/xB25KVWLQP8o2dK8wsi6kleouZ2VTCed
         8N9A==
X-Forwarded-Encrypted: i=1; AHgh+RrQpCWQVqldntxHIj9mrMCLpsVNfPdvGqolAQI77s/ZgY79LibE2mxRBnlOlYeVy9JQhtf9VsPrXahQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRyeszsvGqhpfaQFDhn1sNPLIA7tyc4dt6LwvdhAyN/ZferFU
	Jyr2RMo1qQT9rZoF26LUJO01UpFZTF529Y3faesuaiA/ApT66FN4wraJNfqnHRiMQ66N+2wHOaJ
	LjGBzoVYtOg==
X-Received: from pfst48.prod.google.com ([2002:aa7:8fb0:0:b0:847:8ffb:40ad])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4392:b0:845:e8b5:8c49
 with SMTP id d2e1a72fcca58-84f2e03173cmr14978781b3a.10.1785996383833; Wed, 05
 Aug 2026 23:06:23 -0700 (PDT)
Date: Thu,  6 Aug 2026 06:05:48 +0000
In-Reply-To: <20260806060556.451370-1-wfelipe@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806060556.451370-1-wfelipe@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806060556.451370-3-wfelipe@google.com>
Subject: [PATCH 2/3] arch: use CONFIG_COMMAND_LINE_SIZE across all architectures
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry@kernel.org>, Wilson Felipe Pereira <wfelipe@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now that CONFIG_COMMAND_LINE_SIZE is available in init/Kconfig for all
architectures, update every architecture's setup.h header to define
COMMAND_LINE_SIZE as CONFIG_COMMAND_LINE_SIZE.

For user-space API (uapi) headers, wrap the definition in an
`#ifdef __KERNEL__` guard and retain the historical hardcoded default in
the `#else` block. When user-space headers are installed via
`make headers_install`, unifdef strips out the kernel section, ensuring
same value as before for user-space applications including `<asm/setup.h>`.

Originally-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
 arch/alpha/include/uapi/asm/setup.h      |  4 ++++
 arch/arc/include/asm/setup.h             |  2 +-
 arch/arm/include/uapi/asm/setup.h        |  6 +++++-
 arch/arm64/include/uapi/asm/setup.h      |  4 ++++
 arch/loongarch/include/uapi/asm/setup.h  |  4 ++++
 arch/m68k/include/uapi/asm/setup.h       |  6 +++++-
 arch/microblaze/include/uapi/asm/setup.h |  4 ++++
 arch/mips/include/uapi/asm/setup.h       |  4 ++++
 arch/parisc/include/uapi/asm/setup.h     |  4 ++++
 arch/powerpc/include/uapi/asm/setup.h    |  4 ++++
 arch/riscv/include/uapi/asm/setup.h      |  4 ++++
 arch/sparc/include/uapi/asm/setup.h      | 10 +++++++---
 arch/um/include/asm/setup.h              |  2 +-
 arch/x86/include/asm/setup.h             |  2 +-
 arch/xtensa/include/uapi/asm/setup.h     |  4 ++++
 include/uapi/asm-generic/setup.h         |  4 ++++
 16 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/setup.h b/arch/alpha/include/uapi/=
asm/setup.h
index f881ea5947cbc..169f743ef7658 100644
--- a/arch/alpha/include/uapi/asm/setup.h
+++ b/arch/alpha/include/uapi/asm/setup.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI__ALPHA_SETUP_H
 #define _UAPI__ALPHA_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif /* _UAPI__ALPHA_SETUP_H */
diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 1c6db599e1fcc..60e158d58cec7 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -9,7 +9,7 @@
 #include <linux/types.h>
 #include <uapi/asm/setup.h>
=20
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
=20
 /*
  * Data structure to map a ID to string
diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/=
setup.h
index 8e50e034fec73..4aa93558af1e7 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -17,7 +17,11 @@
=20
 #include <linux/types.h>
=20
-#define COMMAND_LINE_SIZE 1024
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
+#define COMMAND_LINE_SIZE	1024
+#endif
=20
 /* The list ends with an ATAG_NONE node. */
 #define ATAG_NONE	0x00000000
diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/=
asm/setup.h
index 5d703888f3511..2236890175a5a 100644
--- a/arch/arm64/include/uapi/asm/setup.h
+++ b/arch/arm64/include/uapi/asm/setup.h
@@ -22,6 +22,10 @@
=20
 #include <linux/types.h>
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	2048
+#endif
=20
 #endif
diff --git a/arch/loongarch/include/uapi/asm/setup.h b/arch/loongarch/inclu=
de/uapi/asm/setup.h
index d46363ce3e024..03c7bfa1e5d9f 100644
--- a/arch/loongarch/include/uapi/asm/setup.h
+++ b/arch/loongarch/include/uapi/asm/setup.h
@@ -3,6 +3,10 @@
 #ifndef _UAPI_ASM_LOONGARCH_SETUP_H
 #define _UAPI_ASM_LOONGARCH_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	4096
+#endif
=20
 #endif /* _UAPI_ASM_LOONGARCH_SETUP_H */
diff --git a/arch/m68k/include/uapi/asm/setup.h b/arch/m68k/include/uapi/as=
m/setup.h
index 25fe26d5597cc..2d5b24a5345f9 100644
--- a/arch/m68k/include/uapi/asm/setup.h
+++ b/arch/m68k/include/uapi/asm/setup.h
@@ -12,6 +12,10 @@
 #ifndef _UAPI_M68K_SETUP_H
 #define _UAPI_M68K_SETUP_H
=20
-#define COMMAND_LINE_SIZE 256
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
+#define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif /* _UAPI_M68K_SETUP_H */
diff --git a/arch/microblaze/include/uapi/asm/setup.h b/arch/microblaze/inc=
lude/uapi/asm/setup.h
index 16c56807f86a2..e4b253064c7d9 100644
--- a/arch/microblaze/include/uapi/asm/setup.h
+++ b/arch/microblaze/include/uapi/asm/setup.h
@@ -12,6 +12,10 @@
 #ifndef _UAPI_ASM_MICROBLAZE_SETUP_H
 #define _UAPI_ASM_MICROBLAZE_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif /* _UAPI_ASM_MICROBLAZE_SETUP_H */
diff --git a/arch/mips/include/uapi/asm/setup.h b/arch/mips/include/uapi/as=
m/setup.h
index 7d48c433b0c27..8d6c474835aec 100644
--- a/arch/mips/include/uapi/asm/setup.h
+++ b/arch/mips/include/uapi/asm/setup.h
@@ -2,7 +2,11 @@
 #ifndef _UAPI_MIPS_SETUP_H
 #define _UAPI_MIPS_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	4096
+#endif
=20
=20
 #endif /* _UAPI_MIPS_SETUP_H */
diff --git a/arch/parisc/include/uapi/asm/setup.h b/arch/parisc/include/uap=
i/asm/setup.h
index 78b2f4ec7d652..cfa77e84205dc 100644
--- a/arch/parisc/include/uapi/asm/setup.h
+++ b/arch/parisc/include/uapi/asm/setup.h
@@ -2,6 +2,10 @@
 #ifndef _PARISC_SETUP_H
 #define _PARISC_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	1024
+#endif
=20
 #endif /* _PARISC_SETUP_H */
diff --git a/arch/powerpc/include/uapi/asm/setup.h b/arch/powerpc/include/u=
api/asm/setup.h
index c54940b09d065..daa15ac4e94c6 100644
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ b/arch/powerpc/include/uapi/asm/setup.h
@@ -2,6 +2,10 @@
 #ifndef _UAPI_ASM_POWERPC_SETUP_H
 #define _UAPI_ASM_POWERPC_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	2048
+#endif
=20
 #endif /* _UAPI_ASM_POWERPC_SETUP_H */
diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/=
asm/setup.h
index eb4f0209c6960..a6c1f4b0987e3 100644
--- a/arch/riscv/include/uapi/asm/setup.h
+++ b/arch/riscv/include/uapi/asm/setup.h
@@ -3,6 +3,10 @@
 #ifndef _UAPI_ASM_RISCV_SETUP_H
 #define _UAPI_ASM_RISCV_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	2048
+#endif
=20
 #endif /* _UAPI_ASM_RISCV_SETUP_H */
diff --git a/arch/sparc/include/uapi/asm/setup.h b/arch/sparc/include/uapi/=
asm/setup.h
index 3c208a4dd4640..7054f5249a3a6 100644
--- a/arch/sparc/include/uapi/asm/setup.h
+++ b/arch/sparc/include/uapi/asm/setup.h
@@ -6,10 +6,14 @@
 #ifndef _UAPI_SPARC_SETUP_H
 #define _UAPI_SPARC_SETUP_H
=20
-#if defined(__sparc__) && defined(__arch64__)
-# define COMMAND_LINE_SIZE 2048
+#ifdef __KERNEL__
+# define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
 #else
-# define COMMAND_LINE_SIZE 256
+# if defined(__sparc__) && defined(__arch64__)
+#  define COMMAND_LINE_SIZE 2048
+# else
+#  define COMMAND_LINE_SIZE 256
+# endif
 #endif
=20
=20
diff --git a/arch/um/include/asm/setup.h b/arch/um/include/asm/setup.h
index 80ada899f2542..bc83dc4d467d3 100644
--- a/arch/um/include/asm/setup.h
+++ b/arch/um/include/asm/setup.h
@@ -6,6 +6,6 @@
  * command line, so this choice is ok.
  */
=20
-#define COMMAND_LINE_SIZE 4096
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
=20
 #endif		/* SETUP_H_INCLUDED */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 914eb32581c73..b73caf64f2199 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -4,7 +4,7 @@
=20
 #include <uapi/asm/setup.h>
=20
-#define COMMAND_LINE_SIZE 2048
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
=20
 #include <linux/linkage.h>
 #include <asm/page_types.h>
diff --git a/arch/xtensa/include/uapi/asm/setup.h b/arch/xtensa/include/uap=
i/asm/setup.h
index 5356a5fd4d173..dcf33a403527a 100644
--- a/arch/xtensa/include/uapi/asm/setup.h
+++ b/arch/xtensa/include/uapi/asm/setup.h
@@ -12,6 +12,10 @@
 #ifndef _XTENSA_SETUP_H
 #define _XTENSA_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	256
+#endif
=20
 #endif
diff --git a/include/uapi/asm-generic/setup.h b/include/uapi/asm-generic/se=
tup.h
index 88ac5100df359..b8d06e6d56bd7 100644
--- a/include/uapi/asm-generic/setup.h
+++ b/include/uapi/asm-generic/setup.h
@@ -2,6 +2,10 @@
 #ifndef __ASM_GENERIC_SETUP_H
 #define __ASM_GENERIC_SETUP_H
=20
+#ifdef __KERNEL__
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_SIZE
+#else
 #define COMMAND_LINE_SIZE	512
+#endif
=20
 #endif	/* __ASM_GENERIC_SETUP_H */
--=20
2.55.0.654.g21b8a5bc05-goog

