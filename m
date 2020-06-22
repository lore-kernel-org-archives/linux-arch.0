Return-Path: <SRS0=NZEn=AE=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731682AbgFWAkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 20:40:14 -0400
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 2/2] asm-generic: Make cacheflush.h self-contained
Date: Mon, 22 Jun 2020 16:47:40 -0700
Message-ID: <20200622234740.72825-3-natechancellor@gmail.com>
In-Reply-To: <20200622234740.72825-1-natechancellor@gmail.com>
References: <20200622234740.72825-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
Message-ID: <20200622234740.PgEMzUJliXykD7pWK81Mi-c-X3s_2X4B8DjqEhrNo_U@z>

Currently, cacheflush.h has to be included after mm.h to avoid several
-Wvisibility warnings:

$ clang -Wvisibility -fsyntax-only include/asm-generic/cacheflush.h
include/asm-generic/cacheflush.h:16:42: warning: declaration of 'struct
mm_struct' will not be visible outside of this function [-Wvisibility]
static inline void flush_cache_mm(struct mm_struct *mm)
                                         ^
...
include/asm-generic/cacheflush.h:28:45: warning: declaration of 'struct
vm_area_struct' will not be visible outside of this function
[-Wvisibility]
static inline void flush_cache_range(struct vm_area_struct *vma,
                                            ^
...

Add a few forward declarations should that there are no warnings and the
ordering of the includes does not matter.

Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/asm-generic/cacheflush.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 907fa5d16494..093b743da596 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_GENERIC_CACHEFLUSH_H
 #define _ASM_GENERIC_CACHEFLUSH_H
 
+struct address_space;
+struct mm_struct;
+struct page;
+struct vm_area_struct;
+
 /*
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
-- 
2.27.0
