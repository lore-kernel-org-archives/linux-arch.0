Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F39595759
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202972; cv=none; b=RZqaOPfbADVaf4gR3uRx+SxGd0QxKp22iDHQ0vuej8SDsJhPeB6SyZAfCtC0eH8aSHh+PkC4zyEBbiNtmh9xQUlVTu1499yxZ5GSyKIMQpFHkdLmi4/r15fhDnQ7tRvTA9IhIO9s+FvZ6IvYN4QrnLd4uy5H4jM/w+9ougRn3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202972; c=relaxed/simple;
	bh=ATqajf/gbOgVHOHG+dtgeX5M5jVEAjDksP/Pl6A4CSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/p44tG4hxnRVoBN9yeZiNN2ayB+YPQDsaWk80yAwZ7r41Pt6BY6EsgZYN9g+5HS4sY/5SsKqJeMNAuToUeHk5H3npgUMusLef9MqJnt6nejGIM3c+yOpZ/8YuzN3d8agPRd9gWPizxANFzW25eei4h1WB6za9lhN39uPhY7tbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He9UO6i3; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He9UO6i3"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6a9aeaso896355eaf.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202966; x=1790807766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nK6gBgZb148t7QUaccdLW5Z1TVwXqhGj+TWUBMmkbJM=;
        b=He9UO6i3I/LzHDFkvF/3gecqrO0Viyu5QzgBbJTN8DMLtxzjY8Jh1msstmxIZv2j2p
         6LAzhACGkXkH40WdFXrfHYCKlv2NzKs/GUY+g+yaDHdLPL9xxrUdSn/S5dQbMejtGfmR
         MYQEtG+BDHVYbS5BqANO9imsmRW0mP6gtPZe+x5xe3jV/lU5+75fHFFtW7qZG6lCSXza
         a20VYyO4INQppf4XDgNBS7lG9IFIZziNcz6vhOfKCrAojjLAbW945+HBLFwU6/a9azNG
         ilxkGy86TH7i8AaulnFBjcGQ8Yc4m2N3QSiSSUNLPhBFZ6cIGtv2aqy8c2yd/nnn0I+M
         hzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202966; x=1790807766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nK6gBgZb148t7QUaccdLW5Z1TVwXqhGj+TWUBMmkbJM=;
        b=Egt6auL0M0S+UjU6INCPkFt7YhoqRFYpt1/dh88FI1uLvJGS1LN6XN7sNJgXyfbu4f
         KUtczKWSJrtCXBmX1F4BFai/qT7ckV4qhI7utzHDiDWf5BZ0cIEr6tioxUiI3M/PDIjq
         uuGdn5kgIyuVRRNOhFQzuFgijFegavjXgSoaXXxFJ8nqG2H9dPxA4QkHhw52e21guG7K
         DneUOFrls6UU0d+ZA9P2KH6UxlTiuW9NgxMhS4R2yibZ7/s9FifpqI9oWKkTlCHkqP5h
         /+LKikvfD+xlhmGhQ0yeWJY63qgUDKap0Ado12g1mT4RZ2LR/nprEZWRkEQNmG6yGicg
         dUwg==
X-Forwarded-Encrypted: i=1; AKwUvBzGflP16+acSvzPApzBhA1O7jeIjYwvn0k/ehnUZOEkS0l9oUN5UB+F99+2+eqtErvQgnJZNkPij7Nq@vger.kernel.org
X-Gm-Message-State: AFuF++khhwa4l7RUMY72NZQT63ItWbsubAcQh9XE3vEEiAZ7XQBRvbxo
	Jrt1qrFmujWJ2/f6XXI7tc/Be8aOQrNqdXIu5PDxiGy2UGTGphiBjq/3
