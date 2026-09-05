Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62F4EBAE1;
	Sat,  5 Sep 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632020; cv=none; b=tBC6pilcbtm+K/MZibRXZM2R6MBuqZmhTZfUKmJ6XBkt3QIxfnCX51SBaJ4cTi06O/YQq5tEXHKsq6ekfz8tKzfEXu6T1MLaiFLn0Bt87n8LQxXo4wUo6XlpyE+eHcUXu8IXwpOTarn/QO8JlyYR8L6VJmAC/XcF3DJ6DW6FcX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632020; c=relaxed/simple;
	bh=GWkapSVvyFUFAgZ+6PHr+LM1u0ZhUP84bP/x3TY51II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RD+JrkAXQQ4K4SdZuL+JyR224kSdE8lKekvSMoosy+5QJlN0t+PfIuY7+NnyOcFGnnvyQ6EyRnihgA0RI549AUreQcQ05Udjb0hQXw+jOFmOIIqS4+2gCq6XN92aFJ0KNNEi5EO2soSUuvj61HEZ2UFT+TXWTx9x+ZWWvbGRSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7EA5GgX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7EA5GgX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1C3AC4AF1A;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632019;
	bh=GWkapSVvyFUFAgZ+6PHr+LM1u0ZhUP84bP/x3TY51II=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h7EA5GgXzxnCHQv42J3o7+3Z+VyguEzbUteLpMoQJ4HmvdnntS2/+JH1eOvhRYqNh
	 jJMwaCaieKsdJpt8HBnUoZd2gMql1eapCDVuLguRJ843cAAMIHNtrpP9HgDM6U1YnI
	 AdUVa6F7Fuo0Zib3ulnurWC8X0ZupscXA23RvnIk1XbPhjA5+GiSGVZk91GfPBFyOw
	 5Mu5LBc+Jw/droMOoGBYHJcIrSOUfWdNdheH16Sqd/e6PqMmRS/R/MMtA9Y8sJfvKH
	 gxGa+YgwhcJdENI5ta9klVEL3annV9+dosenD0xYlt0aOHVM2ZaYlK/y286TM4DH9d
	 JA/Gthph1qcDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8DDC624DB;
	Sat,  5 Sep 2026 18:13:39 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:20 -0600
Subject: [PATCH v8 06/43] vmlinux.lds.h: drop unused HEADERED_SECTION*
 macros
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-6-a4cc0674f6fd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=R+ywodY9/HEwLU1o/08HL92DtAFTrUi2XM/5yuI7Itk=;
 b=x9U3vwhV1FBkXLQy3mZBL9S+oSv/aOLnCCEB1RapsEj7U+qbDlu2lpj0a/bkBspamLNH7aaHS
 Ddv3MO/B3MvB6bzZjATDY8YmLzYh/D2R476vmfEnUC/JBity+ZRti/B
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

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
2.55.0


