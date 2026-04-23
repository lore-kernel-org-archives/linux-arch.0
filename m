Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E36346E77
	for <linux-arch@vger.kernel.org>; Thu, 23 Apr 2026 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776977661; cv=none; b=MUK3GeK7G913dzjBK4xQywKJDzbeFB0WJCE4mqEKguoavhbxutVA8ZspIjGifhbWHmwKprHsxO+MelFKq7RwY5GhB6cVqDu3lGtKQsd/3J6qANgxPAmJ+YMXgbDm/82gi41VtUwroms6Kv8NURQbE5SNaPi7bJ+ozpj3krrpF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776977661; c=relaxed/simple;
	bh=dBPobWcjtsCPloRIZNIq7WrMQXPNqrRK7ZbNyYlUKjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq/FoqSL0I+1yHFGt6cst2N17leSU7zHpI+kUEzY1tQI0CMwQcPVkrdau++pUUxEVSIXF2lKeFMtIuSIVgjn1FFWdlXuIGLKG1nzS3Xs+J+uVYukQ6rM/446d2A8PTwc//RQ2R0HFP48WKnDwjdsWP+q4Oxd7l9T3uxcXHTfWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg0UHOPU; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg0UHOPU"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463a0e14abfso3604749b6e.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Apr 2026 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776977658; x=1777582458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1peIZB1cJ4wCWYePEqyi4U4OHQkEIk0zc+fw2Nxhlo=;
        b=Fg0UHOPUqrNzgVTCaq6NLGlMykLum6UIqhj/kE8ZNtuUJTletZXBvfh51Yxu4oE32O
         qwBzERZTtZh8DZiIAq82tI5f2MQw6I1hcXEl3hspjoLC1u5v+Oh7D/ibuPLseKk1skwW
         2wCxSBitaaBS/xQM44NZjwZp9MyrEKYii4vpPEmebYvFJzahWZW6qdFnwr3wZB6L8UsQ
         5GAIgSq0dt8tHdAKvECLBjeccCBMoR7LViMhLi7S/c12DkPWYpHmbEpKj0r2hQktth6W
         xDd17MZuPJEnmg2oAEJZneNVMX0En3oUOekHayC0caKGV6cw06BNDS7eKnw0/OKHgwHf
         WWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776977658; x=1777582458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1peIZB1cJ4wCWYePEqyi4U4OHQkEIk0zc+fw2Nxhlo=;
        b=Npsd3Z9Hig0BDfVxrtjPEbo/Gd2EUiswPVndOSz3fOIdw4pLVPTRn/KlxJTplZDM+J
         +d2BVXGffQn77vAAqJ2fl9uoZ/Ef3x0dnPLppLqKBumA7clsj2T8SHgj5nSAWgf1zVwV
         5BgKhkhILRGlcHvoTAC/wYbMVtdM9ElsTPTh5KOG1QGBSGAFmMC3kW4tXEb0ec+vq/F2
         pnEKHmld1WtRVp+VL8GT+mYq3AtWbBdM7k0GWww40ADHL1F9LZHQvNnnoyvDC3GH5Eij
         HH3w7vtW/1XIwNDMHY4ATUMLd7XonhLEyCGh80QyeA+nvn8YPT+KmLFDlPAcGobohd0S
         GW5g==
X-Gm-Message-State: AOJu0YxKajaOWzIH+YSx+n68icACdX+CImyutQhTlw23bHll7qN5lxdI
	2llMzzNukZBSYGhIqjwdw7C6yPgg4hYtQNpISvi51bM5F5VOsCFXieqE
X-Gm-Gg: AeBDievTkMYQBSbTWu7Khrz8aHxjpbrgGB5eKNKS5IRnmXWzu72Y53tRtM7wkY0Ts/x
	GbcA7GPaFvKNP5E/r3H0hwhuroue5A6n4OZ/ucdkzCHYXLN6//8nOuaFd2tIB9gapgltSxr+uVl
	K62zn/Mp2JV4WZVJoxSbuYEwhcNxIQe7SwPZ3gUeQq1RHzh5PFAp3Ys/Ov8guia5lpTuGE4FPi/
	Cjsf7amD6vDzbiCtuFcyCcMNM0EM7wTzJ5NCk10no0LHJV8nBC9oQx2xAlx9rjOwFWrGRspSbSm
	LlVXMGWuOkigAC4I3Bsat2NpZrhqrWDDGbeBmEeyZaT3Qr3lGWPDAe4PbVnC70J7AGKpHk67oBJ
	WW4uFGFLECYGo9P+9M/Jg4d8anBJVEEPUZBOVCLWc5K81RaSZ714mZhVgJvYf4R7rt3eIP79x5X
	oSGgbGk7utB7VgV3GpqxZuJ+8pamCwzPgbBbQJrvziik0GgyXIEk5ZahelmSwi1Yh1ls51PD/5
X-Received: by 2002:a05:6808:80b3:b0:479:d937:c4f4 with SMTP id 5614622812f47-479d937d218mr11467409b6e.19.1776977657796;
        Thu, 23 Apr 2026 13:54:17 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4799fead505sm14329744b6e.2.2026.04.23.13.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:54:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 23 Apr 2026 14:53:44 -0600
Subject: [PATCH v14 03/92] dyndbg.lds.S: fix lost dyndbg sections in
 modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-submit-dyndbg-classmap-foundation-v14-3-2b809a8019d0@gmail.com>
References: <20260423-submit-dyndbg-classmap-foundation-v14-0-2b809a8019d0@gmail.com>
In-Reply-To: <20260423-submit-dyndbg-classmap-foundation-v14-0-2b809a8019d0@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Sean Paul <sean@poorly.run>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Paul Kocialkowski <paulk@sys-base.io>, 
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, 
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Jani Nikula <jani.nikula@intel.com>, Luca Coelho <luciano.coelho@intel.com>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, spice-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776977636; l=3738;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=dBPobWcjtsCPloRIZNIq7WrMQXPNqrRK7ZbNyYlUKjY=;
 b=Mq2FY9AhjybUNh2r2+R0eLZQJzbkYdY8eG/KkpbUCrUKuD8lbuRInjAtfOok3gY1b6jjhzeKk
 GFNhcQdx8P8CNk525EAsuvFZk9vQbFQyGNTNmtsMmoZIKphPxa+siA1
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

In an (unused) experimental variation of this series, I had trouble
with __dyndbg* sections getting lost in drm drivers.  While it didn't
happen in this series, it exposed a non-obvious weakness.  So fix it,
by following the model demonstrated in codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, with 2 macros:

DYNDBG_SECTIONS() gets the 2 BOUNDED_SECTION_BY(__yndbg*) calls from
vmlinux.lds.h DATA_DATA, which now includes the new file and calls the
new macro.

MOD_DYNDBG_SECTIONS also has the 2 BOUNDED_SECTION_BY calls, but wraps
them with output section syntax to keep them as known and separate ELF
sections in the module.ko.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 19 +++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fcb7b991776..5c75109d2ee3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9069,6 +9069,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..f95683aa16b6
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	. = ALIGN(8);						\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()                                           \
+	__dyndbg : {							\
+		BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	}								\
+	__dyndbg_classes : {						\
+		BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)	\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index acb4aadd74da..9324066aab51 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -340,6 +340,7 @@
 /*
  * .data section
  */
+#include <asm-generic/dyndbg.lds.h>
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
@@ -353,10 +354,7 @@
 	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	DYNDBG_SECTIONS()						\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 2dc4c8c3e667..027c5c286ea0 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -10,6 +10,7 @@
 #endif
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -59,6 +60,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.53.0

