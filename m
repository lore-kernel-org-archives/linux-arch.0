Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C8426D31
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835510; cv=none; b=rhKxM4pVYuxp74LgI41ZxGr+cVBa5iS1xy+cC+p/uSYo2ke9mc4NsEemCgEnkg/euaFagEIcv8+1CA0htb+qF2WSKvLpfiEB8jAlBLSqeQ5/wh02hvELHgTJS3o5Pg5ner8ocJ5ZhX0F2/b+1uzVQjvfzh4xuc4Q3LbWZAS2aXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835510; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T04VaXHth4IUb/2XOqYEqLHT8vhQQhdO4YAP9Rq3ioRo6r2Rl12Pmb2hpq2X/PXuzp7cuioH+hP0CIq/Q6AyoqZg2PtPZQvsmeoPTJFhLcGykAzLyRrxYNiIc7TtFlrANzCKLQob4GqnA/fX3ySmYC3wRzjn9bxgUIX14oHZOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE22AeMa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE22AeMa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48896199cbaso76901425e9.1
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835507; x=1779440307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=SE22AeMa4y0p9G2ebtHOBT6PoM5knccgVfQTg/7dbkzFc/MuTKZUUgNeQlq51wMrec
         szh73S1rntMT275Hu1JOh/xokhqmIdr3nxE4Y00nHBI24oMB8hWS6WUk8te5u4sRj13X
         i8NV/Vt1A/D26GBHsQbJz8B/UBj+m2zGj/8PKWEtPzKplS9Ye73xMKBc/Pln5kU2DRrT
         4jGVAaGsx81YzU8IlZSfJmdZTXlsZ6UbjGI/V25Ews/lcjAAN3E7oL3pCrnK1Kv1zfEy
         k/tAzIQFvQhSUDJo6qEqFaOnmitqJTsz2NwFY0gqQpN1eZuDTN7YMLDEFxgywK8Vcror
         VSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835507; x=1779440307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=GvyQ1mK4+1Uu45PzEberw9MhWtHlahNo7W21nLBc+y09akdCBihGs5oLDTcALMsvuP
         ZqYLOXdAX5RXpXQvqXpGUNDPqgodRFAlI5ucWhxQ84ITgFgodt4bPIAsKuYaf6NJPAk2
         iA5O76I9OZ80ScSNOLKk4M4A4/KxzHhpPt6HkaEJvUOZ9Im6OriucopBgwbSkdNhb/t0
         ALHiT9AY5EVh7UildeseurKRqp2QNzWkCef57EZ/EG6J2ukOqpbqaN2syhY6iz8ZkH7m
         lCTRyXNRQrDgL3Jm4ebo3qczLhwQzYUPls1UH2QpCpyP0r2b+slMr7Kn6Z9RMWOP3hc9
         SOqQ==
X-Gm-Message-State: AOJu0YzOmatBYBW3O1RHI19dpZNmkuIWb6q7wI4wFJwHu53GD7a9o1dR
	k3Q53+guCWvmFZmYrbTZcnHF2I0kgo7yuxTvfvIn8Hc6zS3A513qSH2a
X-Gm-Gg: Acq92OEl485PGOKHb3OnwTmPzRPkxTefDqeMr56dXkLWUSRG+3xogARXGsCds8ArL1V
	bUoKfZ13wQzrQhuSfaMZCttqj1qEa60jOFLtauFBC7k3uVVwz8i+KH4L7L3vSNloF+8aAxvhXyf
	2EYDZyxDBilLoOBdM1PLGYSyR2RC14fV5XpWSLWvBMTUSeB4X3jkZga86ZsIZKCXSUdexqgEZ//
	kyUcpldhDjx5zXJJEX6uXpsY2gBGVjnVKAq13VHeL0HCA/csX2qXE0Hghy/rXUBK45s8vPHZrbg
	/MGlfU2eOiVdMwPnzTW6n4dBKGKjpS8rJUUL1d9dkxqheUueazgvBftRQG2IgPzlS4/a4pOv7DV
	SyOzqwVmu9bQEo/H0wjN6ZHpb5tiyn1rXJBCUMrXwYV8gwZYUhUMP9qKFVkHb+AylAEPa9OWOh/
	U9ruVIYdyhBq9yaT2GXxCgbphzPiRPPBOv
X-Received: by 2002:a05:600c:a406:b0:48e:82cc:4d4c with SMTP id 5b1f17b1804b1-48fe6514939mr34162615e9.23.1778835507163;
        Fri, 15 May 2026 01:58:27 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:11 -0600
Subject: [PATCH v3 2/5] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-2-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=L/oP8BWsqawvQgaTIpLI6bJW6/Dgk4EFPfl3GtndwTpLopRn4f5F/IvWmCxuGgLxeV/fs3Zhr
 YrEnU2EC6gxCMJd+euyuTbKN+TDZyBrca3AEmHlpVirwpvcxkl2/JlW
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

