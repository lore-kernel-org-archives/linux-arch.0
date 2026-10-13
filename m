Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4960476CFE;
	Tue, 13 Oct 2026 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858999; cv=none; b=WXWyQ6uxJUN8KLxyvzb+v2GWShbaDIJHI9saQs38GKdm9XIIULy0x5tzmafd+xN4hNUEpxxkuV2l/E3rbL936wJ1zbKGqTgmig+w50vdevXQ0sfsWcEo36lSAODkn60KOGKHd/EdlU1r1ZM6qpNrQUEZyOIf3/4YTel5FX9q/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858999; c=relaxed/simple;
	bh=aPl5pme4/LJEzc1IQJGXs1x5/5nqdIsjjB9NpFJ1Osc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xro8BZLPUEb0LBzwPQrlTqwoKzgxwnTld0aOQtv5/WKma81XPjCIhzzqLe0exiOjjFuAX67gWf5JrhcfNEvLBUQ93j6a1u2mTxct6BC1CIsGEMgloxrYmdaQc+FfGib7hMBv1eodHDhRVLplmHHtzKK7omRXykIMymENTvwTm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGInt6Xr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGInt6Xr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95960C2BCFD;
	Tue, 13 Oct 2026 02:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791858998;
	bh=aPl5pme4/LJEzc1IQJGXs1x5/5nqdIsjjB9NpFJ1Osc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HGInt6XrfD2RyR+UibMIqLpv5qAocoxqPjILIMhT8W+/RAgdiRXpH6BcIEdu/UGGO
	 klncpecbnvyl+pL/i0PuLyzwGGsH250WKATMAPHzzrlpxhOJ7c7r54Yes4fx9Vm8Q1
	 lIj+4lL1W2qVEGxFeLJsAo81HBO4193uyAmfXd3kCl3R2iLd1Tc5ulyVrxYFhUxY2g
	 DCFUu3/7Lq7C2R1R86czt9ZPL2DFfOm5ioXk4MTHzpyQDdymLHfnBRRvdQSaeLIipY
	 3cm6rGiUr12syrjymDy30ZeBNJloZ0OtUZue783kTepjuF7XKk3esca3vgyhtTTEhY
	 llAbzMdq5Jm/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F19FCC6B03;
	Tue, 13 Oct 2026 02:36:38 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:36:42 -0600
Subject: [PATCH v12 11/40] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-dd-cmap-part2-clean-v12-11-3c8cc5725def@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791858995; l=1542;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=4fUQ6VDuWM6S7NYu7bhh+z3cfhN2DdlYIxp8VPxliP4=;
 b=41tkIv/fZsFSYfxpSZLD59D5RXHNHNpBqcDC956A75YNZMsoy3FHReLizVGEWojVIpv0M+A6N
 t7ICeJ6PxlDC7WfQRUbsiS1fktunG9Laex7hFHhjD8OlM00mMhjuHxX
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v7: actually use macro
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..baf5c0853f45 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
 		.class_names = _var##_classnames,			\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.56.0


