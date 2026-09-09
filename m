Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B5349CD8;
	Wed,  9 Sep 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915304; cv=none; b=ApDj1PigeF9cdJhty4kXHRZxgkUduEujFvLqA/7FFbXnoWsb1MVFTgVQ7kYbpsdNkGZ2hONKJhVLDdXxQRUGAMZGojzhmRfiPs4o5b0iHnwJR849Fscl1gyWsSodIicRibZ8AG72lWcguui8J8JvXTZIizTYfqFenjOrgdsw6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915304; c=relaxed/simple;
	bh=Pu4jFw/n2qmbKY5gxWu8WCu6XgpSwe1vy3HOi4Z4JJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShG25gUXlY6RgXknY7XzUXUdFDpVx30beocihfItJYzDPDgon16YNFAJH3sC2arKObiF3mU5V0gRmH9yDzV2byfZTi1F/jZbJAGZCIL36V4EPNCY1qLJ56YSAmFrjcb4ty/S2xz2MjcIfznR3eiHCVuYBN79a63pvrDZk5G0Zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI1lAFB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI1lAFB2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9BD8C2BCFB;
	Wed,  9 Sep 2026 00:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788915304;
	bh=Pu4jFw/n2qmbKY5gxWu8WCu6XgpSwe1vy3HOi4Z4JJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bI1lAFB2jyoLkpx2YPhyQlqT9X6P6MmuoQCAMpo+vmOoH0u3y8zDYS85XbNQj8RPa
	 ddXPbk1H172MGmWsUJSDj1XlIZi5nVKyRonor3UUeW3pI3tesTEjvMAeoifdRNEkQ3
	 lUmp5owSmRgOT7EgpiaE5oDFtWh8IhVTnljp9tj52holNFmUhBGPJm2mp5D9bPvR4a
	 ydJWNNxnqScly3urjjhuKmuKDhAJvoXGzcO8DUcgImbmAUt4TO9jRYqGXfpnIrkYAJ
	 C5sQ81fW/j2Omh1e9QL6DYnw0Lfmj5B9iBju1fu54vh4ufoM3WD5eZ8lyxyl7T60RR
	 +WsWM7avPjsCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB9C79F82;
	Wed,  9 Sep 2026 00:55:04 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 08 Sep 2026 18:55:33 -0600
Subject: [PATCH v9 37/39] dyndbg: add epilogue to dynamic_debug/control
 file
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-dd-cmap-part2-clean-v9-37-3a3f621f4a10@gmail.com>
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
In-Reply-To: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788915300; l=2252;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=oYHWUJL7INC4Y/mX988tAYogU/OZy4J+TTkT4CPamL8=;
 b=Q+FNT832FBcFf4Lw6LX8mDpUlmsZNcM7Jq9/wT7sgCRBuEXEHUeXKefbiDBE5GXI3iBtxZxDk
 0HvnuTmkEBsCGzyEfLqcMVgbEcaJo3OdrgkkGeCi8qxBu5hldwOiTzh
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
index afde13a2121f..77976e7b264c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1159,6 +1159,9 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
  * read() call from userspace.  Takes the ddebug_lock and
  * seeks the seq_file's iterator to the given position.
  */
+static char ddebug_epilogue_token;
+#define EPILOGUE_TOKEN (&ddebug_epilogue_token)
+
 static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 {
 	struct ddebug_iter *iter = m->private;
@@ -1174,7 +1177,9 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	dp = ddebug_iter_first(iter);
 	while (dp != NULL && --n > 0)
 		dp = ddebug_iter_next(iter);
-	return dp;
+	if (dp)
+		return dp;
+	return n == 0 ? EPILOGUE_TOKEN : NULL;
 }
 
 /*
@@ -1187,12 +1192,20 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
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
@@ -1244,6 +1257,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
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


