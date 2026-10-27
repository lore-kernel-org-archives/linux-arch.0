Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132544;
	b=H+J888BDwWw7/QAqT1i2tL73JrcHREwwm510u62jyFTOXqTs3/rDKYCU9dUbbfmX2OGK
	 GHvoEs0QfP9+aB4g+qrz0uVdFylL0LwrsloEgmzVxBNHt2joGWRToOHcwqe9gxWBHjhYs
	 qYe2YmA7/2ooEDQ3x3rJU/I/zLpFmzDh0+38973mwu2qy8Q23LEogJcztUcDMwoldH/KL
	 a8Krq1Sv4LATX5NO371sSKr5mnQr2u2MGuok4lnvUgMR6B6kAk06ni+ef3uSrHwtdfH96
	 RF8/aPXNGKlK/boeYF6wYe8LX3twSEW/gf3IsWe+nY1tW99UJ5daggRy02CiLz5mQCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132544;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lju0b2KWfYe8jwtqBBfnv01v7i7za+kzbB7y4NqZ17U=;
	b=OxJRE6fa0lBZbYHu78cAqSrrPyhogWj+okhB4Nw91OCQpW3ie02xdKxMsKXevGIlGhtN
	 arn8UUdOpvR76XgCwhE/mw4NLWQhZJkeviAGOB3aH5FDdQ/aFDWDe650MWxRfJSrJ9e3V
	 d8cCjaWYd+/Yxwsu8bX2ghaUHUJz+2U0gCmrwud2icJB1Nb0qzCZ52C7mrCxARxiOumcl
	 stn/lXjTbaT0ohJjsjn2RxxP31RByTCKoYBpL0N5C51o36fk6ZKIomZvOIbelYFPw4QAa
	 CFLjp8zNZE6zl01QUG30vjbAdYUZB+H/auoZPKJ+3A6YnZB1YTdcdHq+DOygeGk4WVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpvTk2cX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E660A263A;
	Tue, 27 Oct 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpvTk2cX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132544;
	b=DuuiaqltGFqWwmU0hCBtwbAvrRzIhtaIAfWov79xv+IlAls5HALKeS8KYb04qaRUVdiu
	 rvn84DQPI+hzTQenudyoBMQg0NNU0Yz3z8c8e4EbwC09Yvk6TIP4dRxwyj6Q9qTiQUN63
	 TdHsahWoCni2a4m3FvDMwI9tzddO20ZYSE19Cb0tk0y620j53o7yh9lrmP9gaRLbEhZ7N
	 t3J7mZumeltaOqhQp1DQGdBp7rWrzhzM9tTANx5DOYhQS2MJp/1kUnzMr+o4eTl3ym/ej
	 T/VeYENlb3ZZreK5R70kD+b7wE9KtrNu+Xh7f1YQXnRqcodph7vanZ4DullRcOWOwyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132544;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lju0b2KWfYe8jwtqBBfnv01v7i7za+kzbB7y4NqZ17U=;
	b=1S9NxjdVdg/a8ed/gZUvMcTxLTjw5QD79hgwA75zInfcfToOurzA2SF0uASBNnYjMUPc
	 11Ql2z6SJwtP9bN+w5XV3qgsdO8LLpoL6jnJ++v3yu2JdOc8dGIzV9YsJu7T8ocwDyffp
	 VT+iPvgTILndy6N8rOTUAwbR7SoAwk9L4t4UCWp2xGI8k0iSFB202sSu8UOvbVt0gk3B0
	 CAEA57NTET+sbyGDo6R7Cbp97Eppv7ARUn26ANmjbUp3ezhmRL17h48GAmZDCGKPUNqXs
	 Hq3hsZrc/P3Xw1G2noRLItsTGpDUNeinSmcImz60uEgd/vE4dGV8jjXe2n5NYGyzmCw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC0AB1F01364;
	Tue, 27 Oct 2026 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132544;
	bh=lju0b2KWfYe8jwtqBBfnv01v7i7za+kzbB7y4NqZ17U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QpvTk2cXAq4t+CV12u/f7Rij+Wu97E5pA5w72PeNmMuxgtSw+gALtUEiuC15qcpHI
	 FKsiSQ/DwmI5IICqS7hPRVwmsAGyMQeNG6iGIuOWwIiueuiBnvTQ3gGUGhU3K02zOq
	 cnIpw0+2XWUIz/FClM0V9FOWABjsOaG/MwpHoCfb9vwhOh1m75B8sbyALuK2lHOSui
	 BxB9bHv5kJ8d0+/BDn+Kb1VppPxycKrzL+fY1Qg7LoRr+OqsNqJaN+adplq9hrhRmj
	 +H81UZAn2tyC1llNPMefIo7WrndpzCdgXEjkEUj/kA1yZz/4XqDODodTj4itIyC/nd
	 nv5v9hrRfZjQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4337045278;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:34 -0600
Subject: [PATCH v13 34/39] dyndbg: fix attempt to modify an RO string
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-34-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=1338;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ixTGO+9E4e6ny5HSFD6LFvYUhfjCd8aiyHGBDPZdcJU=;
 b=Gzv6kwnWWAGy2/gJiCLZJaE1VmrRcDtxSRjdmhkJYU6m+NltR1sVTraWZnaT3iVxIjuSNUwFW
 lldZIcBpXjNBGfJfssoWxkmm2UNFR42Tg0kyYYIXGVioHTmr0N0V82b
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

ddebug_dyndbg_param_cb() passes an RO flags string "+p" to
ddebug_exec_queries() when no explicit param value is given, but
callee may attempt to modify it.  Fix by adding a local mutable var,
init'd with that value, and passing it instead.

Fixes: b48420c1d301 ("dynamic_debug: make dynamic-debug work for module initialization")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5c87e92bbcdb..efc7a741008e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1637,8 +1637,9 @@ static int ddebug_add_module(struct _ddebug_info *di)
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
-				const char *modname, int on_err)
+				  const char *modname, int on_err)
 {
+	char dflt_flags[] = "+p";
 	char *sep;
 
 	sep = strchr(param, '.');
@@ -1651,7 +1652,7 @@ static int ddebug_dyndbg_param_cb(char *param, char *val,
 	if (strcmp(param, "dyndbg"))
 		return on_err; /* determined by caller */
 
-	ddebug_exec_queries((val ? val : "+p"), modname);
+	ddebug_exec_queries((val ? val : dflt_flags), modname);
 
 	return 0; /* query failure shouldn't stop module load */
 }

-- 
2.56.0


