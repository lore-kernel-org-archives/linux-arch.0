Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7A376A1C
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315507; cv=none; b=HSAt0q3DhVHZmD1aHXEarr6rDwwyxL7j6ea8fO0reDhWXjCJM/OTqYjepLLWBLLaoDIyZIWj1o9kEowzSOWkDSDPNRH3VUFSqDsXdsTHPl4F389GznS6sm6aWQjrkuF88HXvAIgqVi/PN6ZPRxxT9w2qwk7aYbhKoiHos7WaY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315507; c=relaxed/simple;
	bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gU6QhubzlkjR/W44ct16tuKTPG//sE+xj1F7i6CZBVmLLOAC5hW/70Ib9f06QXlcijsn0G36VfPxEpkf4xEdSWXJOuUuPSv/uscp0zwHtXoFTZz7k4MpRfxIueaOe+Mu+ADpcLh9EWG8XkELfxzG/aEU56oGOwYIa5uwNujmUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug+D/UHg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug+D/UHg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so29256745e9.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315504; x=1780920304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
        b=Ug+D/UHgDkpae6UeG1SlmhwEpptQyKc7cGeIbceB0m0EM20CEYKERTMtsSMTn6gbSK
         RaLM4pUqtgz+45b5FVndHeinOjGur13/IwJGzak8WCKzpTM8a+uoTUPUXp8FHjT4ceho
         87k2d+BgD2AaniUye1LTsdwCFjTwHkg1uJ1Y5RbP/tZoSqsT5VAzmrvH0XMuAm6hAoXO
         tYboE7CnCp+379XMUSg1+7sQewsHRaMNgsbS5xCuK1LQ6uBd2fEmhm3wJPgD05hZmRI/
         DaquwYy0MbVz9Kkvh+L9pueOXvVVQ2QDYP3bccsMyrLMenCy967HxbUn3JPH5Et9rgYv
         OpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315504; x=1780920304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
        b=cwqWIJ74MF/Xod2maF9na4ARsMvDNcXioM1XqDEcQrvbwXdnkF++CuUh1woBq7dOH0
         EUPoq2Ci4YDmI8khJhSVYCimZGsKuedfsVC6LDtKaYn2/RF648CPLsNd+qKpAswxN5M2
         J5ETi7DFXEgOudsHiZMVA6YDaTzKi9YWlrol9aN8Lq+Eh+td3uO73araWMj5pJx2rD3R
         sEoG7oISM1/2gzDm+ahSpY1n+NklQNomZOo+gMR/w1mVS+mjiE7qAbjnMXbMqAgU595p
         z6CdEBzFna0gaG3KqcC0nQ/DNKlXBRuWWXvYM4+kpz22YVJhSFjH7djnwEXPcRCH9jWW
         CK1g==
X-Forwarded-Encrypted: i=1; AFNElJ8x0piIEBDKDAhHPdke8zzB2iBJRZFffbd3wcr8s0hVi3jen0mbMoJDWDiN0wn3iwh2jna20UuSCHP5@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1popbSFpNy8pmDDzcPvo/QChHuh8j1iMpfaF8RI9fR8rIaVT
	WH0SN5LHJkWLZrH6KuyL0JtAHDzGPDjJtCJOh/7ymzfWDbly8S+EUvCZ
X-Gm-Gg: Acq92OFFJL69GnT3mV0r9GKOD42JskDeo5TwAc/v4N5ftEQapFC2vHBwXfLUtBcOGUc
	X+N+PKEj28u/2MRuQqEqa1+hmGqCQ54I9ZO/cvJ9glYGy9B6PelCkwYFHQHntzRvKKWkcNHkSnK
	8bztPauYFzARXeCR17uuW+SrN1935+grF37UXVPO33BnVu39TmAlAYUf0z6iYIdBveoKnOPnVq6
	nO2hJdPqIcBsNdvZS/pczoZ7++KDnFietfA67NtoI7JZD1y31LyOcweFMNAnm7S5EDee1c/pftj
	cEv+6V8skVW03KouqZhx/lCdE1m32LnYiMHR4DenaDaS4BxAWQgrhvW93dETtGCN1kHRWvlgKuK
	/q+SozSBbVswYwaZ+ySaSCXYqkoJ+znC+2Xt5ftn3QcULP2JrDh276fFAKZ/GaZUWAAEqblRDNG
	mnG/XNspV5lxjaI4sYjWEt3DEhQIpgwJcxWnSMzyrXsA==
X-Received: by 2002:a05:600c:1546:b0:490:50e4:7224 with SMTP id 5b1f17b1804b1-490a290bdf1mr200424025e9.3.1780315503641;
        Mon, 01 Jun 2026 05:05:03 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:48 +0000
Subject: [PATCH v3 02/24] docs/dyndbg: explain flags parse 1st
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-2-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1814;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
 b=77QENcw7TwO5sbOCSCb3za5Eh6W1VtMb7ffsLgiJ6qjsY20R6qLFWJ9u0VHPdNWz7TZVh1MSu
 fXZPCPflAUnCuxlFjQ2BltAWo25IThXGyLGV8vp/+SKUfZSM2Av2QvG
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4b14d9fd0300..9c2f096ed1d8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,10 +109,19 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
-keywords are:::
+Note that since the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword and value.  Flag errs will hide keyword errs::
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
+keywords are::
 
   match-spec ::= 'func' string |
 		 'file' string |

-- 
2.54.0