X-Gm-Gg: AYBFou1tDTonsx8dtWSTTUGticvq4EslF2Upt93d7T/4XW0AfrlxeqiF8DSf+uwG+pv
	PhvZ53PBDpzgG680ZqVAON7NB7pC/TN8V0hXiMuUh+LZ776RSd6U/v4ph1hxjvyjDNUD5PDhBPd
	ufitW3654hh3VY+PyyyXHVSuBvKaAxKHUh/IQYddta/4sTCDt1wunTzFnBUacTQEmLmf3tBE6C1
	Y+DZJr8CovacTFaDQ+IoP0opM+mMzkDkfPR3Ltb7Jdr6Z6/M1EjwG3ZKeC2gKqa335CPR7zaVP0
	mncPUGkcX/7FR8X/EiHQSRYg1cPpLFLXtgbT1aeyt3XFOS3RQjS5FU2IBGFO9/u40Xifoj99sE1
	4xu7+aSHTEwsaRF3x2YdsmIxH1Gi8XVdW5A3IFl87cg9D4uKRhCX8iSF0Z9o541CdRjuAc8milR
	v+RmHllW0O9vSwF2whJwm8tpG4UduHCTiXiXrgYCi/MbC3FdQXCis9dj3MnlGvN0d1EmaHrAKZx
	12sxwH6hnc+EN1Q+34tsrFaL78ipuvZE6efG2rldEVh8rXZY2pl7wUpdGeDViFxx3UJ6W7J2z/9
	IkRzOUB9hT1RgHOm4e3+XDJ9atTEGA==
X-Received: by 2002:a05:6820:f06:b0:6ce:7f39:7c2d with SMTP id 006d021491bc7-6d441995854mr659245eaf.81.1790202966437;
        Wed, 23 Sep 2026 15:36:06 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:35:02 -0600
Subject: [PATCH v11 38/38] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-38-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2698;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ATqajf/gbOgVHOHG+dtgeX5M5jVEAjDksP/Pl6A4CSs=;
 b=txBmlIpJKZ3sIAFazKAMFYgulL3i/ZCu8HE6q8J8RnlArxGJutYMSYxdMbkYxGs5PglmSgT73
 lKUC42nhgPMAz+S/DRsl2roh66CQA86RbVYjeWEEbt8mfIoVrvaDPAc
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When the dynamic debug core is enabled (CONFIG_DYNAMIC_DEBUG_CORE=y) but
the global CONFIG_DYNAMIC_DEBUG is disabled, subsystems can opt-in to
dynamic debug by defining DYNAMIC_DEBUG_MODULE.

However, for built-in code (like DRM core) where DYNAMIC_DEBUG_MODULE
is not defined, the macros fall back to the disabled #else block in
include/linux/dynamic_debug.h.

In this block, the family of _dynamic_func_call_cls macros were
completely undefined. This caused build failures (implicit declarations)
in subsystems (like DRM) that attempt to use these macros to wrap their
own debug functions even when dynamic debug is disabled.

Add stub definitions that mirror the enabled behavior and respect the
DEBUG macro, similar to pr_debug. If DEBUG is defined, they inject NULL
as the first argument (to satisfy the expected descriptor pointer) and
pass the arguments through, allowing the wrapped function's own slow-path
fallback logic to execute. If DEBUG is not defined, they use an if (0)
statement-expression to compile out the call while returning 0, achieving
zero overhead while maintaining compile-time argument checking.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605201408.x1sHT6fx-lkp@intel.com/
Assisted-by: Gemini-CLI:gemini-2.5-pro
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 04620b869832..5e69cf6f37fd 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -542,6 +542,23 @@ void ddebug_increment_call_count(void);
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DECLARE_DYNDBG_CLASSMAP(...)
 
+#if defined(DEBUG)
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { func(__VA_ARGS__); } while (0)
+#else
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { if (0) func(__VA_ARGS__); } while (0)
+#endif
+
+#define _dynamic_func_call(fmt, func, ...)			\
+	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_no_desc(fmt, func, ...)		\
+	_dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #define dynamic_dev_dbg(dev, fmt, ...)					\

-- 
2.55.0

