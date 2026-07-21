Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B743B3D8
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667442; cv=none; b=vAmRFUtnrtyTTtGfhKBAP4VFDVXaGPkonvbI6dwTj2o7AJUHwLymTKY2al6dDeeL3GRrhy+xAJgWwt80CnW6IPJrHnucp49kr9dlflokUvizdG9CDpOa9hI1/zuB1/UdlCCKcgC9vkB9oUhkKeetuIh7Y4WMhVczTx1fyxUZr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667442; c=relaxed/simple;
	bh=hS/jtkq/JrVHcN/uc/pVKASKGCENsolPn7B4mWKffAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqaLcC1xs6G2t1V8q0Ch/McZHa3m2FKfZt/58sx3sO5pp60QlUuXImjo46bo8Fa7+9/Dqp2jNkv/7wcs8DmHk7hAAy9gkxSkGj3iNFy39pDPSA0I9UeyfvPTyO1Xxl1iy4ERjo2i1Knfid3qzEj/TyzA92rifv+TQFq6yIF6rx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsvaRuaE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsvaRuaE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ec49608332so2723485a34.3
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667437; x=1785272237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tICvvWUDLTcQaplMAJMGSX4sdCGxuxLlP7txV6x7Ef0=;
        b=BsvaRuaEa8t0WOpGhFUuzxV8ljunu9o+XdRcgrWLZ0DRZzmr7eUXRaHjWVheSrHxO+
         lRQ2n5USOyJU5CwSu+SycnU+yVf9DR7BPKGCfKGM1l8axIkN9bmwBElRC+8WpcGBZKsl
         cIC222LNGfeTtqNrpo29w+q+2L0yCTl/1JhVFM14zonVvsQ75oIKLQ9sjIpOdekI0uWq
         XKQTFTwBswVGi7kuAB60AjV0g/lRS32t159Z1utvx0jGnTrvkl3UrlvZb+PvvksqGavf
         +O/ywyOf0mGJM6/PcXIJ9wZnilhD/7vxqzjpytTn3UOQtlwf7Fw+vaqfNtLBMMJy7sRy
         bYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667437; x=1785272237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tICvvWUDLTcQaplMAJMGSX4sdCGxuxLlP7txV6x7Ef0=;
        b=qjHdoVUKcgSNT64ARMffYEomRgn8wCTVdKT4XZ4X9NBjYFz1435tjqjzgUawtuvWFW
         nYGlUGpllo/RwQJraqOa5oxkZ66JLz1JLlEIDFnUhZZKl532RS0xRaAdqgwbq29V5TrG
         2atCQbRvrAHIvSYeUqfiJW1clqMsyerB5VHdkC/78AmTZuXMQwiK+pPQnsLkke/L3sJW
         RjYNVVMIODOsYtWhkXdG/P7lSue6WLdmDmctyivgR7tGTVxpJ8herQ4gLd6fWeqUoeVD
         jmgEh0t2xnNIYUYg+hHdCrsD3p0dAtnXK0jzSs6JmwGUn/q+Fcv1oZIVq00lQVfisq9T
         ShbQ==
X-Forwarded-Encrypted: i=1; AHgh+RotsEfkC/nS2Xn5b1b5JGXjKZC5xtBu1QhTDh3kj4osK/TtN6JQ8dtzz58t5N3CeY0TZg1cvjufApit@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVTvffuIl0w8GJsig5uRaa2zX34rujk1GqDTSZSANZxrsGNh7
	KCY/ulPnslkC+UnVbiBzMR1VYgnsnsEDVxLrjJW842y+R5SmCoHse1kC
X-Gm-Gg: AfdE7ck7DzBfoMx+TVXKuncF8LCquICNhAi0uxz0MLyxW2xRTuTUE33IO9yF2JavGzm
	zDePu4ulBXz0Na0HGKvcqXuR4yNPntqGZrlH7CdVLMwe/N3OVmiH7VWmUPgyIDLkUCST5HQuEyX
	xtVXxbj/i/i0s5IGP8J9k8AivpbTcWFRk5JvvUXrO4XLNNJNh1Ty3PjyJs1STGEimziPAVwbxAJ
	18nNKTnkCcpXbWImwUwpM/5hbgInH3sAshfvpkrngK0p2wGPhbp73rsFXriNXMQjNCrQcFRh/JC
	UtHasMoK4hqqQ6CrWgZc1cc1oMMx9+CU//iAg/QymRZbbvYJuJKdrynfzbjpNERdGRe8ZTLVFgx
	h87/MJNFsLtVtszuVuWaxuw0fVW2Hrrqfj+R1UUvAtwmh/ropSo/rW7bnwGj+A+DPAhPWtQx770
	89ErswM628AQh/AEKQSYIwKnGGxgZsMo/iHblxtSM/JLITXgT6y5EJVNMfgaiovfBP+3bXFIvDA
	EtJ/tPswu2D7nUkcc4t0lyICg==
X-Received: by 2002:a05:6830:3746:b0:7e6:c9eb:535a with SMTP id 46e09a7af769-7ed9aa4576emr10492097a34.6.1784667437350;
        Tue, 21 Jul 2026 13:57:17 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:54 -0600
Subject: [PATCH v7 05/29] drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as
 unBROKEN
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-5-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=924;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=hS/jtkq/JrVHcN/uc/pVKASKGCENsolPn7B4mWKffAg=;
 b=Lsf35FcMlCjbByxil/qjct2DAL4mr3Oc2q7x03tL/lqrAAMPWfcuP6gbFsC+oTgUeWP2YAwmG
 rTpFDD680+JBUtHGotBL8c4zwJWAzCGG1m6f1joIJBe2KBkLkyy1u+R
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Remove BROKEN mark on CONFIG_DRM_USE_DYNAMIC_DEBUG, inside
drivers/gpu/drm/Kconfig.debug.

Un-breaking the var allows to enable the config, and build and test
dynamic-debug-enabled DRM drivers with full classmap query support.

Doing this early in the commit-set exposes the series to more
in-series enabled testing, which has more chance to expose bugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 1f4c98cbf090..2ae59a616e75 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -1,7 +1,6 @@
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
 	default n
-	depends on BROKEN
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL

-- 
2.55.0

