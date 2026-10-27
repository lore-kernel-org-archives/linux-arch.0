Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132532;
	b=2HVPnlzjwjN97AGoZre6zTIWc0gjFgeoPQn7aLmPbijbI9krHtVZ5Yn+z7HTMT1LkpXU
	 2dc5DqQ9YA3Fi0MOsx08vU/y5Am9PqVGAg/oLRDHciQ1KfW84sFICH9UkxlQkCVNM1f+C
	 54Imsy6ooedS4W5p3/FH0gytR+hm3FjEpAGEAFZquzLDoNMRa6iBlaGbh5YaGal4iq1RQ
	 dXQHeeiuzcDPP3RKewPlQ0Ag8WDmQpMtBBqOrlMyqYgRNv7B1ruin1K9CRidzwe0N67ms
	 OmOwnMyfHBZF2X5LEBOUIaxIyZX01shTh5R1GAAaD4mpYw1fCMAezz47N9k9AEVoxaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132532;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eNbUTGE4iSA32nWe/S568aDGz8kAgMHCOwq3b3eGgaE=;
	b=nIyWwEWGMdKb9YJOBxPlqkFO8mJi7UJq9IcPfQekgSYcIFRwKufTTTdKVSGxa86BqkAI
	 f1IwbJ8FcPQ2ROJ1shHJOM84dDKqwXeIvZJmu2rUUKDoON4yWNaYfTeLTbDRwSdSgNP44
	 pdZPWbujK4V9XNjPS+zSPnrWiL5qwkZr/Ytegq2KgSg5VzC3gKi61E62pwnNPsoMuwGeE
	 geGLK3RZy3gNewUb9QkS4XeqiXTCQ17qYMgqoR7SqBmM3y/aC/VizWaqkL29ZwjsvkhrT
	 YjB2WB4pp/N9oRrwES0iYR/15yy/M7rX0u+gfTDggg0eKq+ogZLtKOIXq75DkYmoEAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3HapJ2f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D738606A31A;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3HapJ2f
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132530;
	b=EWZC22WEaQU51J58IcLuBHUOLKlAASB9LI35uKu8D6DTXdkSxMbajdev5jAwwyCgQ8AP
	 sU2b1djgJhksff27klYhUjpncbiz7PNG7xvz0U95sIXI5vtTSyzzL24+KJ4ur9eP9WTGM
	 jyLpZL5ig2g9RD3KQ3fYUx9ATa/6mEjA6zy6adCg0l3qmNyt6VD7ZqZwlU97e3QXHAVxA
	 AcRGSV3/NN2WUBquWTZcMoCDpnaW1tc33njH/k4BRymJkkHOxJzvspGSdEQDlmLKH//Qp
	 56/5qmHQRhfuLm2E78oqJJIpuaKCBuZzNEi6Y/cthpSx4IPuueFxGVROZRSj3nrMH5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132530;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eNbUTGE4iSA32nWe/S568aDGz8kAgMHCOwq3b3eGgaE=;
	b=hsqAMtoyFY7nuDQAnWenwz5I3vqLkzr3uWYc1VeTeTYHAv++EBhvveAWAgH7i/RY9ftL
	 IMdVTUaQF5AD5iy7DZHCQl1OEfxUCxuOfTw+4AIFEgFQS0Qgurz4LrbmufL1WXjo2vokW
	 fNZxO+V5RtIp+g9BjqCFzwXOBs3MuxvfMMVwX3YFEgRH3NfMMvTjfX7C7j25UkTXWXYde
	 XkrkYa0Y4a/ne9FXYC65Lc83H4FZ0kSUPnwQx8hxkVkJZcFG4BtAE845RzZ9V7Drimi5t
	 Itf48Vogude42yaOzqBLc+WK9soHhJ+BZaXja3t8F1ZE3q1XfeQOiF7MJ+ZYbl2lrXA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 308451F01828;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132530;
	bh=eNbUTGE4iSA32nWe/S568aDGz8kAgMHCOwq3b3eGgaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=N3HapJ2fbzCS85B3rok2hRCgd7zkipjLYtUW3v3UMcNM54r5/Es8HGM9jpePI1tLe
	 fwZb/bx+37PVuJ1qoNmCUAF9TLs0pahpBvY9yfhyGUYmxNiX99LHuVwQ6FIpGdSzG9
	 ONjofovPKKip54Lo7J28wS9ezivKiBFJGJBeldv/DHRyfHWi+gmaB/QIRKM+2Kticg
	 HZnH8fcT5gGOtQ3y9XtWXU6mHJdQLCVj+V8o9j/vE6UyAVmApHTUcgWcvZw4FUL4jH
	 OjYD0MjoD/ihHBp9W/kC/XQu3ZVj/q5c7aenoFRjwZjMiqOLQOmNRa1z2Kj+2VlFwC
	 a86ioXwJDHAnA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ADB44451FD;
	Tue, 27 Oct 2026 20:22:09 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:03 -0600
Subject: [PATCH v13 03/39] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-3-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+Qnp7GmBGhxUf7BnWtOhBW1ycfqvD4UBWUm58PMJxJU=;
 b=Lkizb67hB5HUobqhhQfE3LJEkLk1XV2kLlvsK5XlQIH+h8FJzA/WsMungFxLnUmXUbIOBuQIK
 lvvI81jftZFBqtzQzuT2kd9LLcm6oZjHi6RKC82FIDDPrKLd8jwbHCU
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.56.0


