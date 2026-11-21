Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795301377;
	b=yznK5CZ5DB6KKPKwzR/Yg2q6M61mCx41aqbE4RgN2eFWRLtTsCebqeSK4mME3W0dPW1m
	 MLp9fEXv/YHxxdFHwitxU0JcVstJMEpZFLr24CUn/KoLFvqIdEpNOFEgS4JNEXNzISsao
	 kKNzIxGmDTezf92SRadewwfWkH9riGkGs0VLFVNTWap4Ule8lNtwtnqo1zvvfWnU2sMhs
	 7RY8i9s/gofXdiczq+pKgb4e0EuI4OnfSZjL4/cp2TvH9hVP433GOtwMIOA+Y4T9uAwMC
	 QR4/bNzzLwHO3JkRr71muqCVk/tfGxyy/aTKtkaTLjw3z63NRAilX4ZGRhhfS03DDrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301377;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Aoiu4YgCXwBVcBKUOr7OdOpxOZVgC9Rnn+3RJ75AsfA=;
	b=vEYzxWlP3uaoRCu7SmTjgp6ZY9fe6pVuhBhzQ48VKZYIvovuSAT8BzRBsTsr55jIQTR+
	 K7OYwMY4GHJi+8VnrkrlyDuyoCaC6k86XN5o8GaHEO5+uol5aGumge4leLZi6/KD34Jc7
	 7qK2lGM7oUj+A11pe40gJQpFHcpvlnTxt3XThbBi2PDpjwZmLnu+2+MRR4Z2D00j4UpVV
	 m1qW2yRv95m6uXoucWvzWe9tvpcGjU1zwUVySZcAQLkXfhBqAZhHgSCznL7/JA0of45Vp
	 mFY1PyKFgn1mFfNHG9sPQSwc62/uxqPW0oREsnWtwzdrZvj9yY4s2ZgNGwoMEXVbD3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiN+x13g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC9606A320;
	Sat, 21 Nov 2026 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiN+x13g
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795301377;
	b=oduiiZIm6Ru5QD0ulQbQ1Os1MaI4OBYeGVNXuO0sLOIIXhLu5HgF6+GLzWcOI0dH0rFk
	 NQo+/N8Q55qYlzrVegXv4gKIJ7L4Rpxdd4x9GCDThtKziPUzreHDIZbn7l7mUXJwTvRB9
	 KM0tRcjjC4FxHHTtlM32XCkB2+HeQPJ89BSL8uyOSu4b0VEZ1JYJwH/qEviXDTYae6fo8
	 Bl20vxUVD6ucr0uRKa75ToFCMGEcRirD35Pt6TYB6Yh/vetlX1Kx/KY9Vh1QX51M+J1+I
	 r0bq8Nb2ueSk5XckKzLsLbgV2jsDOitwRXASvRcmF9+OxjenWh9/GF8zUUPtThm0ECw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795301377;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Aoiu4YgCXwBVcBKUOr7OdOpxOZVgC9Rnn+3RJ75AsfA=;
	b=S6eFeZrxT0b3GOWcOrcdn5NEWqJAS/LinxCrce2+oL2mV0E7H7AGK0TrgG9p9hZiw1Zk
	 AJw+IgHGuFMTyz9yqFAl8P4hSoeo6wMMBkAx4S6Uj9zWZBfhOSjqbhc95K98l3syvbyMk
	 G0IyZEZ9P8iR0+yUVkOutcG5PoImFB03Qukhcxu+8WCNfTQq+Q0QHsmzn9/ohJt3FScV2
	 ENl4QDstk8dQt4rpqsYKGG2cmJgt9jVSamF7yA2/pPcmOto4agPvtn+pjeMOoWTP5oLCe
	 5RJ7v4BU8JK4VbiLCN3kDQkoNZiXJqXRStWJW+L8T2FGtSDGu6/5OT8BpxKIAhMU0Og==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E4921F000C0;
	Sat, 21 Nov 2026 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301377;
	bh=Aoiu4YgCXwBVcBKUOr7OdOpxOZVgC9Rnn+3RJ75AsfA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=UiN+x13g9SK91jI5iOvwBstLG2KX8iXC9Uly0/1ygHIZ+Du1zH0xnFLMCn+bj0cm5
	 I88xyAfMjXH6GlE0WoSNt02MgW2SoAKaZ6OSQlnJKS5IesVF93tAsQPagZ1M2z/25H
	 yp1Ezvt2U+WPl+2803cxoMpy5WybiGneafDesiT8AZ2qR155nro1FenLgP7Rx2JfpQ
	 Zt9/xH42jj/BEEA7qERddZY3bRux9qfErhJpJGjYPQE7/5bi2KfCP/tXgiq29qtLeX
	 iUyZqJG2tbHtVU+aJl5zjGpmAvfs2tnndQOtldDgDvvLROX57UYj1cwe70OGVSzQy5
	 pmlgWyQ/a8Z5A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 651DE4BE3E;
	Sat, 21 Nov 2026 22:49:36 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Subject: [PATCH 0/6] dyndbg,vmlinux.lds.h: fix i386 section alignment in
 BOUNDED_SECTION macros
