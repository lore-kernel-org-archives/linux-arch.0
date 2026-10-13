Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD147F2EC;
	Tue, 13 Oct 2026 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859001; cv=none; b=qnVZSk2XSYhXib3R8Ncoi+tZWkhfhWKc5ahwQkJFZoYFlIYvJ29D65zxMa7rlvhJSjgnJc9J920/qUoXRnP9/ZkroNB+2VoaeEw5SmCGDmqbScasaBVjR4sA3DHOSl9a3qVpvakQ0JMsHsBCqpbD2fqdkhF1Zi4PRUueTzBtRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859001; c=relaxed/simple;
	bh=DGJL1z64q5OpfI49SgGzWAOsK/0AzCAccuYpsC3tGj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emDIS/lNsfdXlyudJRSACSWN9900r/LUOjUjaFk0+cUTBNPmQbIhrtB06JdFamubVdjXXngzyyQRcVggPsJMLkMhMHHKVfW8/1GwaDVUqGiRhuUM7sXQUfOvT0fSoxp9CPmnnvJj5ukfOByqC5wL6Gy48JAi5FgkynlafZl1w6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEb0eHHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEb0eHHT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02E4FC2BD04;
	Tue, 13 Oct 2026 02:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791859001;
	bh=DGJL1z64q5OpfI49SgGzWAOsK/0AzCAccuYpsC3tGj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sEb0eHHTOMU92Bb6Km2urpuMwjlx52j3SxcrntK0iNTRRt5f2qwczrjBrPXNxBLeS
	 i32o8fcyAcDwqTfuLX7Hp18CtOf8BNWJbRTK8UU8Ifl7OvycNURQh7xcPSsUoPZYH9
	 yJF9yzIETCz+n15A1J3oe6IERJ/wRaVJDMGi7RGJMDA7uQeCzMFCuHiScZptK6vJ/X
	 4mfz7kYNsdLXR9PSwLRhVhqp2Cvc1USOy6TD7QIRo4+8IvQBqnemgkCagIStk7Z3Bx
	 RoDbpTKL9bSBDpMN0U+uoAewHSaM2B85WSYyFc06OijdxamSnUKnpkX9r11VtZ3GUB
	 6vKGGwTpetvwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41ECCC6B08;
	Tue, 13 Oct 2026 02:36:40 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:37:08 -0600
Subject: [PATCH v12 37/40] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-dd-cmap-part2-clean-v12-37-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791858995; l=2698;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gK9H6qdXFhLum5gK1CZ/NZb16/SKE4lxiU0/dKCwx/0=;
 b=JyeKj4+SPXFdpil8mY+g6SJ7WxquulAAIujPjFK/OUnIn1GWlCR/fhfP1nHqgGGp7OP8gtGaz
 3uxQHSU+leMAPU+pnkMBFihTy9r0dUXZnGLS61evwcunHg42SMaNcC4
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

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
index d228b4a852c3..2bd464f1081d 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -535,6 +535,23 @@ void ddebug_increment_call_count(void);
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
2.56.0


