Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44053E123C
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844684; cv=none; b=mT/5CdGQBul2ahKPLAUA6UsG8j4R/N6JhB2e5NartvRN6m0hRNSITx/It+OZo7x1rPJEPqOiHPuh3Bup5/lXzF2WKingLb7tSx3W4zl9u6/5/hCuMmLQTA2IEp6RnzuPlabspU8nVY+VfYaumsnHbGzpXYbGwqn/kEfSg1p468M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844684; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcxqpVDItry9zjDINh7NqO3Gt+VozInc7+idR6mBBWkEiwiDmQ7g7q4FSDwu2Qihw2vw+MnAEz6U+33A92Qg26i/KLUUuGyTXMu3py9xvcQvTAgpRhQ8jv5RdcQk6vQ2KN0clPvD1Bslo2WlHVbGM0juPY/i2NaRF0zvVue059c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr27A0PZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr27A0PZ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9bb837fdbso1774116a34.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844682; x=1783449482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=Qr27A0PZjJrjFHVAtsE2YFnX0ROBYjTv1BGIfp1mfO5IBBD7hV6uQ9Meo7NQXRm4ra
         zGRa+cUhJ5wcg1jCnFz+GmWut8o0CWrNZWXBngNlsHh9PzES6sO0YWTbLGAzOErFyZ94
         ZbJndbFNVcfOhiZ2/bMpaaQR0ZJ36BdUYIkIWOYhzX7oIb8k2TEpxDZyW9xySd8h2g+A
         sQNWvOJFoeF/ijGf2Aa3W5j4kt2jsHkWBW5lXCVsc8Q/pMD6w4F1ReeD8daOGOQDPo0a
         6Fe2xyvxDe8bNuz8Hto65UWo+oNSlGsVAZgl2403Yen1vC33DnXu+a+6tYkWKwD7zJ/s
         wfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844682; x=1783449482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=AhPcP33Yh5XLHBH+qbZId3VVgggmQ1PtzNT10eKeywQsQugRth5c55uMyrcygnKaEZ
         tqbUNS0nSxWs6rHOn0khxVprygZ9okdQhPWhBoexLBveyo1APxfO9tvYURIaTBnJctlg
         tJt8yIO3WW8aG2wa20TuNEVGg+xVt8JA99lxz2FqdbQwOfx1W6gbGNdK8MiLJN5Gbi27
         gW7raqFsv/Cd8Y9MG6cGV6Nbg9GtzlMA5CeKFhXC2IES729XAKfhMrklolRbElm54XTq
         MQhfLMZFT9VdvIlYoPlcdGUCePXHotLi8SBuymzgbdQtBdcMNOQJvG4PJ0uZpB5+E9vm
         MQXg==
X-Forwarded-Encrypted: i=1; AFNElJ+XqjN8xpsy++RpxU6aj6mj38eBgmBI/WpqJsZOdmsxuEwbVhIHClIStpnkHCIWqVenbjTx1/r482Jj@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7oKOj+YPxTbzLV2X3/6FASgtgXTcPxUUuExD1VP5QzlW9MEo
	a457io3fJNqDhNC+Y92phKuNFFiwGHVqp9uo4HW+S6E+bptrCvE4Ns0v
X-Gm-Gg: AfdE7clA/lXXZ4tcaDFLxKIWIllBsmKJMV47n5byB8rQDbq7XfYZe93BOeKvFNOUL/V
	LHmRv31Bs97qI8zSqcYykWZO1Dd2KgOMGENe099+MKitkGDXHhL+/noXhB4MrlcfUb2YHfKSJpT
	KS0KdlggYodIGL5WxWZ7a3CYo1eYlX9ZH0qKSh7rW86nn+X9zZyG3muHcg+/lbc4ph6fta+T+P0
	8vv0E3y2LEtbcIvV7Bci43qGlw0mlVbY9j++SJg27TGzDP+4kLhtCUz1d12zC5y44eX3sET+WeK
	epI8JDNJum9EflnmruoZLzqJJ3iXZ5kgW42rKuNHeTV/nSxuuYVF3qylcY9kaUlQW3iWnW/FNhK
	LeuTKJu3zh+V9I+H8p1rBbhKvQhW7qb4rMLgowszLeIbN9dhuU+A679dXBcD7N7LKUu2w8IQXj9
	esv2vBCNLHFGu/iCHkld4Z6RS+2WKbvfcZSm3cEjy3uQw1/m/TxBs=
X-Received: by 2002:a9d:3e1a:0:b0:7e6:cfd0:42de with SMTP id 46e09a7af769-7e9fc1039a2mr774699a34.15.1782844682023;
        Tue, 30 Jun 2026 11:38:02 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e9ebfd6ccfsm2940025a34.11.2026.06.30.11.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:38:01 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 30 Jun 2026 12:37:51 -0600
Subject: [PATCH v4 2/5] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-align-v4-2-42e6ec883342@gmail.com>
References: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
In-Reply-To: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782844678; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=n78tfe2fi9EK+HEDAl5OzPtc988yorQ3k6pmoyx/5hHX77uOUhugRjxjJh03ZcalzC+E1dRVV
 Mfrg78n0RPrBw8Ko8k3Qbml7dAuPGjBF8Hy1S5x/Q5TQoiFEX16bGoA
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

