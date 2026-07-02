Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0A360EF2
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010484; cv=none; b=YYbtHR2X0x4d7mQZWxdCs3yMcSyvivM2ynbINCm/eq4Q0VdSkINlDlYQjQMf5hTKV8wervmktF+Uu83pvsTdI2mWiHMG/U0fqI2bt1Go2FYhIHJvbeK5SqShn8y/Xdpb2fyTezuPZuJ59xwx1sEYKZw4035LZbLZgBzHch0hlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010484; c=relaxed/simple;
	bh=VSikVomK4BH1ns73BMbLgc83yqlpizqOwQQtNSd/MAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcKeyEcXtO7JzvO7BH+kvZQbpqPKFsZLsJOHuf0QyeKF0ROmx85OWL4JQWjik2osbEtoJXiDVmHrakvhtAlagOsvnsooOHmfdkoEOMtX8rEqoExIOw9PrMKHboOnY42/NDffgYqKIuBfWbxQMDZCPmp/65ogNAtjscY1D3ok57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oa11QN7p; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oa11QN7p"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48611ccd5aeso1059429b6e.2
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010479; x=1783615279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxiUl+/bAdRLvWtuMhB2y4s8JQp74XEt9Vmqk681vy8=;
        b=oa11QN7penuF+rkO0mdXA58/7989HC9ZMEVBlhp0I+7uEzaE3afAMSi4hJ9UNmtG9j
         8wg/5hgqMxEAthtZS6+tutZQ+Qx0pFCKV86ORTR1RcjguyC4uPpBvR5+JJPVh4J3GvU1
         0jW5SMRU9OAnOZDVIBx/klVpyZXhQmQg4syi1882EpSsBByRIKpL3gSfFPLE1K+yBfP+
         e7oi9imed0MsLIjgb+4vimrFfr8BEtSufO5v6sCcimuu34sVUTvFUKdw0AhI7wO0dAJa
         hY02ltK9bh4mMkuOlNgyFttH6kVrkAgav6FCY5qOH9ZUNO3IYsCvX7DEjuBI6W3z3MWg
         HkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010479; x=1783615279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NxiUl+/bAdRLvWtuMhB2y4s8JQp74XEt9Vmqk681vy8=;
        b=tXk1HxGSmjxsRW5G6J6zYgFKfXFSceWojhPQymBgk4Z90OeR597r4g4Fp9VP8n4JZm
         GE2yvoH9GOhNQryhHzX791r1B9CCTC2+YLHdqURgp9BZIP/CD9AEZvecpsPz6Rt7P3Sx
         mdXB8jwYUbcrriT6O18W+L+HTOBXW7EdQOC6uVjqsEA8Xi2x8UugRKSvYc9uWGtfG1RP
         36oEFz1OzgdAlBe+q7li+MjkSM4+rGq9u7MllfWEN38lAu4GM/t3Rz8YryErMxMY4vd3
         ud0mD6zsv7XkNaCgdYfAWrLADVLMTn7zrpk76F27KaSH7vtywxUv9pNs+TB7Eyfn1l34
         c8+A==
X-Forwarded-Encrypted: i=1; AFNElJ/Uatmiyxzv4Uwt8CEzV1pGusHsJvbBEAe2C3Oyjn7Ks1thxdG2gL4l6B/0FytKHza+pzQALOymVMdC@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwLBFwHkRUqLGXbqtKTqiJeKYpNvecjYm8bheWmCR6iDnx60J
	S8Q1Due5v3GN7yRBS2nV69h7Oq/GnLctdUJUCa4jzmE5JdiAoodnYKZ/
X-Gm-Gg: AfdE7clyEqdLbc+hG/c8Stx7z++JXjvwifWdxNXOVk7ig7wD7hFkFrnXGV6W80GrK4J
	IFegMDfav6Y/Py62SvQatHbWitkvp8l8mbwjR1Ts10r2fJMoFEz7DarAKVb+Ca0DaqWuq48macC
	5sfaB3NquMnS5EdkQ8IyrIX7mBqhrQCJP4dvjVT4k+BNrnFd89k99meBbtCdos+OMirKs6K82J2
	Ge+BfXtbADmXOmQaW2A5GCUhAhyE35NsrqTPKI9tGljG02eJ2g0f5O2q1k7c/BOyQ0hQ5Cdf3Vr
	lQz92M6HlkfKxRFR5qs846sucXlbwmX3gYRChTRLJWzUvSYDgCeys7qajbNhsK03+ADfbvserj3
	5rODUuT31PAntDk4mU7x6DjCBLcr/swR98SW78BP06KmMQ4PUce+4vri9/O6Bvpf2ljs9jNegZy
	DriSmyHqd5BltzrJ6E+j1nnE7Y0r2kcDAnIS/HBeFfIkX6netLgIIHVyXisTWqjA==
X-Received: by 2002:a05:6808:6559:b0:496:1009:ec5a with SMTP id 5614622812f47-4961009eecbmr3729241b6e.1.1783010479414;
        Thu, 02 Jul 2026 09:41:19 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:55 -0600
Subject: [PATCH v5 03/18] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-3-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=1363;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VSikVomK4BH1ns73BMbLgc83yqlpizqOwQQtNSd/MAc=;
 b=f0lvV79do3jHCXCXSsYbRpRtarC9mgVSKkhulER6lRcGhcvk+QN8AmvDyyE0Yrb439HzJKCM9
 5692WESkvotCUwwymrnmi79GE4b/yzm8Zs7jmAni+A9AaI16Dt2MWCi
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 577a07916072..a86e1d5845e6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1170,7 +1170,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

