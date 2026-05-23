Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E1367B82
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520545; cv=none; b=NMW/p6ZDnthxJuLrwvBEKciAxpdEeCwFp8+0UBKfINb+/7xXFFl+NeNtAj92eTDs1QKU6y+s49aBfvzLXij5mbcwn9fVe6mzHbqRBoUll6mmjEHwO6Q63+mcpCeF0ECv7bA81TkBf4QAAba6sGZOq5fislIVRPAzxy8Cr8v1X7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520545; c=relaxed/simple;
	bh=fJJj649T3B3bmwoMx3I1b8H3sX85+6tYQ9gU6si3lQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/YbrFgNr0S1r+BjYJSiAZiF06AUKsnkfpEZvin2sE0kWwym6eGp5poa9v5m8hp6GiXH0YQc+39Cs85F1RAqPCbh7pczRq5FAQaEomZoOBFvCAPnUTzXQX71nz+O9VujuTZrZjuFRjgGXc5ST++dmuN0M2F+epYtjd5ysdlWyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCJmpk2o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCJmpk2o"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so16963465e9.0
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520541; x=1780125341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDLU5WQYt4oY/SVN5IVezPdfdTCoMnWFmJoSA2Xzdlg=;
        b=NCJmpk2oVJTOOsaGZ2M26DywtgLPU7+XxtNgrjDPyYL1NQxdjlAMyOfyOf+K7ApSio
         UynJQo3NfEUU7LZONXyGU81D8kX1PlHtvh9ungsvWyESHQpN+Bcz+WSUuWIRZj8BFeBF
         OFCN5Xt9Kvexqy2ee6eQrxQEZPkNAiIB1MhDP+qjwKfi+fCvIWNf/OdtzWioA5oVCeJ9
         XxS5wjdLgH5kPiVOXFzSYQE5d9SnSMvbo7pFJUZnjih2WEGqbY5KCJhuuhkz1TFqWzdV
         qjN4JkL6k6osvQNg68jgvCJd0NSMjX7NsCY3Gh63ELDMZ9sQTmWR/j8gVZqh6M9ZGlK4
         rPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520541; x=1780125341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LDLU5WQYt4oY/SVN5IVezPdfdTCoMnWFmJoSA2Xzdlg=;
        b=qFJpnXZ/++FnfyL1TwGksL6yXzVTuYmpjl3oUdACUpFFwbeoF9nup0W+jEyhhbuVhb
         ch3NYg/0OQFpGAfWZxhspi+kArCC///PuRQAyTXpfDoNrzTOWDPHvDyjAG6R6gfMt7rr
         DnppU1ur+kEgA/+dPZpql1xCtThu+fzC9NK6nEd6bKxKEwg6GX9hT50qLC2zR2003Ss9
         8feLVKTqHJ6jUeX+Hzzsm4EMK44SAPoDzSAHxdUl0dmQ9Ef5OOMg/pId+2KJvgDmco9p
         6dmey2rvOtGDT2rWLlaI1RmblsZqiDg/sj0rb0mqMy4aJsk4OGwN6Z3PFlC8eqN/hLwL
         6O+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OKLB+hMDI1Bdcu2T777yfCJCK7iRdxM6AhGfsZwn0Y8lMbD7S+LeCx5OxYVp4OAKV9VMN4s55ZV66@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOMco5V566ha9PXnxhcz/EzKUuHUbYWe6BQfOsl6hBeYXZWC0
	zbMcZesj+vN245OTDFz05klVHte/txkER4JdRTFz0YImFxzkNV76CHXo
X-Gm-Gg: Acq92OG2gGYpJ0Z+seKhEd5Wdg6t+SfyAZKUiY5GknRAS3Tfa1fD5Jc/MvPHFxTtnyL
	KwV4/fYvfOsdzCjHzGOwdf6YwVxLkC+JEij1ZEmwEJo58zYuQLxnfT8fRhbjYYj0+vDdYGRDVwz
	uPN76UWSgC9kzYUd3L3VWdQd77JPm/wSPnOJWDQrgt0M4ExB4GN9w+VmZTUn+l/zc9nXegx1twY
	K9J5jDe6kiHbduJCdIYxBojJPe/krnFy5PYn+PmbfC0FbHDrjDZ0PCFhqJ/DI5hkVu26mHqFL0K
	+nKThmFQYijiALtUUWFs3JWmS5r7tk2ZsfSE9aXC8RwnlqKLQNq2cs1H52rBmX8N0qA7GLX+EXk
	pdaiWvE4zxf2UUSgs+aS1/3h6CZZIocQOnziMo3QRutbCrqZuk1GWYrlGd0YqXSSEC+yBofM0Or
	a/Asv4FHJbXUvK8FNsUeU+HqaMwNA7ZZuDwfTQVrc=
X-Received: by 2002:a05:600c:4506:b0:490:3838:1548 with SMTP id 5b1f17b1804b1-49038381676mr146718845e9.13.1779520540573;
        Sat, 23 May 2026 00:15:40 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:56 -0600
Subject: [PATCH v2 23/24] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-23-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=3131;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=fJJj649T3B3bmwoMx3I1b8H3sX85+6tYQ9gU6si3lQg=;
 b=V+8IE8KkGtFIdYyLDVrlrxn/sAoLHZdpVxJ31MGCeHA9ThYCUNqh2uYEtT6ZbgcGiaE/3Lu6i
 OMECpf5DJmoCzNLsou0p27ZdFaR4zl/W0edvspiJbNugzW2jMTcUHFw
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper, and is not an expression.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2:

fix statement-expressions to return 0 (not void) like their respective fallbacks

   1. Add 0; to __dynamic_func_call_cls
   2. Add 0; to __dynamic_func_call_cls_no_desc
   3. Convert the disabled fallback of dynamic_hex_dump from do { ... } while(0) to ({ ... 0; })

move RvB after SoB
---
 include/linux/dynamic_debug.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 11ec40f488f3..fe73aa27b350 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -224,24 +224,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
 		func(&id, ##__VA_ARGS__);			\
 		__dynamic_dump_stack(id);			\
 	}							\
-} while (0)
+	0; /* match no_printk return value */			\
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {					\
 		func(__VA_ARGS__);					\
 		__dynamic_dump_stack(id);				\
 	}								\
-} while (0)
+	0; /* match no_printk return value */				\
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
@@ -321,10 +323,12 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	dev_no_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__)
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
 			 groupsize, buf, len, ascii)			\
-	do { if (0)							\
+({									\
+	if (0)								\
 		print_hex_dump(KERN_DEBUG, prefix_str, prefix_type,	\
-				rowsize, groupsize, buf, len, ascii);	\
-	} while (0)
+			       rowsize, groupsize, buf, len, ascii);	\
+	0;								\
+})
 
 #endif /* CONFIG_DYNAMIC_DEBUG || (CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE) */
 

-- 
2.54.0

