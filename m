Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAF3A6F16
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560098; cv=none; b=n3s+u597wWC1z69FDFWFyUToc8m6vr8G9upYQfvUe9mylsADXy+8MsVNuwMJmoeK54WkLPW/QRlWR35y8UpXtfpomzYmt18ya2fAmU+nc3LCoR/DCLWOCTqxRYuK8RlLMfanMF1fIFy2Tt1XfJYauNd9VP3LjKs1zamGoC/3Kws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560098; c=relaxed/simple;
	bh=o/kOrCCo+fMsG/zyKbK9sMlBZ4cdbWSoTsj4GMMdO14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OHcC/rc9cpJmmN8C65GPbRwRLmh2QaQF1GyEIEXFdPPcMCAorIUAqTuSas6ghvJf8IqgUdn9gxcOE59RdfGq510poKaepg5bBHk6ydqK1O7t0t+Z7Hz85sAmhS8YN9tP0SMiwUzydrPf8xuKjyenLh8ussRu53PNYi4QNhaJBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9Az6fUD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9Az6fUD"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-483786a09b1so19057845e9.3
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560095; x=1775164895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q64ZpAFewOF3l9iLTHkbHOl134UR/SzN3vMtwvmgNnI=;
        b=g9Az6fUD/tX91QXDXr23H+svxrUB4bL4ew0s7PmzM6z/LttWAG6npjOpOSv4HQNo5J
         n8ofyLK0tfJVOi/LEX0UUEgS52VQNd83VxmK7p3Edlmf21yF4RjCw4LgDPBr/19+hJV8
         weZXye5CXCZthRv29dp5bI541X8KW19KLpaN1r7UjeE7P7oExOKn7KAPE7B6XX8QjWRo
         UXr2rDucNvAWYj8cwWxc+yM+yfZitdLPQu2WrCecahl2RXweNBq826x04YqG+oEww25+
         R3AOBoXqL4Edz+VJ7Jasy6D15NsVDrm2pCuBcr44/Vc4MFMtS937M+8/xZGC8c4kfukU
         1jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560095; x=1775164895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q64ZpAFewOF3l9iLTHkbHOl134UR/SzN3vMtwvmgNnI=;
        b=lRXA4IEzo7ysqwJ3VvbCjfX4lVqsEWhhJkpHlqWL7nUA/CB82zKh5pWeQgtR4gsJwu
         sxReZShD9/PhIYXVF22PCuzzMdEYzAn4H7ylecNIT8ei1YW3hujQ/VH0I5J+bAFe0Kt2
         vQ+KpKylpKbSd9SHNMMEBJ9lnL9B+47GIkiES6hgLktV1NB6nqSv+8yIBF74sZRg2ar7
         50tiZ4Pdxg9GMEhfFz/NJnLLinYOQ6QkVolBsDG/NGbZ9iiQdYw2e+A0s60rS6c1I4HB
         9aF6DSTMaOkVezgYXxPVIZfRtQNa2oiPpMX1wiicZvdpoZl6IjtKjWYNm7UbDper2ODh
         CYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd2dGvUTfdTX+pquT4b0peP6KnDmNzL/OcLE9j7QdQ3tM1JbTfi9DuAUf49gB9sREH2mZdtZXFl1lp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44aAjRjsOb7pkE9AhU1W3ZRQa6LeyVnsgnfpSG2ZHbgE/Glvc
	pVHRTohosrDKP5q6mihtuBbFeTyxJ7lB+M2BZ8wtiflyP+6pTDLodTz7j4CtdcTG+tdM4a9x/4F
	ZZs+gtp0BDh1nKFr99g==
X-Received: from wmi4.prod.google.com ([2002:a05:600c:204:b0:486:fb09:30b1])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a00a:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-48727ea275emr2896295e9.13.1774560094966;
 Thu, 26 Mar 2026 14:21:34 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:21:30 +0000
In-Reply-To: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-2-455cd723dddf@google.com>
Subject: [PATCH v5 2/7] module: add kflagstab section to vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, gprocida@google.com
Content-Type: text/plain; charset="utf-8"

This section will contain read-only data for values of kernel symbol
flags in the form of an 8-bit bitsets for each kernel symbol. Each bit
in the bitset represents a flag value defined by ksym_flags enumeration.

The kflagstab section introduces a 1-byte overhead for each symbol
exported in the ksymtab. Given that typical kernel builds contain
roughly a few thousand exported symbols, the resulting memory increase
is negligible.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 7 +++++++
 scripts/module.lds.S              | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1e1580febe4b..d64a475c468a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -536,6 +536,13 @@
 		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
+	/* Kernel symbol flags table */					\
+	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
+		__start___kflagstab = .;				\
+		KEEP(*(SORT(___kflagstab+*)))				\
+		__stop___kflagstab = .;					\
+	}								\
+									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
 		*(__ksymtab_strings)					\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 054ef99e8288..d7a8ba278dfc 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -23,6 +23,7 @@ SECTIONS {
 	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
 	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
+	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }

-- 
2.53.0.1018.g2bb0e51243-goog

