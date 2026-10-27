Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132540;
	b=uw8dzmsSBvwv16N6CzYctMkFXbkbB0W2XpPXlJ/Fkg+Pb1lW5JP7WARf9TLd+x18sjT5
	 cjD+iENdmcro/ihETjRFHMhYHXaZxbdBLQNbIW5DfMbm+OO8aG+PjWzXLrrhYHAtYC5Zy
	 7S6/glGrGzJ5XEY4YpNYuuII8X5LcVmOpDTeQeM0+lLY+TpQ9OY6si7l0Yc4xA+CMGORx
	 n2Dbj9Xm+SPXk+qIWd4ubigPXwzoM5TF1sv9y5mXwko/fW5wFXban9ewbpoRpCORzjOIi
	 NYQZEEEcFobWvMjzU84JHW5r0OYiI7GLtSwIa0GyS+sHndVD2nrbQ3aADzEuvKQivWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132540;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SiRDDQbSFKecHeqs5M4sWJpuVW3XhZpV6pnWJJyKwXU=;
	b=5EmLUmHissx81uAcLf/CIImkRvT5CcTRdfNR8koaVCqpAJPZsDRig2gMFXewcn4JY+0m
	 BR3H2eSP5/EKqSM40+Y7Ogx1x6+lkhGEZLjsqwgA0SefNSTpcxHQ9pDWyFGkaqTm7osHn
	 YGBqBttpRNPJaWmPF2SY5IyuNZWOZc8hzImvH3LrrVjMI74Cz20FqmLWseMHT8/gLZes/
	 9z+2JwPz4umJ4Beb7Ah0B6/ksebeeS7Sm+urz7WR5zoXa8SQ3cnWcN+qJDlKnf7sxqi2e
	 4bYYifIoo1dLz7jD0KaoGDCSfG5JLcJpedwKLLyntqPVYjThAwMDUC0Kzt9CmPpSE8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/dqxJuX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8D60A382D;
	Tue, 27 Oct 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/dqxJuX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132540;
	b=H4Mx0EicxVfnkCHKzlSIXp9tWQnrddkPW6pwS3SmbfedWVYYsJa4bEoS20C85DyTPe65
	 siAHBTmg2Br0p+ongRMB0nnctVUykZM3z8T/CpxT0mZpJqC/eeWmglWgGkZC+NKTsmBZJ
	 btcqvtf/zMpUomQ0MNIjRi1zFKbLHKVijwEnAYfvvAjN2s03b1ljMx4cPV7H6hLyXkWF6
	 q3cDxPSjeuNULVv4RkO9nb/LeNtJkI/Jy3N+T7S0CTN1dGekqTKT+lq06VsL2HCU1c8l1
	 LucP0sAl2SU8BIrrghQFFApsoWLdwO0B0sMO0Y4R65TpFrnWBsTHB6SjKBZScEpeNKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132540;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SiRDDQbSFKecHeqs5M4sWJpuVW3XhZpV6pnWJJyKwXU=;
	b=tw6lDsWSzrbzZhBMxhiZjl/sT6EoiuE6Vul6/4MtJL8c3SRzbfkNVMUXdd8/MsMWxtl/
	 MzmhN/sJZagYdr89oljYUb9O744+SQCW7Phz0F+JFEx9KivoS6Ue3zUeG6NpSRQXBQlB4
	 ZesKGQhO0BIBqhZjsENtJvBfTLFf+1NpEjLCT5o3/GnpGi5MSViRfBbOtyKV+6h3rmGmU
	 kQ6xtgLTEq7B+iP9v6Gdm2Fow/BYP1kzdnkDAa38QbhXJPk2LOa1VduX4d7N2V8dtpl0+
	 dcU94VxUTl1Y4SWErWuEot5CpOiHwJqynl4WGb/Ltklbkx5c9OE6PwrXyTYfvxa/zpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 58AD61F031E7;
	Tue, 27 Oct 2026 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132539;
	bh=SiRDDQbSFKecHeqs5M4sWJpuVW3XhZpV6pnWJJyKwXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h/dqxJuXfpgrNLE5nq2ZW+9RH9/nDZIfPwJMsafeAVVCTuo5TLikoiJt1tS0gvIvQ
	 UsLJzahUyyfrVntYsXzsnR/47BAKWW27nRPOGAis/t7OyjcQ9j0rW4tvbEOSD/QGCB
	 W8aR8mFZc5Fw+BgJJEMToz4iyYiUW96V1UWRuQ1bv1xKVi0vPkM9l2qjkxK5KnPUUi
	 sNonpyxvPLwQhf+Q0ryE7fu2oHBXTSRf97Ku4HwdplTDtfTFiTOxVYIopKRAQYMohf
	 AHHDYEvYnVIp2ttAvyzgIu9C+Dq74ZyjfmQT+uIwpZFflR0TdK/3Goq6GPiXnmiZBz
	 o5c1d53k9fOlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 28C2745221;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:12 -0600
