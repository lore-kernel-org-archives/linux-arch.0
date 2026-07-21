Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF943990E
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667440; cv=none; b=To8J/BKqJ+lKq+u83alQTUmQRiCwLakZ5RwEDNd0DUzjhNuMkIipF0aeI8Ozjk78Mc4CUFF8imfxdyJwDgT9gNnsDls1GBAKqc5TrUsFHUz87fe2yn49IeHMG6Z1+LwceuweuseTXsN1S0YNU/fowLHW5zDJUF2UNPzLYJY73iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667440; c=relaxed/simple;
	bh=es+00dI5lNkwt/sa4qLfcgHP71hLrTUzt4kFdW0j2uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0dRawbIxWUEUbpo1K2VTRngWcU8AWEQqk7VHEaZPJgs/YXVjCX96/hKKBcbjXxDPb72NWUec9+8Kqqr0yyWwlS8sK5QP3hN7EXpi9IPAWRzYaEchPXhMhIbrELs0GIR75ceVAmeyHVJv8WT/nKgGFrHEPVhlpms+aEns0sX++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1dbLGoY; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1dbLGoY"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso721047a34.3
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667436; x=1785272236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAocSYnxkpWO75UswebGg35q6tA7nY7bmvBjycg9mYY=;
        b=U1dbLGoYdspBv/2BmOA2TatrFOHTRh6ONkoLJIiAJ28hWlbT7yg0rxBmrzjUMAKso+
         Ey4CVUxLjTI92+HFBASJaJ3CEUmNRqpe6ww/Ocg9yCKNKDbYWeFBunqppOgsx/rNWQqT
         2fZbS1WgnoJC0TmtdSo1Nvx0pDZoL+9jVx8dsP5ijNfVXWhS6dBTD+kAegnCDMacCYhe
         UyX538Q+DGrK0ZrnmHaHy6KdiRVr6zrwTtN38O+qL1S74cf8b2l7dDAp+Hw3+w35TUOo
         p+7ATpk3pp/ET9JDeuebeWbyU+GezCT+TTozGRtgBHdK6Ct1A1V88Cwx+V/sUbC0nTr0
         pSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667436; x=1785272236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAocSYnxkpWO75UswebGg35q6tA7nY7bmvBjycg9mYY=;
        b=ama2laUpEcERpwJunxKzN2N1+CwJHdvmVSTphpm17l6Ub0UX9wx3xWO2ewIfNrCkgk
         K+8+zI3qqt4fUASwo++PdAzIH33KFI1kOkv5GFykXmRRZIMnpU6Pwq3VWSTByHYrfGKi
         JkxrziBxy1oWPe4hdbyUp/rWAAenNfYVZ02AIht7B71TOgVH+1oHpgE/jTTCuUjyKnMo
         DQQ2HQ088hbT4QnZrYqe1tyEHMHBQWb/rrUM7N6VVGpSl2mp+LlPRwHFhIqQ7ZF3NAXK
         8EwwaMC5wBZ/WgaqjJLYk9FuavXd0Zs2g97subZrgAuMOjkMaRnScMIq6FOfyMWD1SqS
         2v5w==
X-Forwarded-Encrypted: i=1; AHgh+RqG4GfAj+fI/9RtydhKz9cS+jyPZxusFAMnqnqW/L4ZIiDYCFQvQuiQTFe33MzCpdXZc/qgTnq4hyTs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oK7mURRgNIdrN/bRluZ5kiJYi+b3tNvTztgUQ7YCMACQs2yt
	q5KVaSKifJKKsNSxWnFTdZOT056hFKynkafRI6ws490cPYNutcoEJYq4
X-Gm-Gg: AfdE7cm1UPv6oGvfuttQ65cgKuEGmJtZLFzHiTeC41L2keVv3ecCGxTaN8TaD0x8pUC
	r/CWO9ub2PqawbK2HslVUK6r6jpKJf2s6QIneGxQjyHf4rMwjI4S5nMja8y+hjPMCzIH8lALVvt
	Iivm4QGfHjsJglyZD+tfLqoH9QatLDYNnUWyhE9a972QB8hEB3ZvsjB0n/K7mkscGn25b/wIP32
	IdKAUZz0/o7xBRXFTFOMVjVKhWXxhTZ8vaE5ZZBF84NLoBE+IK0w+ZGNppLta8s3UvnkuQnmSIs
	5dY8199UKXELzWWGeB9g/vqcHkwZXH1h2PYaojK/u4CC4xg0UF03L9nkeWaTm6/7neWvaIE3fGk
	Zc46SiqbssXzr6JC2tYtfVU/tf/3lB7p72s6ryCQLKRPWxT17mjgffICy72z638lwofRC2mbWEM
	dX93Sp+KO/u25i4xzOlAl5oQG+drobW0IRLzSyEi7EAngQIulcHGOlsLJXrglK5WJ0Yiezac/qh
	GaFe5MoSvtA+pckadVbv3blQA==
X-Received: by 2002:a05:6830:dc2:b0:7e9:b537:1032 with SMTP id 46e09a7af769-7eda4e4a0d1mr10236409a34.31.1784667435133;
        Tue, 21 Jul 2026 13:57:15 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:52 -0600
Subject: [PATCH v7 03/29] drm: Fix incorrect ccflags-y spelling inside
 Makefile
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-3-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1097;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=es+00dI5lNkwt/sa4qLfcgHP71hLrTUzt4kFdW0j2uE=;
 b=OISPXRmljhHYEheJg69+sy9dq795LswJjyP2tozw2g6htoU6Pia5NBf9EwQ+pEa9lAVL6Pfb0
 IHWJ4VHNv3oBIjyfxg/R8nN7AW2ofYOryMj8dbmU4ZDrQcwAKV1DvJL
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Fix a longstanding spelling error in the DRM Makefile by changing
'CFLAGS-y' to 'ccflags-y'. This fixes CONFIG_DRM_USE_DYNAMIC_DEBUG
dependent addition of -DDYNAMIC_DEBUG_MODULE, which is needed to enable
dyndbg-does-drm-debug when only DYNAMIC_DEBUG_CORE is enabled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..b0d0a85cbd4f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.warn

-- 
2.55.0

