Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39112 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfJJXYA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 19:24:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so3540954plp.6
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 16:23:59 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 4/4] include: Remove FIELD_SIZEOF() and sizeof_field() macros
Date: Thu, 10 Oct 2019 16:23:45 -0700
Message-ID: <20191010232345.26594-5-keescook@chromium.org>
In-Reply-To: <20191010232345.26594-1-keescook@chromium.org>
References: <20191010232345.26594-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20191010232345.OkvTji5J7iZ9Zcf8D_UJ9Jy5c4x5qt39LyKb2ZV4lw0@z>

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

The common function used to find struct member size is sizeof_member().
Remove the now unused FIELD_SIZEOF() and sizeof_field() macros.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Link: https://lore.kernel.org/r/20190924105839.110713-5-pankaj.laxminarayan.bharadiya@intel.com
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/kernel.h | 9 ---------
 include/linux/stddef.h | 8 --------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d83d403dac2e..d67020250d75 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -79,15 +79,6 @@
  */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 
-/**
- * FIELD_SIZEOF - get the size of a struct's field
- * @t: the target struct
- * @f: the target struct's field
- * Return: the size of @f in the struct definition without having a
- * declared instance of @t.
- */
-#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
-
 #define typeof_member(T, m)	typeof(((T*)0)->m)
 
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index ecadb736c853..74b5e644d50a 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -19,14 +19,6 @@ enum {
 #define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
 #endif
 
-/**
- * sizeof_field(TYPE, MEMBER)
- *
- * @TYPE: The structure containing the field of interest
- * @MEMBER: The field to return the size of
- */
-#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
-
 /**
  * sizeof_member(TYPE, MEMBER) - get the size of a struct's member
  *
-- 
2.17.1
