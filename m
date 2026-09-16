Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182A5427F8;
	Wed, 16 Sep 2026 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572785; cv=none; b=bLMxrIrjYklMOaeLXKD/JuTRDWm4sjGxtJns4tf7n+PWe4fA+uyGrnR+Im+Z1dEr3Q4aSx8Iqg43b9VbkTFBrsgLqo8BEGKEkAXRaYYcqWVPPYTlSZAuFcXp9mn0bgcSxBjVIEUDbsqI2I+nZ74Axw/isOc1Hv0migdj2crNhAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572785; c=relaxed/simple;
	bh=qXTRbpJ7ReGwZJ5gYtv8LBnx55PmlIa0iKRgL5OtWxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbrVTfxb7L3wjBxiSLUn/G+2IKCvQyNS4fkymqPjvzADE1YayMLqRrruAArDNTlHMtOOGtsilZWKds7eK2zSOmnlQEhgsOibF82dqMBf8s/FltgtQlr4R/EpmLWvBxusXOOlt3OKt9z8jcoX0pCUgDTlcMttvQ3ZfvBgOxej8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq092fH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq092fH/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 638B6C4AF1A;
	Wed, 16 Sep 2026 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789572783;
	bh=qXTRbpJ7ReGwZJ5gYtv8LBnx55PmlIa0iKRgL5OtWxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oq092fH/CK6MMaxjIjK+vQOodq3WiApLPtq2lDhU8j95i2VzXt3Aq0+PqB/xBwvNL
	 vZ7mvA/CK8m62cavUZtjfZDfdEMYGFklQ+cvHwUr3GKFqfRUu69Ue8Zue92TeCS+bQ
	 AIeIDg7r5eBxrJBPjF2EwepSkOU0DdkYm+D0p+n5WzuaJ+D36XB+EKHkzLIMcMfjhH
	 RCLmUmcIpFA4K/fr2pjwz6R3QKsZFSXnIM/u1CzxdfCyzGD90AzesKk7sqUX9tyykk
	 Emu+BrWAfZF42ERYPtlyka3UH4XLXsHOyN6cgjAcBsuwxoH5iy00Yy+VDKOrUHuahc
	 4s+tc794VWwog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50509C982D0;
	Wed, 16 Sep 2026 15:33:03 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Wed, 16 Sep 2026 09:33:28 -0600
Subject: [PATCH v10 36/38] dyndbg: add epilogue to dynamic_debug/control
 file
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-dd-cmap-part2-clean-v10-36-af4cf4767707@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789572777; l=2252;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=t4exfKxrgybri5XrCovAfGOptL2KD/oh7WXXahxPsi4=;
 b=TohONGMwqA/3OVpvRGOo+ardrof1fhxX4yK8PzFM00MjzZwVBwOX7TvDE9VhdXjc8JE8qGeND
 ekqnZBFXLgFDwK6nIW3FL4norVhX/ECzjj383X44eJGNQdDSAgRZEMe
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

Add an epilogue to the control-file, to allow display of statistics
etc, without disturbing the header.

NB: epilogue lines should start with "#: " to distinguish them from
lines describing pr_debugs (and from the header line).  No new lines
are added here, only the place to do so.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v9:
. update ddebug_proc_start() to return EPILOGUE_TOKEN when seeking directly to epilogue.
---
 lib/dynamic_debug.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index eb28831a6cb2..406b64d67440 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1183,6 +1183,9 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
  * read() call from userspace.  Takes the ddebug_lock and
  * seeks the seq_file's iterator to the given position.
  */
+static char ddebug_epilogue_token;
+#define EPILOGUE_TOKEN (&ddebug_epilogue_token)
+
 static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 {
 	struct ddebug_iter *iter = m->private;
@@ -1198,7 +1201,9 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	dp = ddebug_iter_first(iter);
 	while (dp != NULL && --n > 0)
 		dp = ddebug_iter_next(iter);
-	return dp;
+	if (dp)
+		return dp;
+	return n <= 1 ? EPILOGUE_TOKEN : NULL;
 }
 
 /*
@@ -1211,12 +1216,20 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp;
 
+	(*pos)++;
+
+	if (p == EPILOGUE_TOKEN)
+		return NULL;
+
 	if (p == SEQ_START_TOKEN)
 		dp = ddebug_iter_first(iter);
 	else
 		dp = ddebug_iter_next(iter);
-	++*pos;
-	return dp;
+
+	if (dp)
+		return dp;
+
+	return EPILOGUE_TOKEN;
 }
 
 static bool ddebug_class_map_in_range(const int class_id, const struct ddebug_class_map *map)
@@ -1268,6 +1281,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 			 "# filename:lineno [module]function flags format\n");
 		return 0;
 	}
+	if (p == EPILOGUE_TOKEN) {
+		/* use this soon */
+		return 0;
+	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,

-- 
2.55.0


