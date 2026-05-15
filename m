Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF0426D0B
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835507; cv=none; b=ORnC/Sm8BGmCAW72mE6M9vHbCliTkBtUBFcnCseC4CR6F1IXJ8vwVCTWpdpwdPGWhcV260xZGQ+wEkqvGHY60mJoY1iXpz5LWzLlKGHr4SeAKi+Wh8m7waEs58TW6RO/odyLvQJq8srPuts2BF/U/xLi8ZxNJEpPciA1HXnql5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835507; c=relaxed/simple;
	bh=DpvFIVIZ1tKrtWFxiFTVbPPLSCZ0en//NG1n+cRrz7w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RXmcDvV1ktt65GAuGDU55LHZDTVSQlWQhn6te8BOpa902IFkmqrhcAeMU7dHvaMmMqiEecauxhXL2a6c0cPDKmEIIUp/pTPTmH0wG9hnesrNTOvlbElOlAwq6OCX6TVrMFNWYuruDj1N7U/HniAl66vydCJOWJY0bVpxL/leQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu1TFt3j; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu1TFt3j"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-453903ee4adso7651575f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835505; x=1779440305; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/wqiPCT0YPI0qW/S/HjDfZIvr2fAKk25WVI+QsyRLU=;
        b=lu1TFt3jFJAr69OsE0Eswzb6yQhiw6jPt5rhSG5X9W/kklg09kZg51UlfWMXrNmxtH
         Aw+t8dnmvpj1z6xqvdwbhuxLujH7q0zbdT6Da2bR+6CrSBczvnJ/M7VidrBq9BYsIeMt
         zd4/mYLqqOBKl/Of1P7pTT9bEMG9LwtymPHejYPa9QF3vWqVk1Bd7HRdw+1w59kfu8XY
         Pevii3A19PjU7KXF1DpHJnnffHk0XMODH5y9/xk6eQBrurYZpRd9bYYVq92owdKU7Or0
         APqc39F0X586dpv5ymyHKtL76A0RwT4fPAZW9E0RTcvLVj5B5UxhF9dMD4I5idOgCmZw
         U4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835505; x=1779440305;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/wqiPCT0YPI0qW/S/HjDfZIvr2fAKk25WVI+QsyRLU=;
        b=Iqb/owANsAJKqjzBit0D0P/Ag7HQzwsWELrqFBoLCLGl4aH/iK0NyAFMWa4nvPfgWa
         lmvTOBUeOOSYJRQvQj1SFUk8v0A1oqp/WV7a9vNbCoM4ER/9ToKkgQ9ZLt1tDsjYXQRC
         XnB0qDV+H128GuB3glcxP0tGhaY7LlhrqYb/IDkPLZVF6CdS2tatnAREDdebWA0nk907
         2UUWYQhcqG5wj7Ka0Il0OcGMBu6NDdPJc0ZyajzIzRvrO31GKcmog8RmSLKEJQgysNkK
         Q3i3eDrpf2SUeWNLUfbN9bYCayE4DGckIcJ864hLwLcbgGGilcZ3ettd6dxhpD23rVG9
         ExJA==
X-Gm-Message-State: AOJu0YyKDvKAS5urwjYBvO094qU1G1JMHZ6s/+K4ZzfLO6xyQ9ZWCy4R
	DRZe8/FwmPCs6SW4TNpfDRhTAucXIU7MMruUsw6Gu/UZKd7kz4pf1uJ1iErc/yY0K7k=
