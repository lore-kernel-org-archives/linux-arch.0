Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132537;
	b=1luY373Z3C8o/Y709IlWL8UHDRFvVmT0zReLticckvzGHQnHZO4rG75hZuBKDlg/gKeI
	 6kjSdOSA1iuSgx2M5Hp1N5qF/LBc62rC6jmN7akzmefhZ6QhppUqVkd93XDco+tIiEq5A
	 yzkVknPRtutzR3AyzF4vqQWB4hsle+wP9hFVPfXPSF169hlkVTs8cZ4riGDldO8F8xGmQ
	 DFVQWY5DfCylN7nA1So5C/Bt+FzMM1c35RcVH25+eU4Lf91MQImLdeMxt1bkm7eUFAgCj
	 dR/8xA4/vgaRw6s5ZLc6k/jeVoR4EQ4wPWYakg7if03HXjn+K+/lEtadCRUQHDT6nTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132537;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RY2srfH4AA+kuIHJMrKd0TCCIQwo+yq+1OOzcZP9+W4=;
	b=QX9+UZ0CBN4T6g+NpD8+Wi8okn+wulXEFkja0mVuTBTWk+xMPfyX9ABbNF5Xmrk6ff3P
	 LFayRAynDBixm+KEj8MSTnhH6n7Qp8JIxKogj2XJRGLylv4HBNwjcMGHcQBPtrmawKWaE
	 Ve5m+oloZNBWeqNJkHGkAud8G5JvmU6X/xHic3JWLa4+vAcHDJOF5DXUamAWWoAfo0yzp
	 1AqwaqNMNUKcgoyPpmJFn55AlZobc/UM0Kyhnxzm3BS80ZsKo5JUuM2U9sBsQ4GQ81OBh
	 lA2eEltN7hcjbSOLJxSxWGV6Jt+e3J/Cq8rhz8XgPaG5PQpqm7vepHJL8CiCFpRRNMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SthN9V7r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BF606A324;
	Tue, 27 Oct 2026 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SthN9V7r
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132536;
	b=NM/W9GQzedHjphNf5RCNkHeyrirD51tet9lXbmCPY+xG70mmbr7XQirSjHyTgCyoa76i
	 YE7pLd4svfjg/g2K0ipzAvTOem7MYDxMsEDk7XSpeQs6lWD+qVyyrTf1tXxinBJFCow4N
	 PwwP9E8YqYzj7phuZPcktc7ITRP0NB4JvQ0/84wF8+4p8su0jJDTlHT1vwkFZJAak/FQ3
	 CK3uBU8xt7sm/eT4i0qGD5FXkteFFUbZyTSc0ebb6tHZyR6mQp/UpKyqfL16vaUcF/WoE
	 RkMtFOBcB9Z4CFBDc3PhiI19YeJTRDN0V6ibqJrp/gMm/nKuedwDhMd0rTmBs6LI67w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132536;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RY2srfH4AA+kuIHJMrKd0TCCIQwo+yq+1OOzcZP9+W4=;
	b=EmoFjCyoZJceYU4DehLIlWlMpmJYbzH3WQjkmHdpvI1X19ZRG8tk285tBCTSjxqkoD15
	 RXZTT+VqFHG4M6keQ90cGoJtGSnLecT+05fngSAOQJy7yH6l3A951NAwoKvahDQyQC7dI
	 rl2mKt1lNeIK9TTcxNSYXqXTYQr751WzgLRVwugGfoUGq5z8NWLVYiydKjYEbA7Ni1CsE
	 VPeG9llvyxM5XxK53KsKNsNjkc1HR60VtpWzB5pVgU309JiIrfLCE67jt7umX4ef1og9s
	 1Jk4+9qA8fb+3t2ga6dUquWI/29yJEWtdm90nKNoGExOM9GZVNV7l9zWIkyfn8RjKSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E3FB91F031E6;
	Tue, 27 Oct 2026 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132536;
	bh=RY2srfH4AA+kuIHJMrKd0TCCIQwo+yq+1OOzcZP9+W4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SthN9V7rZ9NIET5ZgjGmQ0rgd2t5t9EpwcAORZLWAODamQoQ0uYYk0OFRHfCCzD/f
	 wIBKGd4SPZEBobHHxNPEkvHZOiZkf8ZYDO24yf93322Effw/u1xl15kVfjsOFLSwzD
	 xk48U13ddHoZb1Yia8qdOaL9QQ+EKq3bkkLJFhY0yp0sYkelpzFCFhq4JE474RPm5c
	 vyjr8mcqnlUzyie6nnwPVB4mdiGOl6j8lkd/cvTujfkkJI9eDtsPQ8kM5P2N9OkZGt
	 Ue5ZeT1hWNv5bnOJCb+d5l3Op4RgdIoilSdmxOPJQnK+hne0IFLUignDyYpgCq2lO6
	 GVYMAWfqRfoCA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F030B45215;
	Tue, 27 Oct 2026 20:22:09 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:09 -0600
Subject: [PATCH v13 09/39] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-9-9267923be612@gmail.com>
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
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=1375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=u6iIguPsThltxCS7AQHMaEZlX8Edh/aUqZEY0TaPvTA=;
 b=jNCjslbXELX7KrKNqHAJriiHUpGjZYB4ujEof0mOAIAVRj0sM/L8o+6A9hzmkbuLUZqvAJK/U
 CZALtmZm5OICAZauIR5+Azgy/du7If4NxUVEhtItbCmt6zA6iOoKlcY
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown, _id:N"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_ _id:N" to loudly announce the erroneous situation,
and to make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8682c23b5fe7..13a3d1a8c3ca 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1174,7 +1174,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.56.0


