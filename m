Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FECC3CAE6C
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440521; cv=none; b=Otd4NEFckAMejhocgz/b9p7DycCGylypaJtAYlvfL3IL4uq7wmR0yJujVlTGjIa+JrRjj47yO7OC3beD1U90UUO8eHizNuTVKGF4Vd6/VjdhU8qzW0fAVBB+wmY65heo31aJCssocjK43aAuJU1hkg3kpc91qocW42dZVQyhx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440521; c=relaxed/simple;
	bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5zI/TfnW6fh9tSDQM9aOQQGMEsVpEn4MNxpas1vkItLdmDsJ5h3fal4EwqxmpIeafavKzAc6koX3IEdao0sacmGsrrwG0sZYhgYwhaO3LdhICgY3nwJ7Gls8W6cRb9lNpWttbavTjDBcUqHSVOy7lkYO3RdWBBZ23nMVXrliZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndhxaXwZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndhxaXwZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef1198766so37552f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440517; x=1781045317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
        b=ndhxaXwZxROMUTkTTheLiHKJunBF1NoP3N2sjOKjkiBlAe2lhUhyVcejVtcSKbYsKb
         q8jQ/T+g6KHvPi7VsbnzV2o2MuyXPaE0Fltymle6dnf7x0uC89U40eMu91i0xEav4Qqj
         qWqDL/7CfGqzQVhyHsFi/uqRcDkfLjYBR30HrGZxp4CMqbo7CZsh5Th9NSz98INLohR8
         KT6GzLHlwbxVj00+Npq9/fSWrMXy0HhjiQfgRcomqKy0Q18rEo+3iGnjIlxbu+mkrnUD
         yAjwbtfwuydgNbuPSWYFDvxRS/bBBlWHv4hnqEDrcFjR0nMaHkGfA3xgE3gq9exXak5g
         berg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440517; x=1781045317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
        b=UNStdovyUa83ABh/KyFaharJhvFVSJAd/o6v13RZQR9qcGZcqJLJ29Hp0HvcsYgLD3
         pm7C9kU+kJNd17BQD+38MhIFkXAhUh5mbC3ZsdgcFtvcM6vLoQjRl6e+LdtaLO+8q8tC
         aKPK0BKVar4eJJDqHZAlaCkAuk7gLrqT+OG6uBzGkzMtpY/02Bsr9To2DwwCuhG5WYdS
         wrVmDNq5QAEwuAp2ZpuVnMLoh1GlzCRNJH7Bn3/j9tFl8DtYL/hRPzfX1xe5P4LKethd
         sKtV4gT0zx5BylBoWLopMuN05RIWIiespp+Pb9o2ZTuN57ZlBOln/Z5lx0i6ARvpeIp6
         pWbg==
X-Forwarded-Encrypted: i=1; AFNElJ8F2hPz1gkMQ7R3dP6r/5hlGwjIVz7RMwnLN3wwII4zVahYFjhT3hY18dPpiN4SXbTMJ/C8CIdF7O3R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rt89xyN19nhQM/FIqKEkyHoEcbMIcYrjLHx1nv7MxuJonJ6S
	anzLVhsftOmbM7xtg2BsjElzm0b392K4i8oXHvgUFNozNeE/x57gap5i
X-Gm-Gg: Acq92OG5F5s2moDKht7WpIotiPSNhnSZnOga4rqkMG40JqEZ2FO608mk0k2ISCbfK/Z
	q813kf3q2bTYvHYqsVLYJAHntBlzFWLMPXWmmdnf+69TUx7/Ihjv8w8rnNoS1XwMiyYeiH7TNt5
	NHtNaUDNK/3ocYbWzuLizmTRG6lZhkDspSwClvKqqQYtrEwx0kwzRjf/0JE5tMgBPyF3wdX5QfJ
	0/JNXjLnCL9A15aq/b5Yj7jUiLSMg+YWGwmL+h1j150NQ9MP7LzkEvZY2qtnLEzc9Nez3DpbjnF
	aGyHTcrBx7MZahmMB2eG7BrbWN5o9ulZmwf/qAWV7gx+z8ZAgf9rHJkUEFZZp7HiFjMau7FxDDN
	bggdTXPbc8DJdquUzWbfLLx1fgHaL4QNVlHoDBl/AMgkxQxY2ZYVQxAB3yPB3HY3yIJK0S6G+S3
	GYz/HgAoQbp/uDxw6dRNpwXu+giFoSrEg+dMDBx54Rpw==
X-Received: by 2002:a05:6000:41cc:b0:457:ff13:b2a4 with SMTP id ffacd0b85a97d-460212d45famr957487f8f.3.1780440516932;
        Tue, 02 Jun 2026 15:48:36 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:06 +0000
Subject: [PATCH v4 09/25] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-9-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
 b=yKRcSUGKJPF1N81xOkwGdUsrGS5e7k+0oxRa79SHVcqZnYwsk+bAI6TglGb/cerMPabg8MXRZ
 vNNsAP0WXz6D3Gpiqi344zOSBq0aoaRivT8jjMznCdZuOtdT7emOwdg
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
2.54.0

