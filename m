Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483845;
	b=Gyk8T5ft/tiTgGOcmm4tuy8W8N5QqFHG8fv7rvr5hIFcib/7XocA+DCcStAVOWpFt4nf
	 dWSYs30ldOY1vsFU+xMOG90SpLPxzDsGYeQhTiioO3l0S8gY0FPFxLRAGlB2Y3z8uQ8G1
	 dKyrPv6WTiJO2nESKlLGFHqtw37qy8G1B1oxVrWhXwzN7Y9Bt+5Z/excIR4epgV2/VSPf
	 i5AQ4/XJN8fyWf6+PHIHyvo+oDtTNC7j+QEIBOsqbusDbtWJiU7H4annjLx0TAMlvT9mb
	 7UrYDdREzPuxoAbqC6B7OPeCi6qZTMiKUdT/FK3T5S9jx6QSF9l77UKRGdC1SfxddWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483845;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=fs1OMg31V3sLV/6CaYf/6uExj4hC/WdEjCETh+Xg5Ew=;
	b=dwhcD4P1iutJHeHTNrQJVF8luqdIa0wyA8sY1FqSvFwqU1P2mJMMOUiC41EMDt+s7H4q
	 NcYIwfvG4U84BPE8rHJY7/E71Og4bFvxP+CCadFWlje3AyGmuxPZLtTosdbOn7P69SkU2
	 JNZdcsfTNWNqXFSoKlgCvvrDBZ1iWONmDTpzqtKkBxcCcFzTP+NklX8wWQ3bmh1hzgI7T
	 JCphF+3SVgOi30cYCQSZQYy8Ye/+zMwExnqo3UEedzGGDaU5KSyHFBtxTIbnDshLLRa6s
	 OXpI9WJRTX0Zc6vmnieR3ee1b7PDZOJx7vRF1ZQ9Gy0rs6onim167PoSGvPbJd1VZGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9zSlcws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE2606A32D;
	Tue, 24 Nov 2026 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9zSlcws
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795483845;
	b=kNwvY6K8sCr1gf8A0ZRFQLMNmd4psdKpZDoPwqgkTXUGH3kTeIDumBC4U/PjGJlIFrlX
	 0mu5zj5PYs7gECeLG+GldpfOxNplNXTVOXXftDqljL2JTF0dAitAcwDj1HRhoA819lvNi
	 iuLoQoL397POX8/qKkyNdM9FOtfLGRwqUBbzXL+nKAZk2FkAaSUWuJ3T488OrHcAT4D7P
	 hv095BwVAQpz5FkrRsqbN01ZTkH0sNSmt15PWts0qOMmjxpmtxUN5TcrtJMI7Vl7E2XxI
	 cP1sUn6DRYBslJxCER/gL4ClppoSGXLVWbKtaWeQyjBYxabIxYu2EBWHs9PAUEoL4Iw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795483845;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=fs1OMg31V3sLV/6CaYf/6uExj4hC/WdEjCETh+Xg5Ew=;
	b=3Cxuf2urYiblND18DXkMRnaqro66EgnunB3lUFDXbLM139GV54pBPGDRTlKzKc0H3/W0
	 9ZV2RLpPAWE3zVnWe0xoupOfSlN0Hgf6tCqrVJpzhENjckOyKR8zMAmoI4NP8Vfiq+WYH
	 5EK/wOMDV3xGiHrF9Z7idfOFzMIcCMf+qHvRlACBa3AezwmQxKUlPIVkK8pQhfgReEUSg
	 SwiiXihaJyR6LaNUPRNukVHqiGyz37DJUIef6Kh4r0KhXo5J8EhtAbz//+bD0S5S0QjGg
	 2i8eyFFA14o+RXcrQguD2w9KZiot+5ASKzPGc8H+YB/a3MFJa1pT5Hbs8nsFrhqdTyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC9561F000CF;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795483845;
	bh=fs1OMg31V3sLV/6CaYf/6uExj4hC/WdEjCETh+Xg5Ew=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=L9zSlcwsYnj1kagzh7H+KcbJgrp4vFj2IvLeSI2HV3aTel2dMKFU03qAzuJiyC8u9
	 sWSFIADV7VIi8TVsjDiLB4/aa+xhovdmf00iAh8ALddaD98da+LZAn5IENTDFFQshs
	 iSraC1dC15UPgN9LajASBLgrb/iRd37g/NAxjNhEhFiJyhMaDg0ofwcRx2jUMgGrpu
	 Ue7M13W6XZJ4WSWI1Y94Rfs8aGs5EcKQBSnese490wNAD8YEJMwZrPgT7AvaUmsreS
	 o1F0O0jljK74UOsV2xj5/njYukHZkv9Adt7KpM9j6k2ZeHQAYpWyCpSMr5EjzUylor
	 mOm2eZVJL6FMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 47A7D4C81A;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Subject: [PATCH v2 0/6] dyndbg,vmlinux.lds.h: fix i386 section alignment in
 BOUNDED_SECTION macros
