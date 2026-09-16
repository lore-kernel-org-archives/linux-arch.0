Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B9538D65;
	Wed, 16 Sep 2026 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572784; cv=none; b=M7tlBnOblkZEB3k1gjcFNlL/KC7+IEJYfnov3xv52f9jbzUAgJ2AGrXfNywfovquTK9wKRabK1pyyKPEHof5iVQlj7ioRdoP41iHcUaAdAKfJIBaRN1acldjy19TKh5Xgvfn8VeRywiWEJ+dEZnzXsCPpahi1KYdb/3cIKRF90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572784; c=relaxed/simple;
	bh=G1e93JLYIeHbZ3shQqr2lfvKOb15ncKTvdp7EKGbQPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnN05F0HjCgJZH29vTDIOrkPifGoVl26ZYAMzsvQyxxzONQHb7HtvOGKjuaGIKIIZE1w/MmfPFKWMxFRRunKTKoIcq0Zs0McyDrhE7xtRBpfwBo2WlrdwXZ9M0X4HlP82nkkPREM/gNs0KT1aRL/SHXUodx9rzErdC+/pQ8lb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBVJRquW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBVJRquW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D757C4AF0F;
	Wed, 16 Sep 2026 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789572783;
	bh=G1e93JLYIeHbZ3shQqr2lfvKOb15ncKTvdp7EKGbQPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pBVJRquWq8kLnmusxXWgw7tIDTXeY56qkOaRhVVe5qCmsByNyicYel5E8KSGVI2a9
	 pwtb3SR1hMhkKx869sC4mfV00bpEUtZBv1ycsiklw7klpqbbpJC9JBzP/f6Xm7REcC
	 0CyMHt5Dfw97Xyx4KSJi/xiv6AdPJ2GaK2wEZ32K7bZOtUQ/shjJtJlaV9ZgGcHFpv
	 X9vcR4h4sM4SlD32tJp47B/YJ9zM/ZWCg8VenxnC7ta/0bc0iefGMpDrQdPJqwqugE
	 YUDC9cNONjByeNh8tNVKjYQYjJXsLTOMX4huvlLbk/3deY9dTlsBLIefS7eFjndbLf
	 0y48cXEwQPjXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7995CC982CF;
	Wed, 16 Sep 2026 15:33:03 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Wed, 16 Sep 2026 09:33:30 -0600
Subject: [PATCH v10 38/38] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-dd-cmap-part2-clean-v10-38-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
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
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789572777; l=2698;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Hqt4H/yLDyArtGauEPbVmb8rC+Dx/wzfM98i13kibjg=;
 b=YV7bSfgSweSi9dTMBz1wf5Apot/Xgx+SIb2AQa3lBeFfHEV4oRMoDNegLq1gkPbJKIco/HOKA
 7d0yDGEheurBgeOUyI5v2MT5uVWDVbpsJISUFO29ynoDZ1M3YYY3nyc
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
index 55abe0dc275a..a04e546079d8 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -556,6 +556,23 @@ void ddebug_increment_call_count(void);
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


