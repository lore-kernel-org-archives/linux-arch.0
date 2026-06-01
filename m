Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0D3A6411
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315562; cv=none; b=u2kaNmWZz+U13l5rgLOVCR0Y2Jit6a7Mo8HdwAwUdlqLdO4yxB2otyykwmLUl//CSeNUVcsL/pd25fX5NGs1QHiwL58j02YOJz0b+fn7ghd8Gvm1SsdhWZ+odCwE7Twq3rVlpX/x7YNuXhK1hnJLF0zEfBmL9vIzz8MzUUI8/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315562; c=relaxed/simple;
	bh=h10PnN9dZij/9KIShcmtDym4aMWTMKg/65aOZIHej50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgYd4vyTitVFIz6fJE+SHWWMUA/Npfl6FJ3SFVoPMVfywRs0y/L+zEET05+tvKueu/iSTYYpKWkKq+n0+pb/qDkgTRwRsBQs+Ktm30artJWvdkahjopwaw9qjf9LwfjrHpetehE4z2TFbyKwpX0rqrd6hLW0T8RlsyU6dBeYQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7iIvUfM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7iIvUfM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a765f47aso10993315e9.1
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315558; x=1780920358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
        b=V7iIvUfMhb7SYycWP/6siol7VERg9dKBNgPg4laUom+r4Kbhz84wRvPQEVVnvtj9YI
         m2kIT31QSXKuszMcgiOKmzAFUX8iSNDHEFQT8HiUo8SyBcFTne2q5HsNq3VydGaqHOTX
         9c00nbn7JYsvDVsE2pdj6BX7oedieF4kPyA1ALfLwtjOLHXmA/Xb/zfJYPVTccKCAytC
         FiHuRyXuWCedPmh83dBDgiGBJ0FGPjflPuYNVWVw6XGXpg7Finsr8v8vGsTTolxR4cqO
         pVhnhq1wk8EWPntfCHJM3+zoAk0JShijTCPbB9rajTEJ42dtvkZjRCxZUsu7zxviHXQ1
         GbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315558; x=1780920358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
        b=D0Zh4kNjT0B020ZTgBLrDxDeQORNKz92ri01vc12GMcQ7gd0lbwtO/k1jomPW4Y2sF
         C7T6HoMnXeiJzfsre5q+N2iy0lbg7eJbTkZGZUFULH1U/mVcGsUnAIC+NpP7+ZfaifRl
         +p8YUVRGWenwu6CnHedmQym50jqt7ayyu5ydiasVjrB7GdRCoo9K8Qdu0mlFr/B35lSB
         JaflFlrSBrRltrOiK/d8Y3rUwHUj2v3Gm3XDSFIch2ILkcBDMW4xopoRKOIHMFvkcpri
         ijErdztS0uJefTVYonAmUYn5ndHUBHO54TM1iDhT5qerQaPr/9t74B4fi1oVw+KD7dpX
         XceA==
X-Forwarded-Encrypted: i=1; AFNElJ9f168G1k9EgQjVGmlKyJeO1BHyMJ5mDaZZw9YE1n6WYhM0svYBq9G2GEqakBBqY0R1zIzlJivv92GD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17pivQ4qFswX08n9okFPGsDMOCJR2eNbUFE9J6l+SPhS8MS5t
	XYM8S5QxVdg9fGwtHXSNBfLawT3aiJXdxXPDDpkM6K66xwxA6VIRb2Hv
X-Gm-Gg: Acq92OEMUnyiXgtGNpYeSUqv0pPJpLDBub8X9gSMO1wRXyy7QVqnx0xch+h+0NdN2gE
	9IqpkCNgRaJT1DT2vMmeZOOYnB/iKB6dpZ0LT0HYKbnF+eGbYNLif/fIuN3QKqLIDQ/ZggeYBx6
	CYqWoDT7800qG/6jAykqQbEoS5BqbxDJKd8Z6t5EziKc6EmtWU6bLANgCZdruPNgBLueqQqIWTW
	xpUPhqkQ6AFerjyEzxabP/Q+G6vymNrZJg4nlHUBxQk3hwkFe7SaBL7udV9Qwpza19aX7Js6qLu
	6Y8ya0oBQUTGxTj0VuUHwBhUiRMn1MT7RGF7AzkCE1GztglNbmuDoIL+15Y/dVwQLWe+b7MfIsC
	D6LghH0t+Vtp2Qh62YGHDmiqVvJ7zcp4fFfFtj+lrJpJEjsv3jjg9/OktPuHihO4j/XCGq5Afw1
	Ek8cljen79S0ONw7M5Of4sEVtMEVWWjUqOwTB5IfIYG1J+8vypkP7D
X-Received: by 2002:a7b:c3c3:0:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490a2941d7emr123128335e9.18.1780315558152;
        Mon, 01 Jun 2026 05:05:58 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:09 +0000
Subject: [PATCH v3 23/24] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-23-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=3131;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=h10PnN9dZij/9KIShcmtDym4aMWTMKg/65aOZIHej50=;
 b=7d4cXQrVbi/WeQvP8ZQuwmniE0ZO2BzoQ9gySu/7FaWMnxSGtRwVplsGXCR/85fxmr/fnL+vF
 wSHFrEsdBaeBNH4X2ZDEhDHxsO9POFKRVGtZMsRU54EYlGrkzM4lXm0
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper, and is not an expression.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2:

fix statement-expressions to return 0 (not void) like their respective fallbacks

   1. Add 0; to __dynamic_func_call_cls
   2. Add 0; to __dynamic_func_call_cls_no_desc
   3. Convert the disabled fallback of dynamic_hex_dump from do { ... } while(0) to ({ ... 0; })

move RvB after SoB
---
 include/linux/dynamic_debug.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e4a62cb73267..2d6983186f37 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -224,24 +224,26 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
 		func(&id, ##__VA_ARGS__);			\
 		__dynamic_dump_stack(id);			\
 	}							\
-} while (0)
+	0; /* match no_printk return value */			\
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {					\
 		func(__VA_ARGS__);					\
 		__dynamic_dump_stack(id);				\
 	}								\
-} while (0)
+	0; /* match no_printk return value */				\
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
@@ -321,10 +323,12 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	dev_no_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__)
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
 			 groupsize, buf, len, ascii)			\
-	do { if (0)							\
+({									\
+	if (0)								\
 		print_hex_dump(KERN_DEBUG, prefix_str, prefix_type,	\
-				rowsize, groupsize, buf, len, ascii);	\
-	} while (0)
+			       rowsize, groupsize, buf, len, ascii);	\
+	0;								\
+})
 
 #endif /* CONFIG_DYNAMIC_DEBUG || (CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE) */
 

-- 
2.54.0

