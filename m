Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F53D1CA8
	for <linux-arch@vger.kernel.org>; Fri,  8 May 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256776; cv=none; b=IA2OHi/0/ZFpp9duU5AGcP925dc289HS5bOUvu8FFwG6LxrTLaHivZsRcSaIF53MsPmZgfVmWOk3aNFhKCrXeKRE2qdOnKGL2WS6lewGUPSPVTtCD2O8JJ+zvdy6ssJs+5hs5pnbmvPef9jmTVo7lzgH3BZbrCGCNPh4JzeqDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256776; c=relaxed/simple;
	bh=UDRiTFNTGMxGNkj85pCGPItAs9ImXHnWYb2myZlsZfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sMeBW+YoaGNJn4n+z08FuS077O+cnAll6M1tT1lN4rUgWF5/hjGMr7TBJjXN5kRGANVhOyR34vFuxIazJIYQwSC9Io/Zz0OMZsHZd5KWoR9jOmC+chFr+K9ldjWB8LTlILcDteoB6hM0yuDuae/9OARwn2M5yiyRh5PZyT9RlxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gf79JQx8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gf79JQx8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so116955e9.1
        for <linux-arch@vger.kernel.org>; Fri, 08 May 2026 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778256773; x=1778861573; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DV4wqH3QxYXnjFXdGhWXuxESZRvhEx+akEv7Iop0Gs4=;
        b=Gf79JQx8FQlrjjr/Seg21mi2IV6exSEIH/lbG6080SSngtWK0d9GVJ4mpI1Hgp5x3m
         MhWi3aHbjrjeDZFyM2llg7muaLs2xPUeyBFGu3BEgzzGZ9IPf6t2EQP/0QDKT++jE96i
         Y6IL4Fk2AQfD5IhK+fWgOYUt0jeP0tCp7KWtHr+s3x9BOez+rEA3dLfcg6+wmYiDeYQB
         jsLu55VigpBYzB81IOJzIrA8F1OIh5Dyf+aJwdxsO0ZKJt741YVd/CrkBnu9teqJ0Tsz
         MGVR7hgxlDv+oBat/41B9Rl7WgIiag3avPEJttab3++vvz80tXThAS3OnTLg0gQun1Rx
         nw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778256773; x=1778861573;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV4wqH3QxYXnjFXdGhWXuxESZRvhEx+akEv7Iop0Gs4=;
        b=JhK2AXI8EwS4/Jx0vm82nQwmTDlF6tFnx0dXnUejmFiqzVB9Czmb6pa32dxzFm6WpR
         IdT97fgT8QTNlHIGRfGHQknGcvl5oVDzuhUOu4ONgG6pJf0PirzQ0T1jM5Iqywk+nt4u
         bwI7uqlMmOqPgjDM6/SRNu7W6dBijeF2+RvJhBrsOdfk5WMNUcJQBE+hcdQq/v2zTwVT
         pG3Bj0WiM5Cqm8iEPZXeJDOWxw6nB8fojX0lUmHd6smPnZehtAADIqiFhq2KH9EkJuks
         aFPzLG6E1r+TlkXqDVmRpQrxJBKnc+8U6NX9yiV7Mrj7zyyz2BOFeHhQmr93sLcustrR
         81qg==
X-Forwarded-Encrypted: i=1; AFNElJ9scP6CLfJpHANJmtFPJlw3U9McvORTWYqfP9nSLboQGYdNkQUGnTIqlKgQ4MnAzOBPLbCsXpiEBk0y@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbBHcUSXYtCVRR+rd1DL3e3ORDAPUU3nswqXCeXxQPOsn4e4e
	sqTwdBrcpjzfU5uDRg/+/lXrdk+miDcM7ChrP8JuBcNlbK5aSKqq52smej1qc83Smw==
X-Gm-Gg: AeBDieuPX5sbe8WsudFuo1WAVu0i4miZRbZolw2SLW41mCd8GOvyojd3eSr2VixZB39
	nykUy0PBp+zJm7TtJ1SmSeh1iWsUQth9z8fdT3NS+TD9Rc3BKwGMA6xLDTAWzvyWJfYB9M5UJza
	biiL2yguNyBJn4Urzgdgrk8lP8BXK6cVsSgW7NK66WuJlcZtoklAyE6lvddY0Bx5tYhA5n16Ki9
	deSuwDqInLjvy0kRrUbT6usUTgtuJX4Ci4GprUEMczf4UB0bdHt/u2pgoTzFAi/daW6pe3FGDuK
	eB6gC2MDKsDphWapATkeghPN6ANejnkPrm7MSZBHvBqHOk6Lh4sYebt65JLHiPYQG1fdNNdRfve
	omb8d2NNNbg76NmVbo5kywUy4E4xm6mg49fEsydexzR7E8FYHENGGGnTC2IOnkOEsd9B9IsQDOz
	j/gXNJMFxM0Kj7GblglVSZvZ6pL+Kih0xdC3mil9QXWMHOFfH5N4r7/26H3ffa1g==
