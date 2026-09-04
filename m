Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427A47D459
	for <linux-arch@vger.kernel.org>; Fri,  4 Sep 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519151; cv=none; b=dNkDMn3Av6fzQYAbcnZ3oujFXo2XkoPC4mGDLQgL1g9rbh47Omk3NFm9EENuS1U+Fv96XFEN84RgRfT5hx0GagXEJswWR4ULLcefb6CR+TSeWInXwj3nZSKpDSNmzsMluIAEaFpmqfA7LEagrJajeHxBgG+xT+kKgrXD6X6ylno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519151; c=relaxed/simple;
	bh=TkP9NVlRtH6a1u5s1YIH64kNgYTDYNLipbIUxbHPiKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5tlItXODbiMvbz+Q2a7Gx0+o1cwUzIlZJRn+PT+q2B/Odaf94+mUh3F/QRJPW5x9KQB/MI2nk+PWITXgFGUFHjLyZLS1uGFfh0TwLYwNzeMa6PAJJGGgYWNALVKhUzrd4/tPL68NKet+v3UEZhsNU8QCFUCElLDnDupg623WVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA5JsUKg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA5JsUKg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so8459765ad.2
        for <linux-arch@vger.kernel.org>; Fri, 04 Sep 2026 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519147; x=1789123947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YvcHUhTtrCQFG9nBcp7L5Dsm79MezpWqR9sHFriF3SE=;
        b=jA5JsUKg+ukvOfkCnR4jb0iSfi9yOOwqEZbHulliNVmbiU9t6JaUgKN8rVPUcYsoEy
         MkpJlm5Uf2VpgMe2OmHcqwR56RXeSOb8npX5v9t2FlRT3jNv7v6CftVgGKhmGnkIly0V
         /Om2kKGPE38IFKY7uFerGHkLQ6fPPHLxWzZ+7GtJn3k9tTRMSRm2IXQc7GlFsyuT/b9x
         ooMWWwg1SV+uErANOMytIRgps+wQS7MuXz6+z8bK7a5vg+zLL765ZHv164Ym33uihgor
         /4dIm47r5aoFS0v5HEf1yfAKkOt6XKOT1VBLOEQB6GnFfF8AOCtQjrnSxrawvsOjaWGn
         j8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519147; x=1789123947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvcHUhTtrCQFG9nBcp7L5Dsm79MezpWqR9sHFriF3SE=;
        b=Nzsktff8tkkc9fEkofpu3qQ8bkLocaLcJX3EXl4GB5eqAnu2YVmbQSlYnGaqkSTtbs
         HSPrjPFgcVqIdWy2UUnjYc+jzxem8lP1XPbZBYtBAgvClxsKS6A66Gp/e1L0D/3eNwm7
         aRpowgU+Uai3ehf6dudIoBtpsoOE60kGDw4KwdL/ge3UWt8sBbMwK2PXTtp/jrW0Myyx
         qFNdBsHacUvA7dCtCJ18CxzLZ8UvcF5U9jp899ANQLS2WrcPHvSt5dlUVtFXxtd3bKr4
         INqi73+uqfW2NaupNShhiNcOUwMylO4EtU1MLINl6bTG0M+iL9iVI3vvgcwgeFcBnbRT
         N1Qw==
X-Forwarded-Encrypted: i=1; AKwUvByQ7agRlncpqa/yjpIrgMi8E+s6aNC/wI+z0rwL5hf3c4Rp6vheeD8GrrqwEphpG2hpnxisdirgx+d6@vger.kernel.org
X-Gm-Message-State: AFuF++nEK5PtjYL+rXj8LoYDLr6g4fyoFSooyZeHXEh1OOQvaW66Hgp3
	zIXIdSI3hGOGN736rwmeUbgI9nVhVccREOVJnO5cbSkjRKV/LtUTH+Qf
X-Gm-Gg: AYBFou3rw01iH5OYVGOl1dP119ZglG/TdRrWpF+KZE9xEeYEPfaQ/cVof+qNax0hMsu
	8XmYmDbKzg7FJyOdb4OoaHGWE35cvinXDzqZqPT0ln+rqKnroVPla/YA5uMD+0Fv/TBw83Ia34T
	8hOovbabmTCfEd8BFR7KWBzdYUFPy5U/XZlSy7SGZzJ4Vrc07vYjUUnHTniXts5n993ErCIE1od
	9PISCWJJHlRddRSvEKWFWVyw9jNmSXijASYc7QuZKwZvqV1klfx1hRjPJ9Ui5HrzATIz/u6YnIx
	nqSxDM0DZmJTjY2pQ3d4xxjWfgdjkfMczVnWSs7qSMuEJO07XphtV2H9Xyj4jmmdzOLRnv4c9lW
	M3/4BjjmKbOs3b/GV8lL3HZ4Va4jFydgt8u63QacjbYohQ6haHm5qM0EWbIZly+DbgkLVhnFoQ6
	i12gV+EWc5ny5BqHJOr4FgPiL7FoJeCoS0ITolNGHE8Qv5Qq54u8sPOMP0rxW0WGeCerajTMA0z
	VO7IX1hGeTX7Ls=
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39b2624f0f4mr7940585a91.23.1788519147247;
        Fri, 04 Sep 2026 03:52:27 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm5924343eec.13.2026.09.04.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:52:25 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic: fix repeated word 'the' in comment
Date: Fri,  4 Sep 2026 16:22:20 +0530
Message-ID: <20260904105221.31836-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'the', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 883cfd7de2ef..f901ad3e6a7e 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -153,7 +153,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
-- 
2.48.1

