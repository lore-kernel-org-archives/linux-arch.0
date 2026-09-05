Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669C50C293;
	Sat,  5 Sep 2026 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632022; cv=none; b=Be6pFfpGCP9bKAS/3n8kJWphHODURo5CX9H3sLgyutYE7bGIbBzTbSa1ZxS1/Pr/Jd2AmbnOPCsRAJJnhnKWrER+BwMZy73S5b0uLMSiR0J7/9CDb7hU6do7zZUZDXL/7DbCK6PjJ5JtML1KcGFwptP2btzi/59FEOZOrd3Y+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632022; c=relaxed/simple;
	bh=SUBykgQmJTa1PE14m+dIJu09xFu1BVf5d/3PHirJEgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzwuKnfk/5CfUqLa5/+tqCfTCcnWisbWpGq+U8JlVYdMPBBW6a2vWdkjZtOeRErTbGzOwwEZCNTnSZ1fJLKnkJDX1Die/SbJxGcf1b/hIZIsgVfEEbQCeb+u9vMReEwaMhlTpzWzen4pWnFkIEnh788xtGoC4I3el+lHjn99i8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhDPSF8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhDPSF8X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 677EFC2BCB3;
	Sat,  5 Sep 2026 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632022;
	bh=SUBykgQmJTa1PE14m+dIJu09xFu1BVf5d/3PHirJEgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RhDPSF8X5IEGqS/LWDJ6FahigCjxAOGLj4nJOWzLAND7qgqV8nt1fK8F7pzn5GfxY
	 PR9vuCp7GnGme8mXXbWaVHkkgV6WApAFbXULNcLbR/2TEFer0sNfnDDnolMHVQQFcG
	 NPkw2lYlzbVJjOQpOcNpe6av9TlYg/XfLvwhJDmKXN40kEP2t+e6mu/lwgiwiw7Gtm
	 DQ0GNUu9YLml5kJ48/pE+qO1h6yglaofiKhEyMPsgZDLzFjZEZNhguLupsTuxW3HlW
	 /+IXdbQdn9+doEZ2oLSCfzK+n2+vDzsxuzYWzDdJUXnN79rs0OfZGRmpuG4aJNIqAZ
	 DwdSwE69nmMTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540C5C79F9B;
	Sat,  5 Sep 2026 18:13:42 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:54 -0600
Subject: [PATCH v8 40/43] dyndbg: add epilogue to dynamic_debug/control
 file
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-40-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=1748;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pDQl0WU597+iuQJgxNO6SBnf8FKttKrNPLhxD1JVRzk=;
 b=fVQqIQ0u9a7YkCGWycdCyruWU55wIbPnwmvOf+0TYuca5l+5pflsdc8OEgFA7Gb3nECbmEmEu
 qJT6+75RrtNCLF9WXcvEPAAjSeUUIcTmW97F8bUEVE5pf5dy3/uhv0p
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
 lib/dynamic_debug.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b7ccf471b5ef..d098afe8d340 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1183,17 +1183,28 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
  * call from userspace, with ddebug_lock held.  Walks to the
  * next _ddebug object with a special case for the header line.
  */
+static char ddebug_epilogue_token;
+#define EPILOGUE_TOKEN (&ddebug_epilogue_token)
+
 static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 {
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
@@ -1245,6 +1256,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
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


