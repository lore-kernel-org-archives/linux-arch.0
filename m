Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD14376BD9
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315527; cv=none; b=roCt/Gp00aFQF1BL9A0MpXvSrXalTGdJym/5pUjSww74mUdt71bdsJ4oy5WKGSmBSW+Z189eanRQi9KWeUSEWcZXD2QwRaUnGHLnLpd1LECH8ncGIxTaVV7mea4fp7ytWXzFniGUml6Q+7s4QIkRSHl55HmJpxloHDwLhncctAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315527; c=relaxed/simple;
	bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpQVX6VhbzKSeG6hvr8JUKnq8Vpmroab5vJqLJ1iPr7f023wABXUQG+CoMVHXras9FSf7iI8tzeRCmXpjyozFTrBFxIGKQvFNgD9yo2praL656E96TjIlHQ4HyTtUb8XybAUHX47H5HKdPc/IWVu2chydDFywhDv5qL5rhNr+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZH/IaOw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZH/IaOw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so29261185e9.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315524; x=1780920324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
        b=AZH/IaOw5BCYj5MyVGeetdPpxXjKM/sT6fhraaJr8sEqZzPu4o17YARMQ09KrXQICO
         KVYU8q/1tw2/Qo49KplhXKLieOigDS911PeCO9aSOg5WOCF3R8xtFlmS/+4lU/e2hOd0
         3m+/N5riL79mvLklrUR00WloZyEZneA0Y3J4WyP2Ff2aiitqsKYeLdzJYXvVAH1BgbSc
         RgutmJBkYyYBzYSwlLBm0b+LpG/rym9JMMWHnOX4+B5+W/MHEDICfkBwJxfJZUtAmGiP
         /Q0a6B3B8VEOcmx0BE7a7jdfv/fslqZ/OFXEJJeMZbvIAMQu4AmLA310qW79w/4ihdAh
         JGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315524; x=1780920324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
        b=T9C29V0A7X7i4KfmTpDhC6Ojjn3a70UV/a395gji+pooSXpRoY8rdA6A5zZgB0y4l0
         yGvcOw3SX//GPUrVA9AUrL1bM/K4lBqnRUY+oQ7QXyNrY1t2Bex1WMN1Xxh1qJNGiA/o
         Vch5oul8qUI662zg4f71tTX8C87wNYnqpvE/pXEs0feUoaKyB8+S86xYrtZB8Y1t42lr
         8Kf2uKFfE7f+IUF3EcbbyNDFiU54w3Pm8Ol6G+VTX41RVUYMbwhL0jN1G1S6yUe07WfJ
         T0BdCQ5YLiaw3oC0AWGrI6QtzPShpPRsomeOrW/rJggVSJJVDo4eYSA76Q9LU2xy4Gs0
         LViw==
X-Forwarded-Encrypted: i=1; AFNElJ/eVD/YPxZgwcT++dINMkihRWr/F3Szxn9eIbxsFgMztb2RqENs1kvOJBHJGUI2ZonS/Wigjb/tHRov@vger.kernel.org
X-Gm-Message-State: AOJu0YykULXguLre7YmUOXenyk2vfoeSAtPzUdUnoN3jvNRVyMQxt/7H
	1Jy88aAZav8WDiUZ5X4YwmB3ZnOdHVPSD8LBqxKvXZ7d7D4k8Wo0iNB5
X-Gm-Gg: Acq92OE6FtQVaUp4svg6S9eo/PfEwsd8heiXlk0+x5fBdiD/FFyTrMb70nhamrVbla8
	LiURZqw0WkqPQ3xQFVDcPUO9K55OHhokgxro+3dwqNr8OWPFDNWZ3HIg2ge88+uNtGAqmKnVbFM
	lm5YcytB6aPNf89uWIUAxdmVaJYOcpziIM5mu84B5CK6SGkyT8XBKc1fB9onu0d6bNlX/4u/Lqt
	cjyxp7vBBCfoA+vN3wmPXTSkI4+Wg1GFUSDG8qxP5xafFqaP5QiErDu/nAehMETq9oYy/Xj2Dpg
	kunhDILr04wo6bjfGzvBSuUNHIFsXMaT+RZcvGapYree3jC45dI24P/oyEM/BGDx10Njb6AYs6B
	wnAbvaujS6t7LpPEYLpvA1GfJzPAK72Sf9ro8IoNjkYDBYjFHs87s3lblG1BKP6D81uqpu+frLx
	S2kiMzM0AE2ADKkwv9JQqyLsdhldSGL6wMENhfSnQA1w==
X-Received: by 2002:a05:600c:64c8:b0:490:a298:acf7 with SMTP id 5b1f17b1804b1-490a298ad48mr185339785e9.17.1780315524059;
        Mon, 01 Jun 2026 05:05:24 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:56 +0000
Subject: [PATCH v3 10/24] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-10-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1309;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
 b=4n65AvgYtX7DtTVqkK1I41Xodkq0iZVSmLxfv1Y6t8k120KPHW6PpndNmLzsyHWrgFjRlxjH3
 1OE/Ktc1/TcBtwgSTMRYSIw1FJSESkUk8jXihxInLBxLSKTv4/NPkPP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports classmap coding error condition, which should be
   detected before review.
b- SHOUTING the error makes it uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

