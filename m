Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155144D01D
	for <linux-arch@vger.kernel.org>; Fri,  4 Sep 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518946; cv=none; b=JtKLOehRSzJkupnA/dkTdzB3UBuzz0GK+A0AkWzRfw1pN9Y/UKr6wENk3FdtXwlG5JbuQUp6NoyNQ9Mx8I+1dUIGHeCk9tFxusFwqRf+ULB0LA4LfwVnJuv8j97F9q+s/myJ65f2UPmGVXrmXxZ2AogQlTn/tt3pwuI+qPv13HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518946; c=relaxed/simple;
	bh=qVcynegpZm1yGmLZX8tUiOczHSGQ8PzLgexY1A3PAtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toGcnNk/eS016TZEnM0cI3xoFMH+23v1sVrRZKkxCsq3sD7ln638oyujicjVNfWF7/XwSeeuWRiKUGxWXokr2UEhXl8+P0+4PgjRYL2BkjfVY1gFuYWNuGSYWfZJuJ4MPOvWJpFhZm1LABObMdG6nqz79KRzs/T4cHrlCaQBaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuW4tsGp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuW4tsGp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d7200b2e15so9421885ad.3
        for <linux-arch@vger.kernel.org>; Fri, 04 Sep 2026 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518944; x=1789123744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlLVTDTkKLUK1RrWb8jn049QsgDUDcnIGDsaM7mMOOY=;
        b=cuW4tsGpKXvePWLymjwDaiaxCBVjs+P4Cy4ul+5DcnhgBk1UzTospDY74Rz38fSLZN
         GLQh128rehR+/MZ0kkN83btNk+B+UYoNIUN4O3EoUYGOck2nIfXmP0fDDPFsl7KGWn2g
         Bcue/YWsV3tJ7ZiEZzWDzXd+vR6HqnBXjchV88YpbPcIh6w7sbogEB6vp+Za5TV6tbZw
         ItNvI0Szwgdb+a/kUpIIYs2H0MzQ2VNg15ycdROh3UGkWoyMn64bqUa8nuCgUFBVLhUu
         F0jGnKRmlRnfP/6975+YL5hb2nwQT0imefKsEgg0jMVZToCqZvb32AHZ61Fpug2JXYnA
         1dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518944; x=1789123744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlLVTDTkKLUK1RrWb8jn049QsgDUDcnIGDsaM7mMOOY=;
        b=RIHlrduSK8vfmfqp7JCFMRyJLmBIW55OevtItKAZYsBYV22/Aem2Lvap4tWQJzi5nW
         olnbC/qMaD+atQBAKvqFBu0I9oZ/bQgyufUQiZmCV15QuwxWo3jTe0guHGGE+Mq+QgUx
         r9lkl4CptUPDU2efk8iXFr5ZT8OUbbmheIiL+LKnzzhpD9Yn2fzvhS7d2txvo5UTq8fX
         u9d8dQ61JRMU0JnHpt2bZ2PGSzy3y9H6a99rXgqoJocRvrEqfmmo45f5UGUv6X9z5fqX
         DZZKYMOhqgd9h0E1tZAnhhrNJl9z5ohvCtBNFpqNR4c8L/bweLmBgdMDYhn8nssLUREO
         bnOg==
X-Forwarded-Encrypted: i=1; AKwUvBwpcaZ8s/+2npP+cjbjPdt/Fi5+L+CcGLWbimKZtdRa3hB/TtqnycMR3FAM2/anpyJb7h76gEeY1Amo@vger.kernel.org
X-Gm-Message-State: AFuF++lzBweX0JIb7zwvIfMhpTfv7W+iEXWzm3iQzzkSxWnE+GbCSRys
	bhUHg31eCGp+rReIows9O3c7ZGARsXAkDPJV/J1vOn8WZHUqKmxZ4G0C
X-Gm-Gg: AYBFou29v7vVbUFRjO1cS2n4esMDZPosePdZH+/WRK5rJVb+EiicnYwsdaXGcE31qxF
	/TNSrFLvyPSkM+1lYy465zk7QLIehCabKAm6oIY/0dLE5QQYY1s77lQgYaGL/xjOKJXO065zvQm
	ODluN2bQVYv2vL3ywhuXZEE50FS8oX9hgXOD+mZu81ZBV7/v6XP3Qof/WNvHwmB/XakhuzgUfHp
	4xGeSUSFxVxKEKUQJgzgvQLDYvEDGpip3X1ciFTq2PFOwrdtwYFkCrGglUfuqa3+1uyhbbl/EW3
	Lqic1rGUYaTPoH1lioYEtVl7b/vBGXKLKNW9na7eohX9/y/U+kM7jzwXAy2/5o6lA8RiB08oub8
	sqU6HfgofpDXcmEJ9TDVjFQx+E4W6In32sUQxwP/oJpAodR/UC5OKqnNhPS0x56OJGIKZWn+CR1
	YJZ6EtrumaWyTTkzjeo8SXKs/JHY5GN3dfJLQ5a7s3xizs9GQNY+FwWJSV5CRpEtTZbSxr6ej03
	VSrR5W206QFOBCqjIXg2KPVEQ==
X-Received: by 2002:a17:90b:586c:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39b2623ef65mr8977929a91.24.1788518944271;
        Fri, 04 Sep 2026 03:49:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm8583927eec.16.2026.09.04.03.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:49:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/5] asm-generic: fix typo "explicity" in comment
Date: Fri,  4 Sep 2026 16:18:46 +0530
Message-ID: <20260904104854.25272-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904104854.25272-1-hemanth.selam@gmail.com>
References: <20260904104854.25272-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "explicity" to "Explicitly", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/uapi/asm-generic/mman-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index ef1c27fa3c57..cf1418649b3a 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -62,7 +62,7 @@
 #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
 #define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
 
-#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
+#define MADV_DONTDUMP   16		/* Explicitly exclude from the core dump,
 					   overrides the coredump filter bits */
 #define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
 
-- 
2.48.1

