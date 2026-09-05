Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5354F30F5;
	Sat,  5 Sep 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632020; cv=none; b=W6r02Bu+a5t13PliBhqsJ6Xhl9acA3PggCvaR7BLbZHxVAhD+pkEyHU6whbDZZHXO9x/F1a4Tkk/6MOIcGeEmGFZ7BEhDFtxidTPOP6k8XmLDQnQWfryAvPN0HjEyG2OEr51W6NG7EZweGyhr7kWv5aKzdE2bWoWpxQUPWSKEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632020; c=relaxed/simple;
	bh=cSzWEvlWkFl1EhRLbh2nTDcwh9/y/wGSjkR9zhXmI7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEzWiaXf08YzzFuGDWmHv5fBxqqijYHjDmZv/29uMjWFNTNiGwRMKpXS8rMQjlKQo316oUdMmXkoVJUFZqpTFoAes9lGQPieIrInWPILhBaesc6XX3uScGvDsdjqt36Ib/quabtCXVnbz3+Ill6yhSwq9AsK9J4277jsa8D9T7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ3yAaN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ3yAaN6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 809F5C4AF09;
	Sat,  5 Sep 2026 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632020;
	bh=cSzWEvlWkFl1EhRLbh2nTDcwh9/y/wGSjkR9zhXmI7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LJ3yAaN62UtUtHRUXBzigBSv9VmeV7kbkepltFYdZD7tNeBGvdIUXtfM7Y8cTIsqc
	 HyBP9+BbCYzl0UmOwpRNDMOouZvJJObJpDPnM8SXVfGh5IGjakxdFM88kijP9pARPz
	 CmF+IbV/NhNPQEt/m0953jTtppweahtOsNO5wRTCNm0qvuo6H6jdCC+x3q4srzS1GE
	 JSk5Oezc2pTLE3QwpmUt9jH5z2+E5JOZyKC6mS3P2AENJCaDVs2gMpHpxeo/6eYT1h
	 vCpk3awiYgR/iq9ErslM0tG3rgNJT4LSr0x/ivgvIQiMTJq541Fhwsw9QPcPJVhiFI
	 O6WnShZ2NA+5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1C6C79F8B;
	Sat,  5 Sep 2026 18:13:40 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:29 -0600
Subject: [PATCH v8 15/43] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-15-a4cc0674f6fd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=798;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xc1sbCIxH3TdX+XYADm+7tSzKLUHMtwopv2nMaWAymw=;
 b=tkeDx3R3ZpxP7HZgR5Us5iK49pjlktX7qCdRdZjVvMA/3QBCU/HxIaVhZCsG9Bxu5b0Qy3ANj
 UMMiz0uSqVdD1dOtzbNZSprTfXzRHj/YZmrQQ3ipqCNH5Un/UTwRlxN
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
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb768157db08..122c2c9a1254 100644
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
 

-- 
2.55.0