X-Gm-Gg: Acq92OHqMgavq24dhESPzjwfhN7xuvWGeju9fvd5zOTH02v0TX3mKkmPeLE2Gf4fJTV
	wtRp7DqthEGWywClWCqCAv+5gGhfTXo7GyMvQwuqCM9L0+bkUpVOdQG6VnC5fXHi1nohhPuS83z
	Pna5k3CyXVLEEO/pNedAsqWW0VThHaDuG5AW9kuqINspzj5s2XS4NvaW0/Woq1CbwjI1uTgViid
	vVc8LpguSDeWQ81w1S0+1jW6yTG5Wx2Ty/CHqGfzY+vYJ0QkI4LJlO2lWltO23YirjHSaDEJgqn
	oTdPsJVce55pEvyKcHq4ltRS6S+35r9oaUw1hGdJgl89yaJOmwnUJNQ6ouab5s3R2FOTYs6jdtk
	0VSnNYA42I8wbCvC7HhXqJ9zxHQJSspcR2NgVh1iNqUE5OmkSTNPHJ6/stUi8l4iGnNM3x3rCZO
	KIUsiiwJC1FJcp6Pyv2NKYGDZowrO6nyfw+WGGXVqVZh4=
X-Received: by 2002:a05:6000:3108:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-45e5c5874e3mr3808053f8f.27.1778835504446;
        Fri, 15 May 2026 01:58:24 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:23 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 0/5] dyndbg: fix i386 alignment and KEEP module sections
Date: Fri, 15 May 2026 02:58:09 -0600
Message-Id: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMywqDMBCF4VeRWXdKMjFqu+p7lC5CMmqgXkhKa
 BHfvdGVFLo8B75/gcjBc4RrsUDg5KOfxjzUqQDbm7Fj9C5vIEGV0ILQxAE7HrOyKFGRbUoySjs
 nIJs5cOvfe+/+yLv38TWFz55Pcnv/lZJEgVIKxSykJtfeusH459lOA2ylREdd/2rKuqytplpfH
 FXNUa/r+gXBfPbM6AAAAA==
X-Change-ID: 20260502-asm-generic-1-32c842a35dd0
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=2729;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DpvFIVIZ1tKrtWFxiFTVbPPLSCZ0en//NG1n+cRrz7w=;
 b=Ui9msCCEx+Ir7Hz8Ovx6hpfNqXShEbOJmFFaKRmm0uhdl3Bk9K/rqlNt/k2Xgk/B05Ip9zVII
 I/hO7sAZ13BDeSwmmAbSfGeZG0juxaDfOoXlhPA71xQJ1zK/LFcw+af
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series starts with a fix to a section misalignement on i386, and
follows with cleanups and refactoring for reuse.

When CONFIG_DRM_USE_DYNAMIC_DEBUG=Y (currently marked BROKEN) and
CONFIG_DRM=y, the __dyndbg_classes section gets a single
struct/record.  On i386 this is 28-bytes, breaking the required
ALIGN(8) on the following __dyndbg section.

This breaks dynamic_debug_init() with a NULL pointer dereference; the
section traversal logic encounters padding bytes instead of a valid
descriptor.

the series:

1. refactors BOUNDED_SECTION_* macros for later reuse
   v2- adds note that macros are for vmlinux.lds.h only, not for modules.

2. drops unused HEADERED_SECTION_* macros

3. fixes ALIGN(8) omission causing NULL ptr on i386
   adds,uses BOUNDED_SECTION _ALIGNED variants

4. removes now redundant ALIGN(8)s in vmlinux.lds.h

5. adds dyndbg.lds.S to KEEP sections in modules
   follows codetag.lds.h model

v3:

move #includes to top of files,
drop redundant ALIGN(8) in dydnbg.lds.S: DYNDBG_SECTIONS macro
add Reviewed-by tag (thx Petr)

v2:

- avoids BOUNDED_SECTION in modules.  Since ELF sections have well
  defined bounaries, _start & _end symbols are useless, and empty
  sections are unhelpful, possibly confusing to tools.

- sets 0 address to the sections, not just whatever current is.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20260507-asm-generic-1-v2-0-47c52759d268@gmail.com

Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com

---
Jim Cromie (5):
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules

 MAINTAINERS                                |  1 +
 include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++++
 include/asm-generic/dyndbg.lds.h           | 18 +++++++++
 include/asm-generic/vmlinux.lds.h          | 59 ++++--------------------------
 scripts/module.lds.S                       |  2 +
 5 files changed, 61 insertions(+), 51 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260502-asm-generic-1-32c842a35dd0

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

