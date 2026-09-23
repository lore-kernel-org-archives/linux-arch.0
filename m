Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6245921E9
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202951; cv=none; b=VKXSha2CJXw4RUohjpGU4MyKJBf46JSmngqEYbBGUUfZF/Qzhyui4tr7/HfA0G6fPEeJaRS+CNJxDtjtsa0Ko3w6whEA+cXgjeBXeUCkNcedQvZZTO5OlFYgAMsIe2lkb2Yg/UsGoXRP1pVctGgQRVDQwJ525fUdIU8N7U2lYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202951; c=relaxed/simple;
	bh=BFGfVMUIUlRIm2JaJRLPto2g8rjGdT6CEXAVSmQr/a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYBKm/+8lt5DeE1BzVc5So3axQcb+poL8r9i/dgHnHZgRwyAVvdJuV8DHLPLC3f7AGUfbwgzVqtllvdLIqto9SXB2A8akJ+ED/r5sKTnUcJ7bqEk8KcnRX5W5GckTakQ/gODVyDVSkkSgYy96vN8xRop0GnGWFUN4S04SiNWfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3kDHqoa; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3kDHqoa"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f4df360cc9so305203a34.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202945; x=1790807745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFfpY9RKNpyGZptjFUYIPxK+/JHfBQcKAOCTZ1dhBB8=;
        b=N3kDHqoa2UumT3DmpHSGMl+xFCnOjVtqqX/XNGPRSmW3yxsckmlzUTI6Wh196vIcyY
         AWwVApECv7CxQkFG4MV5Etn1jzNig1iVBsCjMguzuFUx8M2PzWTe0cwzxCOQDO18UAes
         1vPJQ9f+nbjVRdMq8cjdga7WUo9rITFxmPCKLlOhp+kXLKS4CvS760aPZQrgJDgqaBkO
         k301DpnnLxN0X43q+nJDE/BOTVk6Ie6KEaOd1jvbTAAR3j4/vAYcv4zmO3T9aaSWyyX2
         jnG3oCGGL0wBQ/Ra3LDX/AJrRrc71h3bb6lGlzAZfSMedhEaNdAdEe7QdhplLKtgJHFD
         PZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202945; x=1790807745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFfpY9RKNpyGZptjFUYIPxK+/JHfBQcKAOCTZ1dhBB8=;
        b=vZXsWrgwgAT2/7Pao9MJkCq8Lgx/qh+SLb99kxJ8JM7ly4h4K76ypTQ/mRev6Vawul
         azOxbBLF9U1zqeWhzB6aNSrIu4cvwODOOPS2SXAlP8j2boVC+wMGPWi7YUgzF4BCXMtv
         W6eoWUaQNYQWacYd9aQnEyjN9i2nxWY13BCRhSRf+Ou30G2TMxZJ/cNU1/+eYIcgkI9A
         P5KehU3tPScXy8yFxfdJRxZTunl5VVQYYANRlvEAmDjRv9xDK/m9tMFMTpSoUQED2ZRr
         ltQnZS6tw3I3DmL4KCXLhskBnJy1zssiPl/52lOULtUU3+REMXR+lWT5P7tanzAECjWM
         kjzQ==
X-Forwarded-Encrypted: i=1; AKwUvByER8IfCpISj3vzT1ikj1rvXveTilvIhouIYafUYf61oO3E0E1HGWpezEa3biOP1qMXBh8jVHMvOIhh@vger.kernel.org
X-Gm-Message-State: AFuF++k+BJPXBGCQcV6WD1OFYgWPAiWQqbTq6S9rmi4bw3i8IUL3WhJ2
	X2Ont9CEsk+4HEGXQKFEqFNOylXnC+QNGMraJSV3SUBnlKz/GprHGwJN
X-Gm-Gg: AYBFou2699Uv93RejYMK9ucXw81LkwY1qVDUNXuG/+amCS/ig+0UaSr6XDXk32rVyo+
	WZjfMy/L02c+py4iUA1C9cua5OQSfJ7bE3SwEcjGfN91ZlgjFTsAnUGO3u6ptZucYB5iRkpvrw2
	IlSNl2Qlv53+mXlm3gsLrq6KEb4W55bnIDpO2JT3H6Y432BP1aePJGtPDofkXy/GNKXVtvig+9v
	4GHHk9Qlqil7F9Vb2ZmihGMNJZ1I++O9QUGPF0NN/QbzP9/tUVRcXMEDaGsevhmQ5a0sFIJo79U
	YXoc33ko9EVM39du2yFOske4m5Avpy3cVnX8s8twsP+BxHUpoY5Ubyd4w4wFTpgdvs7VNufWGlL
	xfxfQgsfTjqoH0o1HYxgQuxqG84ZNHq1mR2iIIj34xJUksW4MkZidRovcI9U2Rl7S/M0mNjLeev
	fsH7jiHnUIPZAAre62cpgIH/HnwBATtFoGYgBIvO4hhRmjUpg39in7BbdMzBQINx0/8ZkjkNpvD
	Xvj/GH4gxbp4VvQmrKyDkGw5W+3Q0v48wlkc5bfbgUbIkSdX/z121+trk140SHF8+/ZattJyNic
	X3O0Pk51IL9kLei/PK3q
X-Received: by 2002:a05:6820:4b97:b0:6b5:ec2f:3568 with SMTP id 006d021491bc7-6d43f4baf36mr568755eaf.25.1790202945099;
        Wed, 23 Sep 2026 15:35:45 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:53 -0600
Subject: [PATCH v11 29/38] dyndbg: control-parser: treat comma as a token
 separator
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-29-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=4314;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=BFGfVMUIUlRIm2JaJRLPto2g8rjGdT6CEXAVSmQr/a8=;
 b=d5+MQwqqnsKPmHlPuUCttE4PkQ7Wy7yoFwYejLCbxsCnQG3UvsatUX9GpXn09cb+z3WKXqaaR
 HvFmmuDzGv7B8sMzShv1xHHeYfmjW7kSdoSPA1xOTIEEw9Xy5PFUlUu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

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
index 9c2f096ed1d8..b9fbb2a12955 100644
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
@@ -172,6 +173,7 @@ module
 	module sunrpc
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
+	module,sunrpc	# with ',' as token separator
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8eef2e7387a9..6482fd28def4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -323,6 +323,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
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
@@ -336,8 +344,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -353,7 +361,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -628,7 +636,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 6f1d11828b79..a357905e3606 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -537,8 +537,8 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
-#K= 2b4b152bdb82e6e4a5be18ca26025895 FT_test_classes.1
-#K= 5516e3d13cba7ea4197a7fb6c033887a FT_test_classes.2
+#K= 91838b4012c50a1dc1d9e210ba8d68f8 FT_test_classes.1
+#K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
 #K= 2cee6842c9cdee5cb3bf50b2e3914813 FT_test_classes.3
 #K= 81b16613f8d444485e2bc5aa4d38d024 FT_classmap_inheritance.1
 #K= c14c8aa758e24046b3237d20e2189bf7 FT_classmap_inheritance.2

-- 
2.55.0

