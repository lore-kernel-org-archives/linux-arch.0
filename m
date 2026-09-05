Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38E501F36;
	Sat,  5 Sep 2026 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632022; cv=none; b=B8PDvu8rkqIRM5WjxZIhTt1LiMmTovdT84K4bqmv7w0kRbLmDEuwWUH+O801D5IYfrOvGlqYo9UhFUHP7TzTG3/gD2Df3SIVhQWT3IKVnlqaP+kPqQxAvzN0pePNoJdenerxwS89y6UnpRnUR+swu0u28HLEDbTQcdgPtJdWjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632022; c=relaxed/simple;
	bh=ARNi4S+uEex5xlePdk5Ex3c0YsZJX/TIuckkQjZjMHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFoN0pZbxlymoZ6y/Xo9DUBdr3fYMMF95m7Pc5cPiXNE7PUe1i+WmIZ2psfLlPeBYahMmGRHGZVN4bukLvll1nfJmIXVJQFK8neE30U5j4lgd8dV8/0WG9MtGCbxB2URwfR2gAxxv4KO3kd6P7y6CAU7wcIBAhW94Pc+KU4UgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq4Z8xNt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq4Z8xNt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D808AC4AF19;
	Sat,  5 Sep 2026 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632021;
	bh=ARNi4S+uEex5xlePdk5Ex3c0YsZJX/TIuckkQjZjMHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hq4Z8xNtEJK+5UgNJbrrB7aJG1Ir/5myMQU6H9U7Mb2yzk9phMlrzrBnxGEG8EJW6
	 e+gPyDOBmA0FeoFBwr4GMs8PFzhFHCNTKiAxrcwqinAOriZbR27bvNDtsoUpmwSD6E
	 TJDlLZLBxUwI1JOmxwumHm01WfOE4rM0bDE8UsO+Lkj2GR29GxNVt6RxiX4FClx3RD
	 Qd/8E/3hmZQCUhH5W8CwRYbL7fRsY6HHqEv7DsNxcQCfi9Odf+YJ6/d7rSZIACOoQd
	 gpm1q7k5UZnCJmzLo6XHU+IMitGALwD4QtDhgqLDtS9645gXqT/EL4fYb3BiFqzGEg
	 PZseGrCVOcNog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58BBC79F99;
	Sat,  5 Sep 2026 18:13:41 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:47 -0600
Subject: [PATCH v8 33/43] dyndbg: control-parser: treat comma as a token
 separator
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-33-a4cc0674f6fd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=4422;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=AqWOhKhwT1qqcNMbgtjNtO/UdWN/bi2/n/ZQEvCe5AM=;
 b=5D7lqrhFrdtA+q9X2TmwjIriLPVEaBU1KUYL50YTU1q+WTjoHtwo31ysuG2cZSgc8W/iuLqcb
 3KgBUbeQs06AEUsBt3uIsGelPcsEF/0zmR0fH/0rvdRk5zoZ3OeM9ka
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

Treat comma as a token terminator, just like a space. This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

Add corresponding Strategy 2 control-file fingerprinting checks to
verify the exact control-file state of kernel/params callsites after
commas-as-spaces, ignored-commas, and quoted-commas queries.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst       |  4 +++-
 lib/dynamic_debug.c                                     | 17 +++++++++++++----
 .../testing/selftests/dynamic_debug/dyndbg_selftest.sh  |  4 ++--
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 99bbae37d34e..fe86a9997ab5 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -78,11 +78,12 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
 Command submissions are bounded by a write() system call.
 Multiple commands can be written together, separated by ``;`` or ``\n``::
@@ -176,6 +177,7 @@ module
 	module */main	   # any subsystem ending in main
         module main	   # simple modname, selects same as above
 	module drm*	   # both drm, drm_kms_helper
+	module,sunrpc	   # with ',' as token separator
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3f9821f747d8..6f700de9738c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -322,6 +322,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	return nfound;
 }
 
+static char *skip_spaces_and_commas(const char *str)
+{
+	str = skip_spaces(str);
+	while (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -335,8 +343,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -352,7 +360,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -627,7 +635,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 2018031f58b9..a9389a98de8b 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -649,8 +649,8 @@ function GOLDEN_RECORDS {
 #K= bede904b02278e5648bb7a8243be8d98 FT_path_module_queries.2
 #K= 4b902c159d7f08f91377bf0a353e0051 FT_path_module_queries.3
 #K= bede904b02278e5648bb7a8243be8d98 FT_path_module_queries.4
-#K= 5d38e4cca64da64a4d7f433398668836 FT_test_classes.1
-#K= 5516e3d13cba7ea4197a7fb6c033887a FT_test_classes.2
+#K= d4923595eea382923aee64aed15c7c35 FT_test_classes.1
+#K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
 #K= 40a294034c886787960f4c751b196da9 FT_test_classes.3
 #K= 38e813e9025107ac3e24226b8d487a92 FT_classmap_inheritance.1
 #K= 9b82b12a35ad98ef26183db15071f70e FT_classmap_inheritance.2

-- 
2.55.0


