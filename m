Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132547;
	b=LKUScnWqMyr/b1pFNFnU9oXnIba3NzhT8CuVqBveLk8cZs20Dy77SI2pRKAWqVbWQvX7
	 JJMusepniPPuixYpkfbcFl4jqLh3z/ct/ozbMVknGLifZchGPXhKkTdn0vXHKqrYOPaco
	 YkhRmTmrXJp2eD3XsJUMipLs+Y1dFtbtpJItacf8uMaEIDLOmU+b/lwqTfy4FqI+BdmfR
	 0F1nUZ9dzow+u7bf9eE8ROUb51a7cLaU7eHuDXbzEKdlYvy81DW108dETQozmoadBKSQp
	 +pgwL4TDT5hd6xHVyUaBS/E5wvLu5kDrO6/QNlrqpO7y/58URigvY7ip48WO9t7hseA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132547;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MD3WemlNx8wDWgzNhjIwPFawd5UT5lSpHnkAmq2nUNY=;
	b=B34weIgg8YCXuF9UKP6AEVaLGW0vu2cg4VO4a8V4RQ6NUlGUehinNrKibKf29O3LZEV2
	 2isYoNKCwa0b+9h4RdN2nlxiJgbwc0DZ/R9ar7hGHrmt2QK/9RsioLfxHN4TxG2MtyckQ
	 S86m37c8+W6sbZEM7COwOx1Rpi9s/MSTkWcmR4DS+TykFjIPtg9xHWf2JI9X2ZY2zNZZz
	 LtJlgjnV1atihg2et1Z5pxeBDQjmCoMgPnGCwhjFpdcxgKk9eVWj0e6ILxBmM16eMc3JM
	 58/mzyjWfdU15UC+qBMqD0ygXi3HihsU5tC7+Fxo3akpew21qUKeBo6dAwLW1rwHbxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkhFz+xo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA23560A6F4A;
	Tue, 27 Oct 2026 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkhFz+xo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132546;
	b=IJKmio8d3wJMowlymUCcRPk57oEfXXnsgFllh0dd9tzHX/NorZGHAq2mLuKm9vuEnj3p
	 C3UfTj6zYzb37paBvCE1deQbNrweqtGvYUg+y+YheD90OiVuJHyEj+7r2+7cpb9FMbHMU
	 EVr2m9ia+cEjI9euj9jWRfYVTEbfoUa9nGX+X8WCZQ88yJ2zEaYCfcuVnBRgddIZKbDvJ
	 KDcskNdj37qweBuHhMf+0npu9RAqT0N+AmSYnLBN/qrMqStHeJPuLOVjlLazRnx5TSRMq
	 5c3lmc+SZRtPSS1vPY6nYjTt53JV/5QIBY2BCTxMB5Q2Ryov1UqepwSZecHy0gq2n2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132546;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MD3WemlNx8wDWgzNhjIwPFawd5UT5lSpHnkAmq2nUNY=;
	b=KP2uLkTL5Mn1FPr8r9IiKn0SRyM4E0b5/OAQA7y30lheE+NNYm6yKNFfZgpoYp6YNTI3
	 Y36SYrqzqQK44ssR5mD2naNAdFhjw8WjwwhP4D7qiacrGSLV7dYIZ4YFVsvHWtW/modOZ
	 5ANLE7i9iv7u1ZAbhXFCQfEOWOIj+sJcoq/NzKJljfkNSxb9scsKe3aDApifJQwZ5iAtW
	 EIXerTLqcZpan6MDKb8jGYa0Eaj6C5TbF48wvOthL5w858EJCruX081L8izh1TLRUE8ez
	 EMTpHLCa8ld6RdPX70BjK81htQCOnZ3LLths3yqS1KAjcmkudLUDrhZl3czw1RxTg9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E0C121F0136A;
	Tue, 27 Oct 2026 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132546;
	bh=MD3WemlNx8wDWgzNhjIwPFawd5UT5lSpHnkAmq2nUNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LkhFz+xoly7mxPoFNYiEVs8Ske78Jx6jlzfQ/WNRTwbuzmu0VmplQDEwVbIvOTwbo
	 H4cYbn93vGekHQxWdRTBtwkvJE1ekDqwykRjYlr9p6JPPz3FEb0+x7YF6WiOgyVKOW
	 c9TjdqNtgkhNKQQeDsu8JwGiBw8jTrTEM3qpCdONegzNVrs0jljO0ctsgD5oCSWlsB
	 +ghGvkWA//E1yqFrhXuOnBYwZzEecxknKgpM+FS1OnoVCUOOFmpR5y9YUDbyESE667
	 jRMQWpx70udqrsJ99JT9DRywBkBGBXlGYNyrCXOOXMrCEn4MCgafHjLX+Ddr+i9JHb
	 RSAZxy8EHhzpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 38EDE45274;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:33 -0600
Subject: [PATCH v13 33/39] dyndbg: add epilogue to dynamic_debug/control
 file
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-33-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=2252;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=GnB4si52gXR6L2+aPCSO9dyvxPaeMcaUtlggi3ubNhU=;
 b=ETZPNmW0juGHsMdzAOFLnSr7VbeUa75JKUrCV/Qur61K0h8bUwUfPHiNgNEn3UR6DK9B9RLs0
 VlVhImNeNy7CH7IjOWn2G2damVla20PPgJrl8ck+SdnE1y2IVVswcFj
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

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
index 82edec19c67e..5c87e92bbcdb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1185,6 +1185,9 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
  * read() call from userspace.  Takes the ddebug_lock and
  * seeks the seq_file's iterator to the given position.
  */
+static char ddebug_epilogue_token;
+#define EPILOGUE_TOKEN (&ddebug_epilogue_token)
+
 static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 {
 	struct ddebug_iter *iter = m->private;
@@ -1200,7 +1203,9 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
 	dp = ddebug_iter_first(iter);
 	while (dp != NULL && --n > 0)
 		dp = ddebug_iter_next(iter);
-	return dp;
+	if (dp)
+		return dp;
+	return n <= 1 ? EPILOGUE_TOKEN : NULL;
 }
 
 /*
@@ -1213,12 +1218,20 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
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
@@ -1270,6 +1283,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
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
2.56.0


