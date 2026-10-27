Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132549;
	b=px9nLPKtkqO8HEkOPElOWoZbYSm1311RBZABi5iytX8010gvXeGrdllIJF3xUg0Y+xs8
	 4fl2TQYxVYocFfb85pq+dx7WGtPi441sCrwduS7MdH64YfzMhDV+eVbb8P1+b3rtyii2v
	 dZMZVIWbsgeTBuUXrF2r55zNiw0N6a66OzRmS3Ietnf0xNUsy4xfOxeOPsxx66sYuBhQa
	 BTywGnZdP/j954r03004IVQF5BywgEIC3dgFORYk5Tb1uNpxNAXOkWK9+UnKoq7RzaCMd
	 8vmnTx0i1a0eCxgVtO5H4fD0RlQ5tQKp34j4D5c2Pw+uZo9CFLthUm5qOF/9h3zdOeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CumA5wja+462jEhi0a3U0wA6ylj10YfDNF6b/OlvitE=;
	b=IoZVl7tz+0+HK6XAanRP10toI+mi4IW+gL4H0x+sM080bR03qxwRNW3YMBA4aow58PZG
	 s9ngeMikmT7mYexbSC0GROmiQjqL5Oi0z1j3/2STnd+J4tkpy2kQbsU3KIApryjes9EII
	 NcwcIS66SDobnmOzeNqhZfSxDupTN5+NitecJRiPqWfjcEH13JL/0ktio82hkuepUV8Ls
	 WMKtt3RztfAEzL3Q0NadU66afEgo5MrvNXWQIVY4uVl4+Pr5dBHVL1lAdujrsv6oQiVOQ
	 vmLAHQJPqvWe8bKdrLs4PV9AJ2z6n78Kp6METRKuzciM83UFYc89HLVnZ78hzE/GfeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkOkJj1c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B032660A6F7E;
	Tue, 27 Oct 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkOkJj1c
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132548;
	b=qAiDMk/bPEgAMQgIi/OV4I0wqoVpC040jvPNjLataPcSxdB/uF5+Qn03Abo2KxFa4syI
	 ie6nvq0LkVoLPJWlGuqf4y/mS8AS0fWnW0qJ4MWDfijMgyNSgPx5Wqp121FM2g6oKYkYA
	 AcWfEwWFn8O2p6YqmRnURMnIStrf10mtVR5yqvvM7CtTEki8fXCYrG5G9+tm3uk1XUxnS
	 k1ZfSAK2UlObm2AVC31XR4rZz7XFaODJggdfm0JCTivuP2dRbc1CuoZpry0nnY3WWFbgw
	 j8ZZ5uackF+Xz4pI4SPcew2um0WIv8ZCrKeOdw9V/Bdanl9rOrUTfhmEfAIufFhrVdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CumA5wja+462jEhi0a3U0wA6ylj10YfDNF6b/OlvitE=;
	b=wDdSnbi7v5Ank04nGQGCs6i1Cz2nehM9N6rle3XAYPbpPyoMzzpdZOa9ZniDPmEIFZxA
	 eO+Q0RsIpZzjRbClPCQO+5QX3e7g9TMvF8MnwZNxoRkfhoeW72UzdCrEUQKmtem8ENL4x
	 zx5ADRoX1y/IjQDXcj23wNEt4qaFoandzYhXvWROnKFGaGjT2d2A5B207OlN5iTR0gsom
	 4SLhRdl4Awl3kTVvaTYWfRb9BeZXRg+5s0E39EoyJ7m2oV1Cn/jpZ0gX/u+TcN0HHViWA
	 UC1ONcf1kpcqh1vzbWpjCAwTdOVNYJ5XEUwoDDfWB7zql/zEAUrNS1W7MnqU0NvuXCw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DE9201F01146;
	Tue, 27 Oct 2026 20:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132548;
	bh=CumA5wja+462jEhi0a3U0wA6ylj10YfDNF6b/OlvitE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AkOkJj1c7Ey9wifQItVmmXN8+F9FG5snzrAc0J0rh5PVOu6zJVY9fsIeg4c/P/vPJ
	 PsuGJOLVYUc6W7adm37lCmLM/DAiywTkb5rIN0qSVj81bjAXWqLpn4t62+y5pOfBO8
	 UdevwrFWeIHujsK6hxPnwcSGeuNL+UODWxp+7/XjrxDhRayuRhPUZCt85mcmuFYgA6
	 llpTloSfPQVLt6/kUcg2MuwptWMHWUSu1bVPm+gxZzrk/fthuf7oqmgrhXNziCCcdw
	 nbkvmIamUZGYIZF8GVgOb4CiEAAoUW5uT5VG5d+2+t4vuRdnCTnUNfB5zUrKGXxMOH
	 biFcM5wNVncAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 76FF24528C;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:39 -0600
Subject: [PATCH v13 39/39] drm: Mark __drm_debug as __read_mostly
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-39-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=1613;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=t+nRtOhFy0vKw6kQ27p3cuieeS36YDxQ0XXNRXZWkUg=;
 b=f5HxtzzpGBAtoIjrGk99drDPUwR9c509I4kbOa/UvLUvVSU/1Ym+S3Zc4ZQq7x1BvvmPGB9Rm
 Y0okPVIzszEA9IDtp+xPo+JJyW8Kn7/HOaJh88Ct0eGqz1QL/OnW11t
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

Dyndbg classmaps converts ~5,700 DRM debug callsites into static keys,
yielding 0-off-cost NOOPs that never touch memory. However, several
call patterns do not fit the direct drm_dbg() macro model; notably
open-coded drm_debug_enabled() guard blocks, drm_dbg_printer(), and
ratelimited helpers.

In upstream, the linker places __drm_debug in the same 64-byte
cacheline as hot writers: drm_lease_idr_object, drm_global_mutex.
Writes to those locks issue Request-For-Ownership (RFO) invalidations
across cores, leaving those residual bit-tests to suffer 7
false-sharing hazards and continuous cache bouncing during active
rendering (e.g. 12 concurrent vkcube clients). In contrast, writes to
__drm_debug occur almost never, only when userspace updates
"/sys/module/drm/parameters/debug".

So mark __drm_debug with __read_mostly.  This isolates it from the 7
writable symbols it currently shares a cache-line with, eliminating
those invalidations.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 794417c62097..1ec139c8f06f 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-u32 __drm_debug;
+u32 __drm_debug __read_mostly;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"

-- 
2.56.0


