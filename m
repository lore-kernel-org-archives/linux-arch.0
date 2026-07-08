Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94563B5841
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477131; cv=none; b=kkK5IhL29FDkzb4sUlbTqkquW5/+rFldt4EPipG6UOLQdiKRdSh5LL6nYLBCCRHVV6fc3cjdE0yFnRxiPdqok4EiBJQQPDjZkumM+ZTNaTxtTvCzFj2yjSx7Zcdev9X0VQP860Rz/5hITIxCVysM29dSn6vJOFZuhGCMh3ZfVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477131; c=relaxed/simple;
	bh=x84mdEzo7hGPjR/NYVWAEdiwl+S1LrXalF/kCz4ObuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqfU5926jgzILGjmji9HsHb7EFTLTC+BH4nXpk5owTv4uJZS2xNTHxacX9XfU3um48xcEHVXyQBJpZC8fULAkwRuz1HP1S6xKzjIxfl28xbLHFsvT4uNgN8lN2r88SarZrAn0Zh6iA2uj8dyIh7rItFUdHbtYy4sgsFDVLD/Cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUpGacN9; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUpGacN9"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-492046a3313so182247b6e.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477125; x=1784081925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+tWcMUoovy9fhmIt15bIV8vcOiTTbrzk0g8aDClvzU=;
        b=cUpGacN9tRsBwXrh5PqTyXtsdfHR3XRkn9/j7t3iXyZIpRIyGo11QgJCVrE6ej5bYT
         o8jPrYYyalx5CIdnTKYLG3fFooAKvqBFmCBKcmYh0rNybdrCMFtdeYMGruGtR166+81C
         BmmaQWhyjVut4xIv5ubUiwmVk4JIoNe/6aT7bxw94VW2XF3RD9bha8uzpJYP+349jzPG
         T0Y9YjDL0OhhSNKYXxSdgRvuwybDgnt0Y65+HnL1P2OopaPPw9vnlj/ylNLRGhEkbtqt
         z+8N6JGxwwhHDCL23aMySCfqPoZWcKbkpz5DjSB6HlNQxZYJsv1gJwBLiR6+Dwr13wsT
         62dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477125; x=1784081925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+tWcMUoovy9fhmIt15bIV8vcOiTTbrzk0g8aDClvzU=;
        b=U9jFwrvRdchq6dRG/kxaYS2ktUaSyeuE/W2SAIZ0fEOZpnZGzF+eOjt2PBGpvueM4x
         /Ya/fgIfSoTAwFUmXU8SiBcy2iBDDDUWm+pwMraqdjKiDRmsJDKyxJ25fhsieHGqZv+N
         eSkaA/A/c3fLqV1Kpp2jsOIXIs+wp679+lem12Nd2I7nxj+LuwXs/qLPO57gCjx7q4Yj
         yWHc3KPaAJJ6ua63hZPpFQJkvwzFRLK1K0AA7DT2ABo0kq76A3AMQpWY77x77B2ROeZY
         Z+XewW0699BzoYGfRo2vn80cxo+Z0kUmGpShUXT4E71SsZK371g5JC2Wei7TjrZdJ8V4
         iBlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6wPBoJWwwaq+IZKE/ja2VXFk8cg1smMjEqrK9cBb5z7bfjpCR9Y4n1lhj4HGfiP9mV1HxM3VHzRCl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eqOteekYSApyI8C7WXH0p7CbRgQ3Cd8o8vJsr4/jING7eEWe
	PYU/E+wCFG2HrjVyFSLKGZW2LgPk3tVWLKobkmv1rSaWQFN6T1871zsR
X-Gm-Gg: AfdE7cneNgWZ0KrGUtWtZPD4e8xCGLgEi8NyYRcngJlacFZAW9EJ7TnjxGWN/zgEE04
	z2+S4bstsIiqz0rVRVZfInTmjcdleUxvnSo/SdD0jWTLtx4If3r1Dw9ppL+NGeGY+5fsaR2Y8Kn
	DbS5xbGGocyqMm6CUeZA30yOdOvUMlnaA7F5KI5FzFUijYLgWQrc70zfvxtKNoqhxSZsREdzYTd
	+/DvG5B07iIJTQSm5pniqPsz3Kh9OCiYJI2Z2iptisdPpjhKtvcX2ejJXAwLpRh154frlUEhYFf
	esMSESzQIP5p5g5dy4kimwStAffM+jAYOluX+2knnWz3qULT3pLZHqe+CowFETKd8kg6cdINxhp
	5jg2Y5dIFR2xZF/vMdpZ+CoWQhwUl8LIXSy7LMG2G3lH2Xv7INXp8YUYOF6bByC5Ewou8we2tPc
	PU0BdIEyykX/kamq+McpGgf2xxo/o9Y2y1yI1frescX2npKoQYQ2E=
X-Received: by 2002:a05:6808:c3e9:b0:49b:dcb8:e2b5 with SMTP id 5614622812f47-4a2031a6787mr416421b6e.19.1783477124787;
        Tue, 07 Jul 2026 19:18:44 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:11 -0600
Subject: [PATCH v6 11/24] dyndbg: bump num-tokens in a query-cmd from 9 to
 15
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-11-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=798;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=x84mdEzo7hGPjR/NYVWAEdiwl+S1LrXalF/kCz4ObuI=;
 b=TVncpAifs+aOm9EOV2um20M9XK9Z1sHPPRKEV6GBYmmZOlkbuXaoVE3Tmhtle2n/KiIbg4PGk
 /LU+iPNi0+RChSjgg5OL9l/UjA4Som2XihR5K5pxfUf7olt/oz10Exq
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Current MAXWORDS in ddebug_exec_query() is too small to accept a legal
query-command using all 6 keywords.  We *need* 13, but this adds a few
extra to allow certain errors to fail on subsequent, more meaningful
grammar checks.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cd6b6c710ee2..efe12fac6363 100644
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
 

-- 
2.55.0