Date: Sat, 21 Nov 2026 15:49:18 -0700
Message-Id: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3M3QpAQBAG0FeZvmtbZkPsq8iFn8EUS7vZlLy7c
 h7gPIgSVCIcPQiSNOrh4Ygzwrj2fhGjExzB5rZitmzSvqm/brNN0QxlU3DORVXXJTLCGWTW+9/
 a7n0/HYCNLV0AAAA=
X-Change-ID: 20261121-vmlinux-lds-b59410146885
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795301375; l=2466;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=InmaDXtqg+/ahjVrbCn9lEk8jOf8zxExCbI82ydIsZw=;
 b=Sf2U1Fv6tD3GNRvKetfdqrqq6Lle3eJzJPocyk3wSnGWKzNm3t5q6lF4H62eVd+rRfUiiwlLR
 LlWgl5loBYOCdW0Eb97rHq1Fo2nHdILm6Wsn3J80brn9VpViuJ1gDzm
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

This series fixes a latent i386 section-alignment bug, by adding
explicit alignments into the BOUNDED_SECTION_* linker script macros.
The misalignment appears once __dyndbg_classes is split in 2, and the
1st section has just 1 entry; the 2nd section implicitly gets ALIGN(4).

1. Refactor BOUNDED_SECTION_* (and HEADERED_SECTION_*) macros from
   vmlinux.lds.h into include/asm-generic/bounded_sections.lds.h for
   reuse.

2. Drop the unused HEADERED_SECTION* macros from bounded_sections.lds.h.

3. Add explicit ALIGN(8) defaults to BOUNDED_SECTION_* (with _ALIGNED
   variants for non-8-byte tables like ORC_UNWIND_TABLE,
   EXCEPTION_TABLE, TRACEDATA, INIT_SETUP, and NOTES), fixing an i386
   NULL deref in dynamic_debug_init() caused by 28-byte
   __dyndbg_classes misaligning the following __dyndbg section.

4. Remove now-redundant outer `. = ALIGN(8);` directives preceding 
   BOUNDED_SECTION* uses in vmlinux.lds.h.

5. Add include/asm-generic/dyndbg.lds.h with DYNDBG_SECTIONS() for 
   vmlinux.lds.h and MOD_DYNDBG_SECTIONS() (`0 : ALIGN(8)` + `KEEP`) for
   scripts/module.lds.S, fixing lost __dyndbg* sections in DRM modules 
   under CONFIG_DRM_USE_DYNAMIC_DEBUG=y.

6. fix checkpatch to skip macro-rules checks on any *.lds.h, in 3
   places where only vmlinux.lds.h is currently skipped.

NB: most of this patchset was split out of larger series fixing
dyndbg-classmaps.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Jim Cromie (6):
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules
      checkpatch.pl: generalize linker script macro exceptions

 MAINTAINERS                                |  1 +
 include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++
 include/asm-generic/dyndbg.lds.h           | 18 ++++++++
 include/asm-generic/vmlinux.lds.h          | 68 ++++++------------------------
 scripts/checkpatch.pl                      |  6 +--
 scripts/module.lds.S                       |  2 +
 6 files changed, 69 insertions(+), 58 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261121-vmlinux-lds-b59410146885

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>


