Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909E33F36D
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520501; cv=none; b=OBsjmpHejxn68HCurCl7dz7w6EDDpHiiLV0279K7D/ivBd7zkRK92vGWq575nvYB5EoNEkn+B4B246AAub7PiBErLdbyfPCM/p4/fOBZP6d/7reOsU7E3cp73nY1YbP0RYAEpn4HGD8P9nzAPuIjKvPrL9ChiuyPOMNWr7vxTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520501; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIkA1TfE7qOFXtr+PxMv5XURCx5seaGUKNCgnPFxDyJvFp6HLnxjCnAbKXpMfktVO9/fuFkD0goskt66CLaQcesA67dT7OWkV966Reogezflnjr8PO4aHA4Ks9CuPtpre9tggVSk/oJ6ydeRtEDdBTzkmGNub2CvsMX+ctZCt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1n9gbVQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1n9gbVQ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49050bfe053so3774065e9.3
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520496; x=1780125296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=H1n9gbVQ+PcR7fWPkOtzIrEwQ1rCF7DjxFYd5P0XECMz2WMW9N4Au5Ov859TzBQlK7
         IpZ/Ove0C++0990zu0S2fTNAZHVx5hTyIijZc17oaRTGseT7DBVerY6D99v4jICXpr6+
         pE5b6YmizttpJmiaua3GJngkEBJFzLIK3rBhnOeYumTUSk/6n5BNSkLlWmavh/i3H2KV
         jljF9YvKVU4QxDGenryZpD/GNzC0es012x3J2+wbjrI+ECAwqMkHlF8iiSDT92ROJeAL
         x4Vx+ANvPj9kxbEvrPg2XELJJc9DbXjxZ6Ij4ChcYAOXkrsqkQL+bDZJ20lUARu/JPE4
         C7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520496; x=1780125296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=DTiDQVDiVGIFuYhiKpeqfybmEVpFtBrWPAQlvmTI/+LpcfvzvCsxkLrPI2iIzaYHry
         VeQ4f+Zx2GLVafKPa6iBUYfFq1ZQ9dl/0rI2QjB1nOmdGOwWbcFTJwp8fGQH+GrI8H5V
         lfktnpQKYuEKBEpbfpEiuHdqFZwWsuVpGCsnbB1Q0hGVQqBhRaOydHfkRk+XfsOsD+LG
         VsgoHSL67+WwhSle9TYtmM7+HnAbgQLwpseleu7f0tsurIh/u64HUdTcQEsUKG8g/DWd
         GWKBmJ+339IfcoBlXuJa1uHbUBHTT6vmEPTQ30pt/Ol+Rmjj0yoNF7oPMUatNvI2wR1W
         MJ8w==
X-Forwarded-Encrypted: i=1; AFNElJ/BBP03IYQJs+XgtZa3sVFr2p6O1aSuYoNxN0XSE5rZRI5MXNE6bv4MF0fcMtwWIeTa+6Qx0pv0/6s8@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTKV9YdyoXK/Gv8o6/zHA/Li9awHxw/Bo4KR3vQOnvlQU/Y7a
	Xp8KQZ4AzM5L8RuAYFAeFTrcLt48tjiQAkGSO+A1VwhG3uckFah4Pvjh
X-Gm-Gg: Acq92OEA8SPZFcyB+E1+FlNi31G8r5hZM5gpfoDoP2E+/FiqWaXJDiunmSAjERwdhsh
	C3uyZAr+3qbNRmNoVQMJ8vffMe5FuJHQNcJTlUCg6bhh0VEZ00gBKCQ6YzHMlGvMegBMyYj/lkz
	fAyONtS/Xyo1xLtiZAqLv0csgofvXIvcOpEZB3vjmkKdJLTbA734PvlFq36JSTgTZtwq4x/fZOA
	34J80xJo7LhnK+z0s4BMKQBtZrURnD4yinvxWKzjmnzfOcy1qbAHFxRtpvj438p0c5pJ+GwQZy5
	WqcWyO4ktrhTvZysy4mJwQtaAgRCUqvRWfo0+o5Wy5P+/ue/MoGXiewoSOook9VvZyX8Us6i+Iu
	y2uVYf4PiLxmRApIJjPPbUrgNhmILgUUAI81Pj4Lku6ZGvO4I581hTRc6jZTNtKW4A4cQJzKSRK
	zROzBTNJ1zNB5oJtb5e/aurCRI4QlciGjncjP3mrQ=
X-Received: by 2002:a05:600c:34d5:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-49052c07701mr17075745e9.20.1779520496290;
        Sat, 23 May 2026 00:14:56 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:14:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:37 -0600
Subject: [PATCH v2 04/24] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-4-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=wXPve83EQqKwVYpNzugGXIZFVwTl7ZjlKozjC+ofq5HGuSZxa2pPjv2RM993nzrcpf2HgOQXe
 tD3CZakg70vDthyomfMbN9iNNuTYkFwz6pne0FZR6D1P0oeAnYeN0pf
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