X-Received: by 2002:a05:600c:a10e:b0:48e:68e5:589e with SMTP id 5b1f17b1804b1-48e68e55966mr597585e9.12.1778256772825;
        Fri, 08 May 2026 09:12:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:9f14:b8a4:32a8:9c95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd3fd0csm4395875e9.14.2026.05.08.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:12:50 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 08 May 2026 18:12:42 +0200
Subject: [PATCH] mm: make zeropage read-only
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-ro-zeropage-v1-1-9808abc20b49@google.com>
X-B4-Tracking: v=1; b=H4sIAHkL/mkC/x2MQQqAIBAAvxJ7TjBJsb4SHazW2ovKChGJf086D
 sNMgYxMmGHuCjDelCmGBkPfwX65cKKgozEoqYzU0gqO4kWOyTVljd/sqCajHUIrEqOn578ta60
 fe/V0R10AAAA=
X-Change-ID: 20260508-ro-zeropage-86fb842965ae
To: Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778256766; l=3448;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=UDRiTFNTGMxGNkj85pCGPItAs9ImXHnWYb2myZlsZfE=;
 b=6KqEx7t+ZT40aQbtMzUIvTH4xK3X3hxmWX3hc5lSdW7XA53LJ93tRfQmpK7GlNRW+7SUX/bw9
 QzYV5++j9b0AY7W8PMPxo890xz3CkG2XIGkdQXdTDJo5LjzVhI9nffW
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Put the zeropage in the read-only data section - nothing should ever change
its contents. Set up a new section .rodata..page_aligned to mirror the
existing .data..page_aligned and .bss..page_aligned sections.

There have been several security bugs where the kernel grabs references to
pages from some userspace-specified source, via GUP or splice, with
read-only semantics; and then later on, the kernel loses track of the
pages' read-only semantics and writes into them.

I have seen such bugs in out-of-tree GPU drivers before, and recently
upstream Linux bugs of this shape have been discovered as well.

One problem with these bugs is that fuzzers and such will have a hard time
noticing them, because the kernel has no mechanism to directly detect that
such a bug has occurred. It would be nice if we had debug infrastructure to
keep track of whether file pages are supposed to be writable, or such; but
for now, the easiest way to make these bugs detectable in at least some
cases is to make sure that writing the 4K zeropage is mapped as read-only
in the kernel, so that attempting to write into it immediately crashes
(unless the write happens through a vmap mapping or such).

This patch might increase the size of vmlinux by 4K since .rodata is stored
in the ELF file while .bss is not; but the compressed kernel image size
shouldn't change much, since it's compressed.

I have tested that with this patch applied, calling
`get_user_pages_fast(address, 1, 0, &page)` on a freshly-created anonymous
VMA and writing into the page with
`*(volatile char *)page_address(page) = 0` will cause an oops.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 include/linux/linkage.h           | 1 +
 mm/mm_init.c                      | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 60c8c22fd3e4..e6e96bce506f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -479,6 +479,7 @@
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
+		*(.rodata..page_aligned)				\
 		*(.rodata) *(.rodata.*) *(.data.rel.ro*)		\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index b11660b706c5..49997b292c01 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -38,6 +38,7 @@
 
 #define __page_aligned_data	__section(".data..page_aligned") __aligned(PAGE_SIZE)
 #define __page_aligned_bss	__section(".bss..page_aligned") __aligned(PAGE_SIZE)
+#define __page_aligned_rodata	__section(".rodata..page_aligned") __aligned(PAGE_SIZE)
 
 /*
  * For assembly routines.
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..67b260acc27e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
 EXPORT_SYMBOL(zero_page_pfn);
 
 #ifndef __HAVE_COLOR_ZERO_PAGE
-uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
+uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_rodata;
 EXPORT_SYMBOL(empty_zero_page);
 
 struct page *__zero_page __ro_after_init;

---
base-commit: 917719c412c48687d4a176965d1fa35320ec457c
change-id: 20260508-ro-zeropage-86fb842965ae

--  
Jann Horn <jannh@google.com>

