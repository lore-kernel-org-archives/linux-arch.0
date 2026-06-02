Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D203D6495
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440559; cv=none; b=Sqsq6jNWJbo8zw6bABHgUE4QAdN4/N517cS28waVtuiQuOVzZRbZL/ii2KzKpWTSpxeSNRq1C9/qdPLaXjzUvlRCFQnh7X3w0HRvnCujXtAoi1K1akQ3O+egS+/QLTNwi6t3YxbtonFeI5nbz/z19O+h60/N+d9si5L6pMPouMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440559; c=relaxed/simple;
	bh=h10PnN9dZij/9KIShcmtDym4aMWTMKg/65aOZIHej50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eizwSapFgd7UUtxuoLH6XV6/Y/xrFgcD2QoJmAHaNahUT1hZ2Fnj7gFxkDP7B0wxuNhIIvqW6z+9o4WIXpsTu5duqhaGYYFenMFVdv7C9bLo4bOA/Nj5m1YGK8aNK3j8fnywgmzqJJyf85iVPwfJvYYh2plZ+/6sQXsSvDgIV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVsUFmZo; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVsUFmZo"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4600ddc4017so2536093f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440556; x=1781045356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
        b=hVsUFmZo9NhegcRQLm4XlNHcL1hCCoseELCkAlexbymlZF2+OcJ8KQmWV+w0ZRFPxc
         ntWjw0FIf69vg73Nx5I9VXoTjQRU82RYB97ofed2vBVjK8w9hewnD7JCTYbZPAyDv2r9
         mOeYpJILzA+u+EjY5s47KUBrbLP9enwlDUWmQnGZyLYUkJnlU12GMDERuWfF++7QpI6T
         sO9h2IcqQ48WEWc6ZoRWUZzINVrOOHrhVC+nBP+/mlDfFnwzkfOxDVa7Vv6OC+HAMESf
         Bi25bMRLF1+9AaUfrD5RixkeBDtIO/+q8fH91IkHIm/mRxMwCd7FTGzG7kJ9YVgQfmkR
         0Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440556; x=1781045356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYycUh0v045JLMzHv+cDjWaRSMlpTVGG8/fmLB5h0j8=;
        b=mzrdQNylYDc3vmL0Qj9/B5fYUxO06Kfh3tVDwFKcSgiGgyI2K0HWwG/p0nHjruYBWr
         LVzXJ/3fDQLeabM/0myXnqYyrAWkj7p5Y0q0uIS7f1T2Tn4WxPVqb4k2msco4ZSOMgaG
         B3PYd14Z3JiepnVw+5SJ6zc1iSlKEifG1Wikp9PrQTOfAX4dzYXxjTxHsyiDiY/YaBe7
         FanqW8bIWf0l8UkTsBv50igzn5rpkvIC99U5tz3dRA+LI81JyhenLjIWIEo5cDJ767uq
         xyTFsQJuL2Ec0305F7KCZ91v6v/1FNlQ21aC7CwK76ynp716ed8p9MfD08/gd2pl3csZ
         TGoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Kurg5RuMw3AaZcMJib3asm9NP7FBXgCSgsmfrJRGP2Fc1SssUMaUTVpQe9aklgJ8sBXronA4FmMas@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq31TC3eVWWCK2v2Kwbydn61zLIHzU1D//qIwrpgYD8mJXCEbb
	346QRGVW1nYU4kbubytHJpqeBFst9d8De7cUZlMQHfbpeQOy5uhqepN4
X-Gm-Gg: Acq92OHpAwxKwuUH8rYuQEbB4AaQ4BjhBI3Is+YJ7CcRTEmqwoozcA1/UmiWzf1SNjX
	rOefqRgP/aEIExsZ8yuzAOWEPltyqBw7MDInSfZu+drA25WZ9LUnmK2T7nQ0kNzlk2BQfevVvDb
	0RmKJEcJMSFLr+/7FyGGNzRwW9k0YCr0JGu2x+Ss3QvX5UUAv4VL2FTUJ9Jw/i6YO1aKng7+BtW
	tqoNl5H2DVMIySSz7hm15sr6Z6MWut4trlwUDRd2i8Zk9bdrqdg723iqymN9Stx4AUX/tz8p41g
	3raWJ64hQ9xoli2cGRZ9DlzxxCBSG23gihcKpz2t4M6LoFS9gKoyfSPNdwlnquK3avlSJBcUNIW
	nLMSJr1EBOFubd6NlHEdVmOP7trCWaB1y3V7Y/56vkS4BZczuMvURF692gn9X9mxDPQbuDizV2D
	cbpmmgridG0WAE4+dfAaoV+gSERxTmabz3+/N1vXVOxg==
X-Received: by 2002:a05:6000:186:b0:45e:ce49:43d8 with SMTP id ffacd0b85a97d-460217815a2mr476777f8f.4.1780440555875;
        Tue, 02 Jun 2026 15:49:15 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:49:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:20 +0000
Subject: [PATCH v4 23/25] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-23-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=3131;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=h10PnN9dZij/9KIShcmtDym4aMWTMKg/65aOZIHej50=;
 b=nNRaRJnI6DmZfuQY2gv8wXs0tGfSMAFNC8nitrIbwD9TVpVCkTFOsGImAavGQUVyhdgdI2ALY
 opxK2UqBAt6C3hL60gGtbqcEnPcfAnMLTunbF8bSh/6ISOWnc9ixKTB
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

