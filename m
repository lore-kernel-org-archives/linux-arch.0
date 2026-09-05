Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D64C041B;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632020; cv=none; b=mXowA834O4P62qKOebB4ZKgt/K5toVBQMvTGtlJFgZnWfzO+AM6j1IbpZCnb6UNk3r9Ps+89gJdoCOE1Vn1rg3upzl1OTLLtOnoSnjGhyHyg7TU6HWP4D/8JvFg4B5M3JaetwK3//SvakxKAlgxY/xjvmq3Iz3jU3M6zb0BkT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632020; c=relaxed/simple;
	bh=mFq7t8pPnW8tWgNRY0QIGMk5Lw7S9ptiEy3IfuGAgJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hiexxDcNEjrpm8OA4f3yqrMryZPHsH4tT/6Kk0r1MkZsjKojntLC6N9+vY0GwWYvrTd3a8Nw63nCliKR2kizQpQj9PtYLOjldIZSxMqkrnW5vuj4GmWIbpWGr5iHB3SrtVMJgwfEoJPDfMGvmVc/BxuQGixCaDC+IsuQsakqqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFvNKc/s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFvNKc/s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9555BC2BD00;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632019;
	bh=mFq7t8pPnW8tWgNRY0QIGMk5Lw7S9ptiEy3IfuGAgJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WFvNKc/sOsIMcTMDtfDLLYm8aoov+2ZmiCxqXnHDJMkHdj7QKoSkL2xtpcWG6Cxbe
	 aTEHv7F7nlUWNuCSItLvknTOXJTBjGHrwj8DvgE9rGrGYFMHIH2As7NV/SQoa+Exeu
	 UHmxqTV6FKyxIKamjNA6DVIaLE0p9jl9xBrV23/Md1rkSIaRFR3jgeDl7txAjn6DwX
	 lPeBn0lCBZyLhmGAGI3MHZs/yG2ClKw85nXBAMFHEpFZbGoBt1U1w9+6rSVpqFEW+4
	 CIMlVI5L4w/qm9MnK0w3rRGEgPKOr4DkQNLGcxiEW4rc7V0Bay+9By8U45h/tK3GZ2
	 N+aGSQUlFPlZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA5FC79F97;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:17 -0600
Subject: [PATCH v8 03/43] drm: fix config dependent unused variable
 warning.
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-3-a4cc0674f6fd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=1088;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xTai6ZK4QmRgBE6pkfVWluR5fMfzn/IcxxIyts3OtoY=;
 b=RBwsUntnwDYlSQqJ+ZyEsskbyqGxP1QEVoTtffrk146DvlFwKAUWPOKh6P8PyLAl1PqJTQ9sG
 Xa33uXACXc6ApsZaPqViABTtQCiMsFm9pDrIX3A7V1/589VdcUQXOH8
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

__drm_printfn_dbg() does
  int category = p->category;
then does:
  if (drm_debug_enabled(category))

When CONFIG_DRM_USE_DYNAMIC_DEBUG=y, that macro doesn't reference the
category arg, because its optimized away, as not needed when dyndbg's
static-key is under the callsite.  Silence the warning by passing
p->category directly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 86cef1a37678..e5b900640300 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -218,9 +218,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);

-- 
2.55.0


