Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0ED7404E
	for <linux-arch@vger.kernel.org>; Mon, 23 Mar 2026 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245971; cv=none; b=dw5nRJEbPFnxyOeUeS2YDNLWitqqsvj3+yJDBNzLdCnDi4AW/vNAkG6zGnkMUe6zqtMKqn0g4TISHYKqUx6z7Qe1HQI417+0SqZH4add4AEVDd2m5KbFO7gPxV+Ebol0X6rlWbx66a6Sd5endirur7grFaIzXEPwJdfmAxbrokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245971; c=relaxed/simple;
	bh=kxf6SYK54/E/zqSeHL2SrBf9duCr2LsNVz/FgDz2zjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6Q83z0IPav3Hro1gcghNSDD/CRTHXKTAaZ3+n4sLdov1u/AMl6hIJCzPINMgFihfllp0xubHUusPPq6rvkNrCma/7O5CAz4LyvekI4sCUofgs3QCwp40AcKh/CLI/PXrVq1lrMMTHfqfGSRw+h3tWySqSyVyAuybA8eyID+Ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5yk7ZBI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5yk7ZBI"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so2360277a91.0
        for <linux-arch@vger.kernel.org>; Sun, 22 Mar 2026 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774245968; x=1774850768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iv3TfBIs57bOOCtJaO/f5ujAkQ8L7rO8zE6RhTk04Fc=;
        b=A5yk7ZBIHF24gPqEuRBUjvOqYX9ocgQcr9SnLXScpXNSG3fnpgmX7Y8jHDYQYqfK0u
         2jjvolCcvwmMTAWRUNn5Q/JhFQ53brkg48isLS4Mi61O+q2namKj9YfYnsnhsz8prfbc
         /yMGLpZrvokXXtPDIWg6+SEdk4HlUSx5pFwXr6/qL7OIF0YZWKpDHdfR9nkiqzU7MxIC
         tlrs71pI1aOPc+AFRNhr31Q2Nle8F9yljNSFpmXYfIcyUPszV+vBPB5T2HVb4r1pmRBj
         W6MJsCJ8LI1mOw4SPMz+Mdv1OFJqsQ+Tnv20XlT3RPQGrfjQb5wmCMD9vgxTW4Yu5G1i
         OPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774245968; x=1774850768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iv3TfBIs57bOOCtJaO/f5ujAkQ8L7rO8zE6RhTk04Fc=;
        b=J8wvNV5UvThZmvYHqvegYeEmSY5FiO0SmvomBIbUe/l8cC3J1Cen9JIRugPxgSUpxM
         /03i5j0/dgdVzPjVFeSaEcbTjnXyuxk5g3Qx/0nHKzYQU+rKUYglcGWPUCJc1zefu149
         bYPinKEk6zpiZAMjLkwCRkwfx3L/aMr0SEdpZYkUhjXdyKNRLCcz1uUTD3YCTl9+Kw7+
         WJ9BXFjdfoZO77F1b6+3cfcsIULNheTg7iuF+xQ3f1yb70bSj45Si7W4Hpp9czbgvYq/
         5pGd3EhWpOoHT5rsDl7mWsZ0jzbpi0BuriW84EnfojfFLAy03yO0bGz69DFdNTATrzvO
         JBxQ==
X-Gm-Message-State: AOJu0Yz9U+1bfsSPIYUSK/331KKNYNdcFOjxaMeE0DdeAEdMxztHs38R
	kopCOyX7NzI155uIRCtaeyfPXDfGA/Xths1OmdkEqUVTjvnCKdBeyOGmDWiiYA==
X-Gm-Gg: ATEYQzyZIUoiUKOeyPLEfGgjzFZRJmtksBNWZnU6KzphsA/iK7/cPscXCIUvWB8FX1H
	7MB6LquPVgXV5obqpdoH8DduEN+6w7e/+AXAUA0IFcoEJBNWprOGI8+jltrzwawkkIbMZQi76cF
	GS5DjFggQG0h+EUD3oBnn9CjVkOMgBu8asYl/YBNBJI0QDDYQeafFXDWpzmksYbmO1BNNRwNtc7
	0d6cI0nogDKOxf1MzGW1ZJtV1igytdweMaH9Qb5r9kfgy8wdeu8bYDuF5XKCA8DCFwHjsNlQ1Cg
	NgeTIxW7Cv+uemjwdWugg5qpbQ5mtKOLmifyXp2sFnJzL37/Y6heU+tX/gw33r+RYszM6EkuUD6
	yK+qbKU58dSyBudnKeVZs/QaTEYnTvzptelZbDuswZuEh8aEemus91sKa7U9anxCGZk/HuP+3oT
	EHIwNj6OS3ekXzUTrhKz9F/pAo96ZQS0ZZqt7Ow+yhLem1+dvMwvgthlIX8zIdkhm5
X-Received: by 2002:a17:90b:5603:b0:359:2d1c:9206 with SMTP id 98e67ed59e1d1-35bd2d35149mr8760605a91.33.1774245968319;
        Sun, 22 Mar 2026 23:06:08 -0700 (PDT)
Received: from rpi4-ubuntu.. (123-194-188-82.dynamic.kbronet.com.tw. [123.194.188.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836556f6sm125916615ad.49.2026.03.22.23.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 23:06:07 -0700 (PDT)
From: Min-Hsun Chang <chmh0624@gmail.com>
To: arnd@arndb.de,
	david.laight.linux@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Min-Hsun Chang <chmh0624@gmail.com>
Subject: [PATCH v2] asm-generic: convert __set_fixmap_offset() to static inline
Date: Mon, 23 Mar 2026 14:02:15 +0800
Message-ID: <20260323060228.21064-1-chmh0624@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322144032.7353997c@pumpkin>
References: <20260322144032.7353997c@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current macro implementation of __set_fixmap_offset() uses a
hardcoded identifier `________addr` within a statement expression.
This can lead to variable shadowing and potential naming conflicts.

Furthermore, the macro expands its `idx` and `phys` arguments twice.
This double evaluation is dangerous if arguments with side effects
(e.g., i++) are passed to the macro.

Convert the macro to a static inline function as suggested by David.
This improves type safety, avoids shadowing, and ensures each
argument is evaluated exactly once.

Signed-off-by: Min-Hsun Chang <chmh0624@gmail.com>
---
Changes in v2:
  - Convert the macro to a static inline function instead of just 
    renaming the local variable (suggested by David Laight).
  - This addresses both variable shadowing and double evaluation 
    issues pointed out during v1 review.
  - Link to v1: https://lore.kernel.org/all/20260307092119.20733-1-chmh0624@gmail.com/
---
 include/asm-generic/fixmap.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 29cab7947980..541b8db35af2 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -71,13 +71,13 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #endif
 
 /* Return a pointer with offset calculated */
-#define __set_fixmap_offset(idx, phys, flags)				\
-({									\
-	unsigned long ________addr;					\
-	__set_fixmap(idx, phys, flags);					\
-	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
-	________addr;							\
-})
+static inline unsigned long __set_fixmap_offset(unsigned int idx,
+						phys_addr_t phys,
+						pgprot_t flags)
+{
+	__set_fixmap(idx, phys, flags);
+	return fix_to_virt(idx) + (phys & (PAGE_SIZE - 1));
+}
 
 #define set_fixmap_offset(idx, phys) \
 	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
-- 
2.43.0

