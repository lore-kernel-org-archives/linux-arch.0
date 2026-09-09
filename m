Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180E2E1F0E;
	Wed,  9 Sep 2026 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915303; cv=none; b=XUMLgNH29/7YXp5qlQ/rDi6lXqehxBakF4du+O1NqejCmYKcLrK3vJJ2kjzTNLlkeDaKfnj+kjHm73bqcN0dsI9BFgiKysvdjCKRbglyaFy6dl34IfvdqXVhWRITuHkgfLxvPDlv1J6VhKJWaM3XxMLn3R49WllJw3wSJVZrVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915303; c=relaxed/simple;
	bh=uzXm/b4QbJv8MqokWuEOjt9MgdGObMBFvzZn6eASFCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJ37r1BtY0N0RGQl6q1FnbJSk0p8cVAyGcPP9phuAk5bGEDJ2ZoWY3A4vJ34nuBidrDs7Tf7uqyvrdJoILRLH5dZFNGBPvmcI/WiXUFbHId7Wx4m+vPZzfD73ukLAQwD1r4o92Qk9V+MOIQkTDnynmpKExq2UzSo0bKU5khFwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfkEXlII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfkEXlII"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB2EAC2BD05;
	Wed,  9 Sep 2026 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788915302;
	bh=uzXm/b4QbJv8MqokWuEOjt9MgdGObMBFvzZn6eASFCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QfkEXlIIJL1vW075BnJ/2A6YVRdWwGuFst+9Q0h/+ZNF/Li5HTpo7Hz0nZ5rFStNX
	 tOxJuJB8Azsar+OFNsMhnNjUq/+lBBfo5ccHaXUko/VyWdlliZ1mMhZxVa97bdh5g6
	 eLZiBGrHUvFlWnSeNBlUVeDPJcwPgR3rcmaQKOPlmIBvEDLgriUdPxV6DzGmH07rdv
	 UMm72Yh/JxZx9fzrjMbiX2ssFuVYlC77lY14tZW26kOTcHsNUnJLp/7bzOyJoJCsb3
	 JyI5zNnhzpHpCbcp8S/xMjZQwU5GhXKfRC7T0IcHLOnqwhjIts6luXScHBzH0YXRyy
	 kyFY5oIDI3WhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5218C79FB5;
	Wed,  9 Sep 2026 00:55:02 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 08 Sep 2026 18:55:08 -0600
Subject: [PATCH v9 12/39] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-dd-cmap-part2-clean-v9-12-3a3f621f4a10@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788915300; l=3086;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=l5CmoenKqbbQLnaUgR0uejI8E5M4OyQOi6Rxnnyun7Y=;
 b=aroY8TJORHgETDt5VK5TDC+QzgzIb4qMnh2KKsPJdmQYBECjyf5UBGKQFCIXWGH8HXIXZcIfp
 ios96LK1UI+DslAcd9fbdbTlg4XlSkBP1HHk/9qMJGk0Xj8ZTdS30+O
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c                                      |  2 +-
 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 113569285d30..43850ff5ccc3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -557,7 +557,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 49dd85adb36c..bf02c505f1b5 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -619,8 +619,8 @@ function GOLDEN_RECORDS {
 #K= 9c405e06fcea50284df82d1ae9692403 FT_grammar_errs.2
 #K= 0b0d9b0e6f4c45c7d75d699fd3b6aa93 FT_grammar_errs.3
 #K= e008644e159c2a9d99a8d0806c06e71e FT_grammar_errs.4
-#K= 11833e6cf8fe8b03869aa4f669b63398 FT_grammar_errs.5
-#K= e85a4b665f5ef141e3f4d4505dec1da1 FT_grammar_errs.6
+#K= 5750ed178633f9a68623f928c093d16e FT_grammar_errs.5
+#K= 2cd51e5e3c3e2501544524bed0fab620 FT_grammar_errs.6
 #K= 3e1eba65bd936e1276c7e1d76b399595 FT_grammar_errs.7
 #K= e3ac86676e309d4e72ff3da287736c29 FT_grammar_errs.8
 #K= 466d325c23519119f754fa7860bae7c6 FT_grammar_errs.9
@@ -633,8 +633,8 @@ function GOLDEN_RECORDS {
 #K= bd8d9cf661c9aca54dac93c74cfc1501 FT_grammar_errs.16
 #K= e991391048f2fdffaaed99ba36b787ed FT_grammar_errs.17
 #K= 82d99278f471ebfbf47eeb19898525cf FT_grammar_errs.18
-#K= 3c8d268c94b0bf97e64999654cd840c4 FT_grammar_errs.19
-#K= 1a448ff3f1df9155cc3acf1e124f24f5 FT_grammar_errs.20
+#K= f3f088fa7d276981bf2898c048087f76 FT_grammar_errs.19
+#K= 984ecc198e0fa9fc91bc31caf7da2a5d FT_grammar_errs.20
 #K= 76c8a33c585d414fcc3f1c8b5ea5b4b3 FT_grammar_errs.21
 #K= 90cfc66e9d61f5c448353b97baa99145 FT_grammar_errs.22
 #K= 37a51dfd6e84cb64b69d3a0e23e68ceb FT_grammar_errs.23
@@ -647,8 +647,8 @@ function GOLDEN_RECORDS {
 #K= 2e37642dc8aee3d04b8a54a76b3b891c FT_grammar_errs.30
 #K= 593c8b4c41932e3bde564a0008627ced FT_grammar_errs.31
 #K= 85a2a0bee8d0cd10f883aa5477d62efb FT_grammar_errs.32
-#K= 3c8d268c94b0bf97e64999654cd840c4 FT_grammar_errs.33
-#K= 1a448ff3f1df9155cc3acf1e124f24f5 FT_grammar_errs.34
+#K= f3f088fa7d276981bf2898c048087f76 FT_grammar_errs.33
+#K= 629f6a7e379e02f38c543cdb48e3b84f FT_grammar_errs.34
 #K= d9f0cffb0898c54690735a71b0d4f3bf FT_grammar_errs.35
 #K= 4cf728b6a32043ea5336a14d0c435312 FT_grammar_errs.36
 #K= a11ae3f86f4e5f539fd6168d318f74b4 FT_grammar_errs.37

-- 
2.55.0


