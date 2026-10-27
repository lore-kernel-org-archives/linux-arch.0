Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132535;
	b=lf/hn+r3SltluW0LgJl4VeNMaOGs7/mQCL0x2B8Na4tqikNQUXREIQ8wspy/knqwGlxO
	 oJEj9TjH85i8YeJkkrM/m1Uq3VBC7ykhTHpsedl6cNWsCmncFx5VJCqrz3wVvBZKIxXZE
	 RXOm7qtMq3IedfJiLi+NH3PkC6doMWcrejC8VyR1H6Ka2kKlV0RpyzhgTUstrFD09IM0v
	 BSCjbSxZmbWvahtN+p1ucenUKYIrmbu4TxXR/A6sp+lsKLn2Pz2CGFz2qgNj9t6HImmwi
	 A4ijliVHjZ78sOa78HLJkbzkd0l4qFC+v2b6M6cLVD9Y1U83/61TWsGWgcr6ICkE4QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132535;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ig65voG3tmgCHh9u4uwCMCq6mevIjaCR7JkDi5YM2Jw=;
	b=WihaxqiHIV67/nfntB1nhHKFH0HC5bbSzCdLD4AXFWsM7y5ctBlIxYxSj66FPrhlAcGv
	 ShpGSU+dLKp13VlkPJkunHGm0UfBz7yfRc0JTuC5YvJvsqzq28DwS1rJj//NgqsZ6T1l9
	 eV22gNFBeU/VErqJEHmJ2T8KBvaP7s++wmetFY4uipwRbLa0cIm2cW4ytxTwtE1kvCEXX
	 qogA4j3nbjEBtpqsg95vBtmc1p9q2yBQJ1tWcseyYyANxOBkmaasniH0EvWVa/HCkDDdw
	 KuqcKL5YLoBaxdCWW2meIBmObv9wqVjj7ln+VVd5hzyogrG/b6JdcpnoBqa6CCNUObw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aG6fpkVT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D260A2615;
	Tue, 27 Oct 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aG6fpkVT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132534;
	b=ugcosghMONucAiqYupfUuzls8dCrF82ELJO90GovPd3gcwWspLnSRUlLjCbAI6eBoFxg
	 zMUI6YF9mDYw9avh84arBKzf8QldKiM8nVXgbfMMssJgCL+O3xOix5X67yRkw1iCdYoSH
	 2KZzG4dLwbFZDbe+zFoUaan2F/zwA6PeI0XytySN23dA9HHCZdoZN2NZvQ/hWzsg8hz9C
	 3Nbexjk+MYoz89GgVJjKKkuIsE0quVGpboEMxL2UpGQXtlor9PiH0tRc0ITGbAVBTuYQd
	 j7q3oxrCEWtPCivB9302IGIwiXaHom6O4LSVtEqyl7nfPnaEUMWoe4h8V3EBt/NbVzQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132534;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ig65voG3tmgCHh9u4uwCMCq6mevIjaCR7JkDi5YM2Jw=;
	b=pa8OUTqEEsV+MXNc7lUdYlp7cseBcuLxSGOySyuV78ZNlkZuAl2OeiOcvk+OmXryQEDe
	 6sAQFm/GquJ/VUO5m+2ykmocDJuBQKGKnhhjy5pMQAzoqPPLq8mKBZc+HaYZISJbB/kbW
	 YWm2XeFjLl+liS+fs9O1IF728HxqAPbgMFvLXEUy0n0uyyH2DqP4rEEHJc9J8+rdFbgN+
	 jySVjggEJ/Az8vYz4LQL422AdkN5zpGeinpYUsI0QLIc60q34LZTYX5ghl1/eU0nDUnTa
	 l75eR6cfp63m9wTgDLCmnbSxX12IrVLJ4F/zdAnqHV2a1+VmqFnNO2lrbjvTud9Lj1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 49E101F01828;
	Tue, 27 Oct 2026 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132534;
	bh=ig65voG3tmgCHh9u4uwCMCq6mevIjaCR7JkDi5YM2Jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aG6fpkVT53bYIo24RPMK5Pr5r8JilFvr62P//WwuNUAMYEgM8dyyom8tSXXqn4YHt
	 XWQjoo346FkpL/CBaTXZSsMuomRk1pwGaj/l17LLShPrRvRWrsrK9DFtztu2GC5ewp
	 CqSJV5tdSC2IHb6xK2dY4cCiDI47z/Le2eT7z1coW5XDY8QvosQG0iYWSi0HpAONfN
	 HMV8lGJgm8MmF+yp8BJMJFZxAxhgPlDsGFR6xitRVIxPr58OHVAvlbMONB0q+tmRXM
	 4R6SsqwSok2vuzUCD2CZeT30Dx50z/02cX1BDXx47LqaS2Dos2nvx/LDrlQCyzHjpP
	 JQIhkLkzX7WKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DAB6F4520D;
	Tue, 27 Oct 2026 20:22:09 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:07 -0600
Subject: [PATCH v13 07/39] dyndbg: factor ddebug_match_desc out from
 ddebug_change
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-7-9267923be612@gmail.com>
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
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=5231;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VqORYgdCqMO7jSBKD8Jf9zLnZ5PVT520YsjigPNpQ/k=;
 b=fdCQ6aZAVI6Ap9fXx7BGyfBeta69HG7eSaZ/wVyiCUiBZ3Lz/JjNBHBGKJ8ByP+ipi2K4R5NH
 c8K5Kcua2okC+q5Rn5rgTcS/htY7vdTKLdldk2S2NOqWJLJaXkWa9CP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

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


