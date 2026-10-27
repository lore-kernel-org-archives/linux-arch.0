Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132545;
	b=ayYPwsz53ODx7rQV3DDamlEU7iUoDirVMmBsRpllA48pC3xSFcilXi9+9sLENcDzSOl8
	 KFEZi9YsdxLnSCgENvMSgu8URAHTUX3U3293N7/0jqCgF/uIArhDzt7ZQXXwOBfnZVsPY
	 syhbxp1OF5JJ9Wc5vNb0ygtsaTENBImypoiet0+AE4V4ZRzWz3gNyuV4ODe7yUFgs1L2u
	 bwUqWw3fkuX7YFct4EAlR0yUO2Mx4rA98twaJ9zkEIjIudBOcDQiiEysuW5OSMkC2VuBX
	 RVDuj+oGl4lGlUxgMq/rhqHFpe6yKam0P3tS/tZIOLO5TDFFJevquNmiRZ32aiz28eA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132545;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ux8MhwtSzPGJ/JCDUkwod0yro6f7wh+bo55Ba0zrplM=;
	b=nBgGBayW8yBZ+NyrHqu3nYjjmCv6MCmWqLvlXHX4HybcAhdaNp+VVJSI7pUfJs5TTKtW
	 tn9FVbsOPIeHl2JcRNCKaOVadSsWGtGT7fldMPJ+W4uOCG+6BQN7osN2VSNbkdQcZth+F
	 JIg8rHY9h4pvOxQ/ISFl8wnmn1fS6K52ijxMmN0jeo1HotxXT5Rgm2M7misZ+GtoXNvFU
	 ok4a7c/M2KVmf8G3RZtRl+Fvepah8jAP+s7ri/te+wiO2OD9eVajuLw8aBApfLHrvfwAc
	 BIL6ojXZyBiXQgAmjAnSfDgTXsreGf6bkAl9wRS4cI3YnCnSM7UPgyuYkp/jfPoiEzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCicCpGc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3660A5BD0;
	Tue, 27 Oct 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCicCpGc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132544;
	b=aWLU36HhAmITd8zlE+mr4l/RqPEnzY8diGtxebN7mra2ZoG74Hq7mkoFAvstw5UD087y
	 8rC4puhc2XY94LBubBnq6Bp1gTaJlb69iYa7aX+loBF/zMy5ttiDQgflDBGHTj3K/LjsQ
	 wWdD5yFwxhG/FTtYHLgqyiZfiDDrUboNl9yAdpweu1WSD4J5ahH5tDDokrD7ga34c7bCz
	 +/4xNXwp23we4PdgHKA99ZqGrBiqpYXjAUYhiuVNO/dIHlgajBrQzRYiPOBqgO/91st9v
	 xvNsH1njCN/SowuWDWv+rZYaV2S+uvm8Ri+x4VW4wTvsAVnSL/tgh+b7k/1NCQJKbfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132544;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ux8MhwtSzPGJ/JCDUkwod0yro6f7wh+bo55Ba0zrplM=;
	b=pEt8Lz9dNvWwDzIgVevAbLG6VvSVMxxM8OkTQmlPRbpk6yPCSrisaMvK4cP5V+AaIG0L
	 hzHRd7SXlFVWmPyfbglaVPu6lZ2cfuKvd0bf8ThOk7+fYb2QUym8zXR36xCsp3rxPvOw8
	 /7z2c9oe9RleA1I3SIxbXnAaYLkfakZR2RmiA2QMfuMloXE6/mDMhm8vxQJ/OgZehobWP
	 BBz88Aio4l/y4WBLfIe2izJWtIEM6IUQIBnkSViw522AwIqwv7FqR3uYO9zEqEwTTUAqU
	 FX31AwWYCh3javmI6k+E4CEB3sbakIf0fgY4V+LmFahU2F4z7M67TGVAPhp+rC5T/mw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 220551F01356;
	Tue, 27 Oct 2026 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132544;
	bh=Ux8MhwtSzPGJ/JCDUkwod0yro6f7wh+bo55Ba0zrplM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CCicCpGcduhlOxEuYHxTTOHHW5vnCh0RGxPov8oAwQpg2vlPXHmxPr0u4psBAz9Ir
	 CqEzjGiEfLINlvOzyxgs4xRgqhmd+bprvZMd23sFEcMIiDFBIeiWPPIolYaqB+RM68
	 jVNEIQyJeK8QKDbooUrVnmroOkuQu8pEKm/a7zZOPtf3qS4yfugKDZhB+qFJ1w7X99
	 e3iWmlmKIbI+vZtrV9tcb1R4rVpfTFNbhiYpqYBsR36jM+2vz+2FZO0w3LBlqRtnSg
	 LDjX2olGsHAgKAQBgpH7nhBHI8r0k3TRIyY60m3rvrfp+D1dcpTWT+OAdW0r8paqo6
	 B84dcxJmZPlxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 044AD45260;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:28 -0600
Subject: [PATCH v13 28/39] dyndbg: control-parser: treat comma as a token
 separator
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-28-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=4314;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cgmecz95nRjRH5dI+HMactKHXGj1EAXtYTNIDw+k4sE=;
 b=2YcEUNC4hgUcv7yTLzItnV8c65jkmDXC3Uk4trjELbuRmg/G5HEKtvX1Wnvv/DxNHoM/sTu/t
 YxVebA5jSOJC4ZS9TKHgpG6KNRtr26y97zMHVQ94xuF8HvkktQadt7t
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

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
index 8d9eb7dc0999..5d99c3aef5a1 100644
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
index 6d8b4784880e..d7681cdcd012 100755
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
 #K= 1489b3b72dbdfdb553cc0c6594c4face FT_classmap_inheritance.1
 #K= e11c22649735cedb6c30321378100e11 FT_classmap_inheritance.2

-- 
2.56.0


