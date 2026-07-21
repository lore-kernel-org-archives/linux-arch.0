Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF946EF76
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667455; cv=none; b=c8QODflIN6HGdhDRo3zFrbzG98a2P1w0Al5xm0XweryWP8e0B1d7NbLmTjMORHMBL0hpiIEA2tixSMF9Fr7Jmn6LlUOZLiGsPaMWIsO4McpxJ87vv24BCtaNuqb4rWuHESiTuNzZ7ryXx0256sIFGSEI8NdTJiK+w3KjlPJRVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667455; c=relaxed/simple;
	bh=6i3xu7TGf/l+LjxFU5g9BihOmy63xII6Mxtw0wZfUyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2fl/NgNBFEx4+y8Pf2rF0XvH1KavmPxSNuQUpTxJKRO121oNwk0wrukJfG+SkB/9fMgvEFzcfDr9e7o1jW5uZ9NOT9XhvyGzLXCxuLitNe3+ixgXJgacQ4jnNqpaRM56FXU3fQL+uB6RFCpCPtLD8QDnY5qW8zI8sa3swyWp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnB3xR/i; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnB3xR/i"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb4d532e65so4555466a34.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667451; x=1785272251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ms7C+eWti+wagZhNEkRwI8Uzix1GmNY3wP1QgPskNJg=;
        b=GnB3xR/i4PVP+e62skV0PG3g5SzDze57Mj37d4bqV7vCMJFOgkCaHKwtTgVkTWOPP1
         ArbUlQPRxsl07/Ar/iSAMg3HtcBI35M7/8kFky0zSHPK80Lz8QGRvPepDiCLFNBPhsxy
         KBsNbzQy+A9roXZ6snd6tzf2dITYnTw7orGhaTzjJ3PGWnqj8kQP5weg40q2KmDSTcah
         Ab/04+7XYG19ec8nBf0vj4uDNKv9zItu1HkONd4wfjDibNDZpdyzYNBW6w1jk19Ly+JJ
         Vvjy7BeA33jgm6a8I31lEdi0PJMAK9W7q/Ew9+9Nrl5RYscQtdPYqepCeTFugO31MfWG
         ZLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667451; x=1785272251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ms7C+eWti+wagZhNEkRwI8Uzix1GmNY3wP1QgPskNJg=;
        b=NqioioEHwhfVqvRVzPfw50zc/ddD7loJVqfC+pnntSLJVhooxNVnMNRKh41oXpNq+W
         eV7YgCNNlMpmufhO3jS7HwroxMh9JXf0n+QKBwlkSoP63HsKtdwNej+fg1BURCdoloJN
         FOQju4t3HmmDMcitAvJfg1Q2WUcAlk312HB1K//lmXSPoYXsLfhUgTPBmi2ARzjOJhJ7
         nj0b1XZjlxqo6sNqPP3AHedUGzKBsETVKn3bdnadcyxeg5Yghle2PIfDTYu+hbIAtGSq
         5LWeLHFZi2cUsPTmsLB8YnF8lAtWNdCskReUyHuDlE/23oMJ4kLJzpY64Afn0jyMVWR0
         ggrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqckVSzQPmqZJt+W+XJ1qRN/Is+BctN3sfb75kPQKhDGh+qaRryGK1qhasoW6EUqZXXjMHFesW0khi8@vger.kernel.org
X-Gm-Message-State: AOJu0YwONyqop/EeTdRHfTZl4ipc3sn5zT5BDMHhI050NhcdO7jqIw5+
	iqN0hN8q7bsM8tE0hSKEPsFz1rgaoinYc9QMQdYrUU47hSTMWtTGfxKL
X-Gm-Gg: AfdE7cmZCYPmu6rMEKJ746x+t2v+LuVY88P4gxX2Ty2ud0sSW0onhPJOEFW+n/eooGu
	EvIqqWvDX2itSKtO6gvmywMEqKyKjy9Kq/vkTMzSl7EhKcuinQEUg7mXD1iah9wfgv+8cGwQ6vX
	Ap/thslENRxdoJeNhimL6MxXEpk1R0oKmaaIBn24Fid30mT7SVntPrT+js2OlVhSzAVqWii5Vdm
	3ojg/SxTEg8TrNFq/0H0BVIu6KA+bAgH87MjWcWe5sWdxTpcP+e5q4Wm25B5AoOzlULco9b8fBA
	6UQP2wuCoNf3JGduHr5DhSBrDOe4jfnyLXGq7V2ArNbaob187XxAnd2KaeoBfQ6xleOMF0h8d5p
	u6DdzWUkwc/u9bEI4vpGAofDbWxPSX0jEwVxOwwP0rt1NH90k5BnvBv1elijmfEwmlDGz0xKcLu
	vlwPShmdbImNra9SjuCDhhVqDBv8GLv6wdEObd48sp/AD9dC3jRkjCraqVOZ1wDEjcsAz+N0CIz
	2fc9avFlfxU9idn/vTjaRJ+UQ==
