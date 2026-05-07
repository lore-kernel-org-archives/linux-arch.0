Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061931B833
	for <linux-arch@vger.kernel.org>; Thu,  7 May 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186416; cv=none; b=TW1WsQX6DCyLfguxEcUDS2DVmhNweYIfjnJCR9aTNCHHhTYP+sjCPHUMDSKZyOjGzMI6v/9Hr0JB/8IIvlnS0YR2BkpkoIpe6U3U5T+ePvXhwXbjzkdCBT1ijT+kNqBQ9Qe2NKQhJ+nGBMG+f6VkIBImM/tgSNuKsgYvxAiGolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186416; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2No95Mq/auBSSuAPpV47QFBj2Tjj6mWYQAaW3dYs9k4iW9BFkATqYQpJxPMaViIzrqYuG8qLQD8ju9U1QjLOorsqRQ/whSd3c7ObXeJP6P4DBOYQxXe6ZNZRwVbbfv/7quLnmh3MLYOlZMVSo2b1qbbdNxOTXOcSBtz5320lAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOGsugJX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOGsugJX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d102471a4so13155625e9.2
        for <linux-arch@vger.kernel.org>; Thu, 07 May 2026 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186413; x=1778791213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=JOGsugJXq6e6VTIZSiJdd+6t8ApBhzYwZQTJ4yl/e7zpQFrG6Pv+gocC9jXnMBBzx0
         7TZKHTlJIDu1MyLxlEDbtlQUQB6ldusLPgjpkxvAeKRdKUWQG1fDPek3H8fw8x93qbRk
         TyFmcHkWrGbO0YPglgGMT3FQWhfJ4aPWJ+QWc1ur5Af7KoX9A/dn/8kg/bJJNuF2b3Nw
         PCD7lI1X2gEF7eEYcI0KrVAjAjeHh3WfgWCVmaoFhSqH5xVhN55oeNEdiPda8jI/F4gw
         3xE6ot7Sy4k4cnbYJ/7IS7cqcP1pr0cAp1/cf+6c6dWyHvJcVw6FyWbXINdzT9J+aMUx
         mbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186413; x=1778791213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=SuAXjf6tcX0esjPjxyKh4x8nC8LCtdH/YwgvVCIGIeAjBhUtx2kRxCYZ7fydHkWDIx
         IJN5RH9NsYU95NEr1YkFfw3Pd7Pnd5ySN6JEg5j3eB1ArffgxgKGZW3EFpdOyo0O7ICM
         p20kMYAoXge8q5iuTjxBvfP7EUIxCWuaTEGjK7E31cNw0qSRA0JsKpQb5muJxzPWYOz8
         XHD0O4wVCLpxH8oAXFlM3fb9ciHqTTVqdgxaRuJrB6yecjZho8n0rB3r+feWXvnPyR22
         +fwUkjnV3AT50JC12kMwjiADd8Ps7iorV8gfw0mnrFUEMQps06eeVRlyptiNBvPJ0K7y
         V6yg==
X-Gm-Message-State: AOJu0YwTqwDBoayPPEIVHjudNVbYH3FvioLZVI5YCMCzylf/EvKZtljg
	WZpuFLRO/xTiL6MdQ74SDI8z1LuLCuFPEW8PJ0kRVY774BC9olpzrDDp
X-Gm-Gg: AeBDies6ZBy3wh3WWpvcSnhmDcCs722VRLWX1gKqlaioQQzteu3u04TsSeyNdoz9Dci
	meDAvjC99+yFoagYX5cjZ3Z9JAIoOQA6327i35oBAQHfwxxthaidAY8cVFltSc/PvPQeGMhknL6
	noGtzdPQcRn9ko4qwX92hpc5WfLiosdYIjB5hDwuna8MrABzNUgfFRSMc8t6HxOrhwNgycGDPIn
	Reyij8RJ2hQ2kCONyjcdAhYAfo9aeV9WU9GLAI5XWSF9Yrxc0Kjt/CVurZS0YFFauVG2yWVb7tF
	xNnAoY+bSPf7JoUwNSDTuy/Qga2/7V1bA+P6yBUZOdbt3dq+7XDO64UshBTbEhK4grihxCQcLDc
	enj/STkNXrS3vE7v3C08LSHNG5TG0KsEsmTt9fprDumyQq8BpE/wmDRYX9X9mPCm9FwNadOEycF
	VvrfcvA8YfrrabQOdIXPxFEy8cfkKy
X-Received: by 2002:a05:600c:4b1a:b0:48e:62ec:f264 with SMTP id 5b1f17b1804b1-48e62ecf39emr25218845e9.17.1778186412677;
        Thu, 07 May 2026 13:40:12 -0700 (PDT)
Received: from [100.82.231.29] ([185.57.101.106])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm264367515e9.0.2026.05.07.13.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:40:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 07 May 2026 14:40:06 -0600
Subject: [PATCH v2 2/5] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-asm-generic-1-v2-2-47c52759d268@gmail.com>
References: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
In-Reply-To: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778186409; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=t6utUyvNZn1ZWeXFsFAIGqgojpwWZL9SrREnwncMu0uXb4iRfgx3VSU3T5QwWwhNITGOyPGe3
 wvb5yUyUMKYDkqRmNde/XUBB6sSRS0nkvSY0QPGoz86guiANeEAopxR
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

