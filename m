Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795301378;
	b=BMecklcNkHZiHHpawfy5N60lN8dK6c3p5n/iP5hjVTl4sKWUL1dG5FMGCPbARhgiDEL+
	 xRUHMmoThs7E6ITu6zE04i0LqS0NYr1hvEom0KTByVwhnmo/UQ2okHyb/REFLlUM7PD1C
	 yCSWntvukYmQUGzPlCA5TDUhUTG+wWrgw23rBdzFdkYntwh23ML1pIAkj955MbIfxNTih
	 zmWiOS4E4XZEV6onk4ke5MmdSy6Dfl+cBxdFspNIedMyi7NZSiT1p6/RUTtcwpjjFOazp
	 Qd4tctxH5LqE3gckH9qRqqU/p5qvR7k1YnYVyuUPZRisnMu2ltIvGQdPaJ06ZQZJHMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301378;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Mvx3njFRz9zfHK0cxlq3fPJ/kD3jv1+DFhiSx9WqC4E=;
	b=gGDu3GsUSrCn1rF9zNy1tGBofMhY+9EfoRhIrZisyFovrME3Ua15a0+qxNlQLYy70Zdu
	 8NDrUjcC3nTqaWdTViIIMqUizIgLWn5/whiUYnyrwTSEaGj0mj78i8BPnAN35Nr19H9wQ
	 uYJIKw4e26RVahLtyblqKM5tDTbgA4Uh8hpI73nX7FxN7EpByYBLKB/W4OB3N2yhDTbkq
	 Kr3DBJFKmgf87Wx4ByOZLbYTAJ0OQAOLpP8MsA1TM63PwTVfwYJa8+BDR+rMl1L0cp2s3
	 PaoPDJJjkgo8ZyL+UYfPvkdTgE4zL1UQK4Qax5tRzurUKgh1p1ZLCXVSVpv73VB6Ucg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1irgVyr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3A606A334;
	Sat, 21 Nov 2026 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1irgVyr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795301378;
	b=LaP/ics97yE9YXKDZiHfiazSgtGjuKWOv446PfM4C0VkFPJq9Yqpq3SvSdD7nqTUsD49
	 4I1XAFHBhPFte45E6B0G0JcWFZaQ/ZMz4bwKxKqR7d/ZCD53ri7nVKtRlJaAiZBvpTuCJ
	 pywJwGRjpsfkt7doKX4ovly3non5GEJkqBD2NKlZLslZlj/unejir6bfqRNhM7PtLEKhZ
	 IIdDiTJZJAOnyP2/1eiiBWFhVbYnZCGcknD7Gaho6vvOSoBX3eaujkHISJ5pykktTAEmN
	 cf9dISIwooa39MUOk9eclEe8pwIyAi1MFcarHKDKbvETW6CN2bokHt44A2h4Lp3oCiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795301378;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Mvx3njFRz9zfHK0cxlq3fPJ/kD3jv1+DFhiSx9WqC4E=;
	b=Hmtf38oAhUOSRgk/Uim4UFu76G4wd0J63PetGhQRJzeeucSnr3kk2NM/No6wRzmNFrPV
	 vyd/Bmo79JaZRqkGmmPPoyolHzVc+YIyb/gtYkgVPFHmH+KVe30GoUV2Hy89ts5IN0XTD
	 yt7TkZY1VZSSbBDZVBV41o9HMmzEFCD1D6LcTt6BeVtjV61Fu5W580KgO3RAwXlzq6it7
	 sJNnAQwLhQTqk/GTdk5cOaIONIfN9GofxYbBkob24dQPjABkWXwI1PUSHp8ERw4nLec7b
	 uDkOSdVqJJin9+EjYpQf40cbANL9bOoJxrXOam3nW/UKKaauHK1iH6bgaDhQ5CW4EVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E38A1F000C6;
	Sat, 21 Nov 2026 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301378;
	bh=Mvx3njFRz9zfHK0cxlq3fPJ/kD3jv1+DFhiSx9WqC4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=C1irgVyrUzRN0+NfCbTETxw6IJE5bjzl6Ti6JMiN5nbo0s0WNp9gIhi/nLYgfAj3C
	 aofeeHZoELqLuWuIlYPEle5DwZZLxKzgOrJDbXH2xTEvIKGj3XZZ1VnHfItyviN/Kq
	 Brxs5bKg/SshBrxlsXoDJPdgdm6e4Zucj7+wUpk5FPiZUXYNQL3iiKqmuaIHz4yyeU
	 O7ZVFw1VqjC3Q30MpPOuUBk+MxHzCKPzYJZ86Bx9dNZoA+mWOdAwZLZfq+6qUqj/mD
	 YJreA+LNYpEyqCHDbV+qjhcBkz2vCyX1npk3mXjksLbjrVZKwLm2n4VUxsHPMH7yLB
	 WaSmryQ+cOULg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A240E4BE4E;
	Sat, 21 Nov 2026 22:49:36 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:49:20 -0700
Subject: [PATCH 2/6] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
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
Message-Id: <20261121-vmlinux-lds-v1-2-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
In-Reply-To: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795301375; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=g5z+IDfPUrLi9ooJXrXG7eSrlGaOIyVCDk2Kag52knw=;
 b=8Wjuc7MD0ocj9DKzUsHhTKX4gKapvtQNihvNKFW29mVEKxvKEEwX9qY3zacUro/LVHBkf+CYo
 cxboaSyrpNEDEEFFreyZ7UrfwdzRscBLLDCAValR+sBLhQFeeHNbQu7
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
2.56.1


