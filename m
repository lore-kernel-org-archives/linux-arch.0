Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A1C476CDC;
	Tue, 13 Oct 2026 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858998; cv=none; b=ioOvYgPkDJ5aVdbJuzcQ2pKQ8N8vdzwFH4hpQ0LsAE3h7+TA1NMo/Z3T5XxqUQMnixtPxtu13lwHJB74dscpqpX7RcJnBk1xtGOwOqip/yViHjLyPSkaA32NQ0+R5yBe1LAEWDTh00CsArwmUklgh+p4XFCFY79qy9F15RVQAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858998; c=relaxed/simple;
	bh=8sNkm28claSyB+BVZrPBVwLqLqefhXIwPuVBhYVg48A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoFd49hiOyeX4OX2N3s25gIYEbdz64WbD8uApMDeGe0ag7Rq06cvmLXKDKTfu4kK6SSm/VmXOhceB1eQrVBC2p2BdJAt2q921H+NVbbk7JGiMxSfekq5Yq9/YmAVbK2j8yQgoYzLGXN8iWqOlDsJMBChdqFV7VnveE5qChmy4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAr8g8et; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAr8g8et"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F827C2BD00;
	Tue, 13 Oct 2026 02:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791858998;
	bh=8sNkm28claSyB+BVZrPBVwLqLqefhXIwPuVBhYVg48A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PAr8g8etK9JjlrGCOnqo6w8/LpXlWLaMFeQzBG8nGNJh8i37lJgB85Q425DWgeqUe
	 PfNEY8qof2aiFDFUB/uWIurSdbyqVTV70/GnbCxeaTSnT2ZTio37OFzXWE1jjHiyGF
	 LvJGBxugUpbQyFOZ/bEb3JC276OIT+Et1QUT5xPM4a5snjNAK6G5giLBNrcwIx14Pv
	 3GZF9w6Q6Wbgi2kiiwBGlwMoVYNmnwOFEn6xp2xhDT27W2XsXg9O/rQeKFzIDh75Mb
	 jBaqiEKtByG8Ow9hSzllz/KxVH82xxbJZihZXvzxHHBBghUWGbvZ6IMktlpFyLbqKh
	 oGABIO8/f85gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C404CA9ED0;
	Tue, 13 Oct 2026 02:36:38 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:36:38 -0600
Subject: [PATCH v12 07/40] dyndbg: factor ddebug_match_desc out from
 ddebug_change
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-dd-cmap-part2-clean-v12-7-3c8cc5725def@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791858995; l=5231;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VqORYgdCqMO7jSBKD8Jf9zLnZ5PVT520YsjigPNpQ/k=;
 b=qYvk8srzf7gkSWIsdX5oMnncU0emiIaPNLq0jAPHRzP/TK23KNIv+OUQiDQKdOvjqQftxZy4L
 +BfOqnVsc1LBTB1qvv8PnV2EaYHlXWim4TiN3zIahmOKUAcMU310FnC
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

ddebug_change() is a big (~100 lines) function with a nested for loop.

The outer loop walks the per-module ddebug_tables list, and does
module stuff: it filters on a query's "module FOO*" and "class BAR",
failures here skip the entire inner loop.

The inner loop (60 lines) scans a module's descriptors.  It starts
with a long block of filters on function, line, format, and the
validated "BAR" class (or the legacy/_DPRINTK_CLASS_DFLT).

These filters "continue" past pr_debugs that don't match the query
criteria, before it falls through the code below that counts matches,
then adjusts the flags and static-keys.  This is unnecessarily hard to
think about.

So move the per-descriptor filter-block into a boolean function:
ddebug_match_desc(desc), and change each "continue" to "return false".
This puts a clear interface in place, so any future changes are either
inside, outside, or across this interface.

also fix checkpatch complaints about spaces and braces.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v11:
. move doc comment block down to precede ddebug_change().
  Sashiko review complaint (patch 7):
  "Does this placement separate the block comment from its intended
  target? The comment describes a function that returns the number of
  matching callsites and takes ddebug_lock, which accurately describes
  ddebug_change(). However, by inserting ddebug_match_desc()
  immediately after this comment, does it leave ddebug_change()
  undocumented and make the comment falsely apply to
  ddebug_match_desc()..."

v5: check for null format in callsite. shouldnt happen, but pr_debug() isnt illegal
v7: elevate null format to pr_err adding filename, function, lineno.
---
 lib/dynamic_debug.c | 91 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 49334d1aa4b3..8682c23b5fe7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -166,6 +166,60 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 }
 
 #define __outvar /* filled by callee */
+static bool ddebug_match_desc(const struct ddebug_query *query,
+			      struct _ddebug *dp,
+			      int valid_class)
+{
+	/* match site against query-class */
+	if (dp->class_id != valid_class)
+		return false;
+
+	if (!dp->format) {
+		pr_err_ratelimited("ddebug: NULL format string at %s:%s:%u\n",
+				   dp->filename ? dp->filename : "?",
+				   dp->function ? dp->function : "?",
+				   dp->lineno);
+		return false;
+	}
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dp->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dp->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dp->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dp->function))
+		return false;
+
+	/* match against the format */
+	if (query->format) {
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format + 1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format)) {
+			return false;
+		}
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -204,42 +258,7 @@ static int ddebug_change(const struct ddebug_query *query,
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
 
-			/* match site against query-class */
-			if (dp->class_id != valid_class)
-				continue;
-
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
 
 			nfound++;

-- 
2.56.0