Date: Mon, 23 Nov 2026 18:30:32 -0700
Message-Id: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/23MMQ6DIBQA0KuQP0vDp2DQqfdoHCyC/gS0gZbYG
 O7e1LnrG94B2SVyGXp2QHKFMm0r9Ew2DOwyrrPjNEHPQArZIkrkJQZa3zsPU+YP3SkUqFpjNDQ
 Mnsl52s/tPjQMFsqvLX3OvOBP/z8FueCqM2j81WtrxW2OI4WL3SIMtdYvSLXNi6YAAAA=
X-Change-ID: 20261121-vmlinux-lds-b59410146885
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Joe Perches <joe@perches.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795483834; l=2874;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=6NBOkHJt3QdBU+ak+6FV5tsQ+HpSrEWmsWMcv2DR53w=;
 b=VeETTy30banfAaTjZ+p7CKuBzeaXn9flaRLzykZHo+EyHI91bEXZoJUlqytWg4UaA4wEWhgPB
 CXwBzEoA+4PCh854cLIxqBiDOzmjes7+m0peoSe8xiDrWROTrh5D7Mh
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

This series fixes a latent i386 section-alignment bug by adding
explicit alignments to the BOUNDED_SECTION_* linker script macros.
On i386, struct _ddebug_classmap is 28 bytes, so without an explicit
ALIGN(8) in the macro, a following __dyndbg section inherits 4-byte
alignment instead of 8-byte alignment, causing a NULL pointer
dereference in dynamic_debug_init().

1. Drop the unused HEADERED_SECTION* macros from vmlinux.lds.h.

2. Refactor BOUNDED_SECTION_* macros from vmlinux.lds.h into
   include/asm-generic/bounded_sections.lds.h for reuse.

3. Add explicit ALIGN(8) defaults to BOUNDED_SECTION_* (with _ALIGNED
   variants for non-8-byte tables like ORC_UNWIND_TABLE,
   EXCEPTION_TABLE, TRACEDATA, INIT_SETUP, and NOTES), fixing the i386
   NULL deref in dynamic_debug_init().

4. Remove now-redundant outer `. = ALIGN(8);` directives preceding
   BOUNDED_SECTION* uses in vmlinux.lds.h.

5. Add include/asm-generic/dyndbg.lds.h with DYNDBG_SECTIONS() for
   vmlinux.lds.h and MOD_DYNDBG_SECTIONS() (`0 : ALIGN(8)` + `KEEP`) for
   scripts/module.lds.S, fixing lost __dyndbg* sections in DRM modules
   under CONFIG_DRM_USE_DYNAMIC_DEBUG=y.

6. Generalize checkpatch linker script macro exceptions to match any
   *.lds.h via a single `$is_linker_file` regex across all 4 checks.

NB: most of this patchset was split out of a larger series fixing
dyndbg-classmaps.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v2:
- Drop unused HEADERED_SECTION* macros from vmlinux.lds.h before
  moving BOUNDED_SECTION_* to bounded_sections.lds.h.
- Fix broken `/\.lds\.h$` regexes in checkpatch.pl (remove leading `/`).
- Introduce single `$is_linker_file = '\.lds\.h$'` in checkpatch.pl
  for all 4 `.lds.h` checks (Joe Perches).
- Link to v1: https://lore.kernel.org/r/20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com

---
Jim Cromie (6):
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.h: fix lost dyndbg sections in modules
      checkpatch: generalize linker script macro exceptions

 MAINTAINERS                                |  1 +
 include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++
 include/asm-generic/dyndbg.lds.h           | 18 ++++++++
 include/asm-generic/vmlinux.lds.h          | 68 ++++++------------------------
 scripts/checkpatch.pl                      | 11 ++---
 scripts/module.lds.S                       |  2 +
 6 files changed, 72 insertions(+), 60 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261121-vmlinux-lds-b59410146885

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>


