Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73F4EBAE2;
	Sat,  5 Sep 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632020; cv=none; b=H9LsMJtVEg8V5jtlDgaB7yuzUfW3NP0TaarTMgJ2C4bZkebivUlEsxNgK7DK4AtsL7W22FL4doJa2qxfZlSzBHa3crM/o6S6Ij6TVIfrqRmQK5mWONsO7oNiD1tQ+RwVXp55frHWgESbk9Xa+O5WGZU6xGbduI1iWCVHJ3dPLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632020; c=relaxed/simple;
	bh=jEFGIzSFi2fKpcASDjhrz30qzCE2E8t13NgDNVHjHwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zb18Ivp0xe8IAQMEthXEqlP76XuHXpFPAhJ4ZJo3McDxDX1Q7QLjseaoH+zu580eUjUoAA2rd6fFC/KB+y+KLwW0pOhNvjNwQ5sBf6fvntv9ibWPMbEduyRxCxoXD6jI8M2zH6kagnZsYTPrj24HDvWlMBjwQeqf2dRDHqkupZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/PQIR/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/PQIR/x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A26ABC32782;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632019;
	bh=jEFGIzSFi2fKpcASDjhrz30qzCE2E8t13NgDNVHjHwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E/PQIR/xEQzu/VFmvgoL1Y5SUo3NDQ1ayExWEis/tN4v133yU2ASvzkX6mlJlO6G2
	 liv6JOk+urkHFPehT7jdB37IOsG69ZQWCx84sKi71AaR8GkV87k/te2yS+DrRVL7Cq
	 m45E5vll/zeGKGFlDkT03Edvpe+dXPjIC5Qc+QiSpU4UKRzIPOxNtIbIvUqGXttKLp
	 nP+Aua1Ql2WragG2YXrm7la9ko+oH++HZ9jtlD2FklFD1Fp5DZ55EEDsNEcEUcZv3h
	 j2tZ+ytWhAJlb18r84noFTH2WeFXhdbsg8xu9kv9x3OBko7Wr/vdqlcd0VKVWca7B/
	 D6MM4zbvKgzTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD78C79F91;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:18 -0600
Subject: [PATCH v8 04/43] drm: Mark CONFIG_DRM_USE_DYNAMIC_DEBUG as
 unBROKEN
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-4-a4cc0674f6fd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=956;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=91CKbBJDX7oHlPDdRPBXzfzFdVwcfmtxuAQcemz5Mzk=;
 b=lnNlvgmEbieOGyZLQZWVNLD6CAWSF77GHgT7jCfNb8H17bFeUdDrNDidWoj89yVkKE9ExPRHB
 F5VS2EHSXERBpxBkbVbA1OXC9Dh0NRSHXiDEMI2wVoV4CFI5tM/LuMR
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

Remove BROKEN mark on CONFIG_DRM_USE_DYNAMIC_DEBUG, inside
drivers/gpu/drm/Kconfig.debug.

Un-breaking the var allows to enable the config, and build and test
dynamic-debug-enabled DRM drivers with full classmap query support.

Doing this early in the commit-set exposes the series to more
in-series enabled testing, which has more chance to expose bugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 1f4c98cbf090..2f05bab1a796 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -1,7 +1,6 @@
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL

-- 
2.55.0


