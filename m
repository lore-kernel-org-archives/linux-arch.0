Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621617D2
	for <linux-arch@vger.kernel.org>; Sun,  3 May 2026 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766744; cv=none; b=ZdKddCtSgZnNPwQ8VkAPvkw92a9P2hKvJdW1rJk2i/A+CacQfzmZQiJxuYXReEssqT66OpHAm4Tw6409yB2oiG37gge08p3TZTTG128BTnrySdxDPxoQqcS83DelSJG7jtvv/d4WxxpC+yuGqzp3zhsd7kA7TZwp/DYbgGEqIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766744; c=relaxed/simple;
	bh=ZKEL+uQH1FOrD2/R13JXDbIEvC1fqmuy5poleA8Qdyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DZVel3N74lAU5l0vZOiixD0sKtBQTs/ARN6eYVy0FrHXttvQOVzDqfOKBnaDgLT2UZMeuwLcKGfccBwqjFGBqwgHd7QuMQEDeenaE2f4litYn+SZ83J2C/bGszSVrJfNPhYZqgYgh1MLuOE64iHa5wuVGnaSmR8Mcr3jOUIxSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0hxYW0E; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0hxYW0E"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so3028439a34.2
        for <linux-arch@vger.kernel.org>; Sat, 02 May 2026 17:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777766742; x=1778371542; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GIRMx45vOgiLzrxuavXJ3Yf7PmCjpoz6wDAVtl8FDVk=;
        b=R0hxYW0E7PvJh/0UwPdTDZlJhblCq7gJ/BXe8dYXCX1taeVxtYNmkIWcFrltOn/Zze
         pC4EJVLZ5n8T1cvIVM0ffe+Ihvm/ULPkSfdk12mJfMA+gGCoCocNZwaTilUIZWOfJhil
         e3ehV3f6/lAV3gqCpa3iGBh8OKOx4F55l1yV9K5VMYhPNqwOu+u6jtf1YujFwReoTGsN
         eFnrzejiEt5nry7PQbGEv75phtvc0j14iQFihVRAp0bumeWVXDId3gMTtLQMyKNqc9As
         ezUqIkf8fZpqyLnzdIBSEW0KFq9/N0aA/UuiGzchrs+waKjnboCYAp7+t1Oh5Q73HliX
         HPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777766742; x=1778371542;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIRMx45vOgiLzrxuavXJ3Yf7PmCjpoz6wDAVtl8FDVk=;
        b=Kiondv0Tt1JXfAZyBhqSJpGI9tZEx4UBunzVjCsX1dJ/ffZrRoqfks7dOQG0aON5ij
         H7yhVc6Muw7cPisVlIZyCsWuAn+EEatjBKsIVnDEPz0IxzWthM0pZLQxN6uJp0S12Wv8
         xFcaHmCTnYDPgrMY38j8nhiKQMnCLCIqmOMEln3U2M47fHmgCvTItab6SzEfYngFl5C/
         ZTzKq5zUlKT0DfJAKHz/VtCCPULYHdKjgnZqzfQUDVSo5twGVjMN0/AYNI8pnEnoFQ6t
         n68aGdbdkqbcObOrYAukkzO7OkNHy7ZyAIG6jnRc7xq4QASb6DUWTtPE9kERNUrWzhqr
         gysA==
X-Gm-Message-State: AOJu0YxJflGsSJXYuytwu8EBdfTIcl4T2KjloCsF9+ON2BoK6rTu3KqH
	6/ZC+ccUSNfs4lXjHvlIMc9e2s18QPkbBnZTEQIWsKVcaHxg/6HR+gDN
X-Gm-Gg: AeBDiettWoe4mchUmvLjEZIPuequWBsShZ/KGYIhuwvwYJGaZC+2Lks6YIBQl/oImRk
	r3FMDYLgJFDM4NaisWLp5IKApgpRmkg2NUdvSrV5B/gYNTdZ/frAbvaVR8lG22woq6nuCXLZIKe
	X+Ntw2d6IQYBIc/mtDXapFY0Bd6eujzxB/zPtXFhEzfVMZeoebi+IGbb6pjZJ5975kDcMnM02aY
	VPyphhvsNDWlIRoAnrZnub/WDHBESHhV7dviYdaitvn396zztrpHh45tMMykzezvVAqslqw1TL5
	Tm1tsLKoWd9RAlVepymAZiUDfbll+Pl/ZR3Fpd2jIxie4L9kxIGJBQQdxGKhFCDEucMEShbTDWy
	r1uWaNdiA/qsso4gCSmnGhHvbPip8i3YyiyiYlCNESHaStmLsAegkOkERUDXoljhJQnfYvItZBQ
	yjvSXdzBXjXf7FMV0z02aYJ4T6RWlNbBFRscZL40agbjTKN9qSCGc6byvDpJACN6n0e393FzG9
X-Received: by 2002:a05:6830:6484:b0:7dc:cd0b:58bc with SMTP id 46e09a7af769-7dee1261e2emr2667101a34.7.1777766742471;
        Sat, 02 May 2026 17:05:42 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7decae2b090sm5379676a34.24.2026.05.02.17.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 17:05:42 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/5] PATCH 0/6] dyndbg: fix i386 alignment and KEEP module
 sections
Date: Sat, 02 May 2026 18:05:31 -0600
Message-Id: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvQMSO6SrQQnWwWWShEEN49a
 fkX779QOAsXmLsXMt9S5EwtdN+B312KjBJaAykalVWErhwYOTXlUaMhPw3kjA1BQTNX5k2e/7e
 stX7TyLOVXwAAAA==
X-Change-ID: 20260502-asm-generic-1-32c842a35dd0
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777766741; l=1850;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZKEL+uQH1FOrD2/R13JXDbIEvC1fqmuy5poleA8Qdyg=;
 b=0SzOGfTU03sQ5R9xI9yMhs/DNczLBjWrIIsjqxHplD8PVcZD8haEy5tc2wMV+ZofojocTNtsX
 J+X5ddihN8HCiVN4bRkvrV2Yz3U7NrGITeQ/KmD6maKeu9oHya8DD61
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

1. adds ALIGN(8) to the BOUNDED_SECTION_* macros

2. refactors BOUNDED_SECTION_* macros for later reuse

3. adds dyndbg.lds.S to KEEP sections in modules
   follows codetag.lds.h model

4. drops unused HEADERED_SECTION_* macros

5. removes redundant (after patch 1) ALIGN(8)s in vmlinux.lds.h

6. adds BOUNDED_SECTION_* _ALIGN variants,
   usea them in ORC_UNWIND_TABLE

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Jim Cromie (5):
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules

 MAINTAINERS                                |  1 +
 include/asm-generic/bounded_sections.lds.h | 32 +++++++++++++++++
 include/asm-generic/dyndbg.lds.h           | 19 ++++++++++
 include/asm-generic/vmlinux.lds.h          | 58 +++++-------------------------
 scripts/module.lds.S                       |  2 ++
 5 files changed, 62 insertions(+), 50 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260502-asm-generic-1-32c842a35dd0

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