X-Received: by 2002:a05:6830:43a8:b0:7dc:d587:af3 with SMTP id 46e09a7af769-7eda158f774mr9794437a34.23.1784667450860;
        Tue, 21 Jul 2026 13:57:30 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:05 -0600
Subject: [PATCH v7 16/29] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-16-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=3864;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=6i3xu7TGf/l+LjxFU5g9BihOmy63xII6Mxtw0wZfUyA=;
 b=rrY68kaycmSv/O2ivnyGlkD3uJGH6AZVeLYuyELeeYJdg2EmI+foqlpHKttQkWD3HU0wNrpYG
 KW4shc8BnIYCnCqo4ySQXCoaLJen0G2zNNIIQs6TJqElv+ivJlUYTrR
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c                                      |  2 +-
 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9bd6b87f5609..2fa034177268 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -554,7 +554,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
-#define MAXWORDS 9
+#define MAXWORDS 15
 	int nwords, nfound;
 	char *words[MAXWORDS];
 
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 1dafeaabc976..446455683df4 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -649,8 +649,8 @@ function GOLDEN_RECORDS {
 #K= 9c405e06fcea50284df82d1ae9692403 FT_grammar_errs.2        dmesg
 #K= 0b0d9b0e6f4c45c7d75d699fd3b6aa93 FT_grammar_errs.3        dmesg
 #K= e008644e159c2a9d99a8d0806c06e71e FT_grammar_errs.4        dmesg
-#K= 11833e6cf8fe8b03869aa4f669b63398 FT_grammar_errs.5        dmesg
-#K= e85a4b665f5ef141e3f4d4505dec1da1 FT_grammar_errs.6        dmesg
+#K= 5750ed178633f9a68623f928c093d16e FT_grammar_errs.5        dmesg
+#K= 2cd51e5e3c3e2501544524bed0fab620 FT_grammar_errs.6        dmesg
 #K= 3e1eba65bd936e1276c7e1d76b399595 FT_grammar_errs.7        dmesg
 #K= e3ac86676e309d4e72ff3da287736c29 FT_grammar_errs.8        dmesg
 #K= 466d325c23519119f754fa7860bae7c6 FT_grammar_errs.9        dmesg
@@ -663,8 +663,8 @@ function GOLDEN_RECORDS {
 #K= bd8d9cf661c9aca54dac93c74cfc1501 FT_grammar_errs.16       dmesg
 #K= e991391048f2fdffaaed99ba36b787ed FT_grammar_errs.17       dmesg
 #K= 82d99278f471ebfbf47eeb19898525cf FT_grammar_errs.18       dmesg
-#K= 3c8d268c94b0bf97e64999654cd840c4 FT_grammar_errs.19       dmesg
-#K= 1a448ff3f1df9155cc3acf1e124f24f5 FT_grammar_errs.20       dmesg
+#K= f3f088fa7d276981bf2898c048087f76 FT_grammar_errs.19       dmesg
+#K= 984ecc198e0fa9fc91bc31caf7da2a5d FT_grammar_errs.20       dmesg
 #K= 76c8a33c585d414fcc3f1c8b5ea5b4b3 FT_grammar_errs.21       dmesg
 #K= 90cfc66e9d61f5c448353b97baa99145 FT_grammar_errs.22       dmesg
 #K= 37a51dfd6e84cb64b69d3a0e23e68ceb FT_grammar_errs.23       dmesg
@@ -677,8 +677,8 @@ function GOLDEN_RECORDS {
 #K= 2e37642dc8aee3d04b8a54a76b3b891c FT_grammar_errs.30       dmesg
 #K= 593c8b4c41932e3bde564a0008627ced FT_grammar_errs.31       dmesg
 #K= 85a2a0bee8d0cd10f883aa5477d62efb FT_grammar_errs.32       dmesg
-#K= 3c8d268c94b0bf97e64999654cd840c4 FT_grammar_errs.33       dmesg
-#K= 1a448ff3f1df9155cc3acf1e124f24f5 FT_grammar_errs.34       dmesg
+#K= f3f088fa7d276981bf2898c048087f76 FT_grammar_errs.33       dmesg
+#K= 629f6a7e379e02f38c543cdb48e3b84f FT_grammar_errs.34       dmesg
 #K= d9f0cffb0898c54690735a71b0d4f3bf FT_grammar_errs.35       dmesg
 #K= 4cf728b6a32043ea5336a14d0c435312 FT_grammar_errs.36       dmesg
 #K= a11ae3f86f4e5f539fd6168d318f74b4 FT_grammar_errs.37       dmesg
@@ -693,8 +693,6 @@ function GOLDEN_RECORDS {
 #K= 551f9801b6008553661453021ae6dfd3 FT_basic_queries.4       "kernel/params.c"
 #K= 33f7162ac85020894fab9752ef07b89c FT_basic_queries.5       "kernel/params.c"
 #K= 544d955c3bb9d3c78704f780d91396e0 FT_basic_queries.6       "kernel/params.c"
-
-
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.55.0

