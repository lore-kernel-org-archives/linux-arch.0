Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A63AEF34
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477121; cv=none; b=GTFk3yWEOiyrzLXQBq+xVQakXPI0ZTOuitJHDyS8vNwoYsCoe23PhM7UIdgKL9577oPztTTQav7LtYOnA9j7v7xf/RFeRHWBlB4qleCEQTjVm/JIRtcVTyHCKokTxianE9dgNu4+wM8rm7ZqV7/TPrRWdzgyHEzdapxxYhDyh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477121; c=relaxed/simple;
	bh=ZuzqA3zGt/j9kYmFGfFlaL94NbjSKGlzcBcWBUqAWbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0Gr9jkuGMdclAUR6AmmZ6f9IFbe1T8YP+IwSkzBwTmVTbCYmczMfKhJ9c2hISGaHIosAf23pA6Y9Rs2pOKRsSnJP63Oig4n2iNsBAhDoonPdduS249892YhXc7cwv1MDdrxh4jRy6mDCSPHpDFoJg5d5ZTUDGmU4JptWgfWg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6KW+t23; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6KW+t23"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-49ff971e903so792952b6e.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477117; x=1784081917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
        b=K6KW+t23RRnF0eUDmExN1coP77KTqWHLZxvsn0s7bguE75vlYDrQS6KxCliW+SYmRd
         TxJMhyTwbBEv25jSMAkmDIZ2dHbHbphaOpVtoK6bT0/+gF4eb74y7uF8iUTAcyZ4LzeW
         gvOF7etrhUuc3VM3moP2Rzuf/rincvjdiY+TjpnandRFhBczCkb/VOsrbL46ZAz3CihT
         DG9+yHWJSXdK3+A+z0C1RpoCE2VVHps1SpQFqrzGPZjq4sL9s7+Iris3evUoU7Kwp6ph
         zGvu7StJ4Ow864bsmcUY8lKxKmYTzdmIL/saGrMjQKZxXyDv7Jn6G4p3in3N+tKwZXMm
         hpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477117; x=1784081917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
        b=XNl2MVEGChRSu1HMHS4P6nwiwvo98JLng2wEHEdsTUR5yv2XhCTq7YvXX5ChWMxe/o
         xZdsqJomE/arPFjPIHpemd1IhJWxxTG7U98TOtbBHT5O3/RjVLl0qTLU+wlEwhpNg73N
         8kxmoZ8rcC3gBiEuXPPNOHov8xdHJnRtEZtLqdvDTuPNdWTMPpuoEYP8QNi3RmfM934E
         BH81Gnjp4teM1SBsiS6gBhwSyTTzR3W0GXNxsK3oVxxVAz+Lb4Nt76SkKlzimZErb0Ka
         YoGzPTuP6vWMjiohYuj8nJ9mEsu4GweTc7GuzHShvJ6apN1y4PcK9nb6yijq1lGZ8SQq
         azGw==
X-Forwarded-Encrypted: i=1; AFNElJ93q5mS6lyWyjHHbY37ufpxYGLURkC+2zlBydO8musbjqWxtT+LnUMhDu5jhoIHZq57BEcC/KqL1I8x@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6CpGb4GWkJt4+Tl24CdfzZ4t7LP5GweeAMyRy3FK5cpegGyYL
	cat9oM9xjuvM6Pwz0XKjPVhPSoyIWfM6Qnxvs+InEN/45W1cl15cWK/w
X-Gm-Gg: AfdE7clwOBRqxn9EXmlcCPZEFdILM94MRSNbCI6IOHD8IuF9dktSke5I5aZ91DQ7d+y
	u477a/mQJshrysgsL2bqT+INonFvaz/kchEuk6xDF3bsqPnZ8S1UbDQBuyShmIFG/n2JnRY3Oec
	swcYfG9EzCEwxNqKzeWYufExm1wmJiiy+1vasYqd0dOCVy5PY7xYMneCXMnlj059tIQ0dbNZ/4V
	0vwF+7fcvNO6BmBlRTbQZzc2OnTqHJ/L0X4I8dE2HnmAenBJSA1eF4xdHL/ovx6QxCE+YlikceK
	+T9bv01KqtINsGoO8/YSc44z9l7MxTC4DxBXRwCGJgzZQMrN+j8OTvxUrAf4FFw4Mphb/pmqVB2
	xPO5wbZAI+oJciDXKNTMGmo88Oy5gOq92YfGyDatG7AYYIKX6Tz+QXA0KpK0XsOh4QWxuOG/Xjb
	c7kIm72C3hzk++fWxDsKYOvi80Xt93To+10B6foVYpJcz9pMblqws=
X-Received: by 2002:a05:6808:5383:b0:495:dd23:1634 with SMTP id 5614622812f47-4a078d678fdmr4414093b6e.15.1783477117572;
        Tue, 07 Jul 2026 19:18:37 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:07 -0600
Subject: [PATCH v6 07/24] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-7-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZuzqA3zGt/j9kYmFGfFlaL94NbjSKGlzcBcWBUqAWbM=;
 b=Df/3Jimg35ze3m1P/ozSvM5FvBWV8r61gESD6JGx3nop2TPly5KJeYBPy+kA2q5XrW74Hvatj
 GIqsDorjqu3DRe7lb5t9WSRn+uPKlFWyrPUIZa3ReDIinFblSpF4CJw
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Add the stub macro for !DYNAMIC_DEBUG builds, after moving the
original macro-defn down under the big ifdef.  Do it now so future
changes have a cleaner starting point.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 05743900a116..a10adac8e8f0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -93,27 +93,6 @@ struct ddebug_class_map {
 	enum class_map_type map_type;
 };
 
-/**
- * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
- * @_base:  offset of 1st class-name. splits .class_id space
- * @classes: class-names used to control class'd prdbgs
- */
-#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
-	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
-	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
-		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
-		.base = _base,						\
-		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
-		.class_names = _var##_classnames,			\
-	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
-
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
@@ -138,6 +117,27 @@ struct ddebug_class_param {
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 
+/**
+ * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
+ * @_var:   a struct ddebug_class_map, passed to module_param_cb
+ * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_base:  offset of 1st class-name. splits .class_id space
+ * @classes: class-names used to control class'd prdbgs
+ */
+#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	static struct ddebug_class_map __aligned(8) __used		\
+		__section("__dyndbg_classes") _var = {			\
+		.mod = THIS_MODULE,					\
+		.mod_name = KBUILD_MODNAME,				\
+		.base = _base,						\
+		.map_type = _maptype,					\
+		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.class_names = _var##_classnames,			\
+	}
+#define NUM_TYPE_ARGS(eltype, ...)				\
+	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
+#define DECLARE_DYNDBG_CLASSMAP(...)
 
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)

-- 
2.55.0