Subject: [PATCH v13 12/39] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-12-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=3086;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=2qWyi6+YSKFFZjxBlAqzRhGNiwVTqFgEdchNvFaIvH0=;
 b=BC2GesekFZXLHrTHTPw1Y6gMtxIIayR435lkYJPtxWrjcCGVKmhB/ROJB49r8wTCFCv8e4WUw
 PwWcdo+OZ0RAOrpgFsJpRCLCr3Y5di5G0b6qimpQfGUcdK/SklT48H2
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

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
index a39144fd7c8c..a0723343e2a7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -558,7 +558,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index c1475c755542..5e52d957e2fd 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -320,8 +320,8 @@ function GOLDEN_RECORDS {
 #K= b9a397e807148d13ba07da7db7e69817 FT_grammar_errs.2
 #K= 5abefa504937a329f974504f1896e368 FT_grammar_errs.3
 #K= 1d94d0f239bf40bf51280caeab499de0 FT_grammar_errs.4
-#K= 135035c8a17ae100cc4ec954c4d75b2f FT_grammar_errs.5
-#K= a9cc14244f91a12d3174ad1314144a8e FT_grammar_errs.6
+#K= 9a5e1c1856f1ebbe57a4afdfc4c9703a FT_grammar_errs.5
+#K= b3809a6f9f643f049f1ef30827d4b001 FT_grammar_errs.6
 #K= 5d400aad1a7d71f548b6b81274d00a55 FT_grammar_errs.7
 #K= 61cd359b10f9051862d3745eda07a295 FT_grammar_errs.8
 #K= 567379f4f4d099f00f37d1469d9370bd FT_grammar_errs.9
@@ -340,8 +340,8 @@ function GOLDEN_RECORDS {
 #K= 1f6fedfe222af475211b3bfc6d08bc63 FT_grammar_errs.22
 #K= c67dfeca97697b707acdd70672816dff FT_grammar_errs.23
 #K= 9574dbfdac063409b41a44e6251fbcd9 FT_grammar_errs.24
-#K= 644b81753949ac1285e38ac995eeba46 FT_grammar_errs.25
-#K= 1bf2a93a39961f40e0c2dd4c5e2edc6d FT_grammar_errs.26
+#K= 3c694a0ee2cf3a1d39f2ca8a9f3b9094 FT_grammar_errs.25
+#K= c23be05426c8727be833ff055944aa96 FT_grammar_errs.26
 #K= cdddf4ffd7fde3c12eb0c73770b872bf FT_grammar_errs.27
 #K= cdf7a2e2740ec007efbd29feda478420 FT_grammar_errs.28
 #K= f6650d69963cef433c50e1f2acb899fc FT_grammar_errs.29
@@ -360,8 +360,8 @@ function GOLDEN_RECORDS {
 #K= 1a402ada248d0d50cec13a1af150ea33 FT_grammar_errs.42
 #K= 5b46a8eb0d74009462f74cf7553e3228 FT_grammar_errs.43
 #K= 546e440044828d86135dd63f1eb9ed17 FT_grammar_errs.44
-#K= 644b81753949ac1285e38ac995eeba46 FT_grammar_errs.45
-#K= 1bf2a93a39961f40e0c2dd4c5e2edc6d FT_grammar_errs.46
+#K= 3c694a0ee2cf3a1d39f2ca8a9f3b9094 FT_grammar_errs.45
+#K= 37b7ab754e579683a28ce086c470cdc9 FT_grammar_errs.46
 #K= 3e3acfb800cfb1bcb0cc07f33b75830a FT_grammar_errs.47
 #K= 42dc6cb4fe938bb82b64c82924ef28d8 FT_grammar_errs.48
 #K= cf9320d2188f5b48d508d610d95298b2 FT_grammar_errs.49

-- 
2.56.0


