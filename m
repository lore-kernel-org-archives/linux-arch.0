Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323213BB123
	for <linux-arch@vger.kernel.org>; Thu,  6 Aug 2026 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996883; cv=none; b=ZubVqv8/nLnlpmVVucwVG79gEKOK++F4ugd42cx4prThemko6YV2do7/EgEZRr94H1dX8wqDcCFNFBxkkwBUM9FbZ9VynjHJf7ZDYVOjYPFWMqawCWY4OlzV7gQbU3JvaSy8zihShL5rjIanh7kZQkVAmqYR9uzKnoGSJ9j4XZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996883; c=relaxed/simple;
	bh=OgU5gXUlLv5U2W5LPETZfCP4rOZqfZJQHAe9BKZ+SUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mWan+iPJ/8FbekcYwusJ40j56UkHZTLpa+RuXXF1bDbV+meqFTh7UgvmETRSxiwhMI1kCIZv/2++yMb578B4Gk04rmZLTfwvYaJFcJ32phBgVwL1+JgJLnaFxRbmnqEyvgGf/IfdD7kF3I1R0vW3WZzCOqLBF3GVziBxSleD144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGLuoek8; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wfelipe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGLuoek8"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so2597810a91.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Aug 2026 23:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785996881; x=1786601681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gz3BQ2fYyBKXfHfqnwVRQtDtnTfYUw4BfeW+CpBaGNw=;
        b=QGLuoek82WsGEb4d/i61/xDp8chLf9hYjH4Etjtd/U+59KtrAfJroZFwWk82dfuDqG
         yC9A6cMboiXmCqNgY6YvdE2HhcxY36bBK5l8PMyIp3l8UyuLfS4unHjH1SWxIrYNaPeS
         pRI4Td4I+tq7AH/BpjQrlb9ePKxPA25uHLFCWT9bUQ3AYRUMzw0yoZslqck4LXSOWUMm
         jfUGoAFAtk/aHosxPgzsP6yddguPmMw8iJUV2bES9LCVeJa2XmRSW5D10+UIVNZXvncN
         cXHpJ6uezqlPRZzmFnxMd/Eu1dUxoGKHoHNfTcO15uJ2FMqzsKwfsAc2EDVqyCYXf11T
         geCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996881; x=1786601681;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gz3BQ2fYyBKXfHfqnwVRQtDtnTfYUw4BfeW+CpBaGNw=;
        b=CLY4+thYOxDdiToS2zyBFe5oBBDTMH8ZQke1NEU4UDl08Ei8woy5SVc+y7V3JAMJRc
         fPgIsICzVZeJ9YQx56YdNVxnWIQ/VSg94OhGKsM/eTI8GWOtxZyVGWRHeBeV1VLeMUQG
         kQ2xeubAZSPM2JnJgHexSvZErE3itiuIQPOm+mfeArX2kZJA0CA8gvvGXk4maTOTWKNO
         JfpnPfCA3/FdUQ3QD806Z1QYerIHx9JtdDLqhQkajmrwtrkarSWX06MvkAFU9a/pv0dG
         6NOSZn5oWWV3M/QM4KRT0YntyAo84tqOHw5zsose1zuV7FdqAp1mdd1/ze994GeWLoqC
         bktA==
X-Forwarded-Encrypted: i=1; AHgh+RpJaH+efDQMvQTUfNGIoUV2s4KAguiA8SskWIrPvJ6mrp08/52iB5E1M029cpjs0wRfYTbv8ufRSfUg@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNA32U/CFYNGltGzHQiF6boKr737pK3FGpHr1dYsMtnutbMsa
	YSpj8rgdhEEXUJZ5Lu/xyLmaXLgGrEETEgcPmhlTwbFXiNEza6vSCCj/99QLxMO3qtUhtGjhEnr
	H0ZXxDUFBPw==
X-Received: from pjbmv17.prod.google.com ([2002:a17:90b:1991:b0:38e:74f4:7e63])
 (user=wfelipe job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d50:b0:380:f34a:6ff1
 with SMTP id 98e67ed59e1d1-3903c5e0213mr12490257a91.17.1785996881120; Wed, 05
 Aug 2026 23:14:41 -0700 (PDT)
Date: Thu,  6 Aug 2026 06:14:14 +0000
In-Reply-To: <20260806061429.474992-1-wfelipe@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806061429.474992-1-wfelipe@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806061429.474992-2-wfelipe@google.com>
Subject: [PATCH 1/3] init/Kconfig: generalize config COMMAND_LINE_SIZE to all architectures
From: Wilson Felipe Pereira <wfelipe@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Wilson Felipe Pereira <wfelipe@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, only s390 has the ability to configure the maximum kernel
command line size via Kconfig (CONFIG_COMMAND_LINE_SIZE). Other
architectures define a hardcoded COMMAND_LINE_SIZE macro in their setup.sh
headers.

In some use cases, such as netboot kernels, rootfs configurations, larger
initramfs setups, require larger sizes. While for embedded workloads, it
can be reduced to save memory.

Move config COMMAND_LINE_SIZE out of arch/s390/Kconfig and into
init/Kconfig under General setup so that all architectures can configure
their maximum command line length. The default values were added to keep
the values unchanged.

Originally-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Wilson Felipe Pereira <wfelipe@google.com>
---
 arch/s390/Kconfig |  8 --------
 init/Kconfig      | 12 ++++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d50..f5536e042ce29 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -511,14 +511,6 @@ endchoice
 config 64BIT
 	def_bool y
=20
-config COMMAND_LINE_SIZE
-	int "Maximum size of kernel command line"
-	default 4096
-	range 896 1048576
-	help
-	  This allows you to specify the maximum length of the kernel command
-	  line.
-
 config SMP
 	def_bool y
=20
diff --git a/init/Kconfig b/init/Kconfig
index 10f2013b53216..d42bb55cb2152 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1569,6 +1569,18 @@ config BOOT_CONFIG_EMBED_FILE
 	  This bootconfig will be used if there is no initrd or no other
 	  bootconfig in the initrd.
=20
+config COMMAND_LINE_SIZE
+	int "Maximum size of kernel command line"
+	default 4096 if S390 || LOONGARCH || MIPS || UM
+	default 2048 if X86 || ARM64 || POWERPC || SPARC64
+	default 1024 if ARM || PARISC || RISCV
+	default 256 if ALPHA || ARC || M68K || MICROBLAZE || SPARC32 || XTENSA
+	default 512
+	range 256 1048576
+	help
+	  This allows you to specify the maximum length of the kernel command
+	  line.
+
 config CMDLINE_LOG_WRAP_IDEAL_LEN
 	int "Length to try to wrap the cmdline when logged at boot"
 	default 1021
--=20
2.55.0.654.g21b8a5bc05-goog

