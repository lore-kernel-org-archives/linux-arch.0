Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3649CF56;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632020; cv=none; b=XePaKqkFlwIeBIbg2BmxHvfzuKrF4t27n5RXNXoZl8/ngbdI/ycFchtm5we5gzj7L/QAVmwxeWFBo59iAWufqLMYEnRmzwmNPM8KHy2B3E/izja3RMEQrsom8tINtMXK3BZQPu2m61WyI1VpF9q9JYR5/mMXH4mwMhW7WQ1PBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632020; c=relaxed/simple;
	bh=CB4Cm6/3E5wQ7JD6GaUGHHYvD9xBg9sCG6wREr87n4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIUFsf05FP5oR4AC4ohyVFYGi5Qba5vl4qMYfPg2qCg80L17zuzFGsdtW14gl4ro7/Z9IaDWsGhSoVv3sHFHBL6kwoDnXTcZTYNFYSKFqAiJlY5QYuk9PNvzAybgOkDrQg3S0ldnjm+t77OS5F2ad6FaMVDaEpzbw7JfT3waJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRhS4X2F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRhS4X2F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8822EC2BCFB;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632019;
	bh=CB4Cm6/3E5wQ7JD6GaUGHHYvD9xBg9sCG6wREr87n4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IRhS4X2F6xRCYin2Ddn9rl/PeKB2tXArBquUVxSuQO82dl/+oUPJ+QKj+Xk7kFYgw
	 WDOc+WDVPyXSml61/l6ElsvhXma68pksBnBUz0AQKhVmC29fgrZD+gis0RO47JhMPM
	 oMn+lCfuNRw5n1nDS3NJmLhRbrCf5uyG9VkEZbcdtFEmYHo2uVGTEnsDtCwLdaVY5K
	 02GEMC7J44wzlo35pVZITj4s0GzEjt1FCSd1T5Ff9YsmuDx8THDxtDjEmReMI5KIWE
	 jED3W9f7KPNwL3TPhCYO8CJ4a8Lbb810pDqQ/Ln91CN2NyfBBnICSut5RZE7+hDZzA
	 wnRXjSIqnlqpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F37C624D6;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:16 -0600
Subject: [PATCH v8 02/43] drm: Fix incorrect ccflags-y spelling inside
 Makefile
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-2-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=1097;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=AOvjwL7FEa1HOM3wBzBER2pp1VD4Y5qc6+YArN8CHNQ=;
 b=fUEUk09ZYPTYWj4Qs/SeMtbTlvtGRdmB2IpJCCbvkbToK67w2HwG2pzV2BJZI3psHIBD2rE37
 x9d5DQtN406DsJf0FjFkpfqobpJh8AM01Rxyn7hFoKrc92KovTYnGDu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

Fix a longstanding spelling error in the DRM Makefile by changing
'CFLAGS-y' to 'ccflags-y'. This fixes CONFIG_DRM_USE_DYNAMIC_DEBUG
dependent addition of -DDYNAMIC_DEBUG_MODULE, which is needed to enable
dyndbg-does-drm-debug when only DYNAMIC_DEBUG_CORE is enabled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd379..c42884d84ad1 100644
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


