Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391B3E0C42
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844682; cv=none; b=XqWLibjkX2GL6ykMjJyf2C7ZwHyKj2MbTnKQUix/1Vsc7jVMNDtXGp5D7QIfJGvSUztygY/wJTjmd6RxP16ty1fDP6VlzO6jRH7yK+eRXT5obKQOdKyNhYQmQ8fcdGxAGuTAwjJ7DCa3omPHXxJARanZfXC8pR4wDd6i0viIk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844682; c=relaxed/simple;
	bh=7r1xYU64yeON5vD0sKexuWkg/xhoE6sjr5ISOwW5LwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dSh9I1UkbDyxgYH5uw35WWMIlBvb2BS/CY9Sekc1/NxzX40Bh2x9veEjrr7nFpTGgnD9SwIyycwbyeoKPO6apkTHKR2ocj+3OmrjLWeZ5pf2Sdj6x2v+eL0C8OnlmNQFyrtZuvGhyz5v3akStXIZrDvG9xwtYWZ2+8N1i1y7GsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRcIsq93; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRcIsq93"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so758016a34.2
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844680; x=1783449480; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFnCgMpYG+xQqCYQN0TnUNN055QNl1XiG4EhNEjSplc=;
        b=VRcIsq93veCQOlmCsJuFAdVsStMMjVaFUBfs8PBw/W0xSIPlLk+U2wXBt5YDCzP6uz
         ZP3h6W+XMXmo2OPwLisauTbNpZWjt2BqmnxdiGkLp9qzV0mcUZcLmUiXWwpGPDyNTWrG
         M+4KIVMjoDDjRW0sfTGSUxW//bvKQj0V7VNTWCRxhavz1nlu4BOTupPhp+1Ck7J0t6iM
         km8B16OkckzhaOl/5r4E5lIYLGK5ryC1ER+VZWClMU/q7dreFLQ8JuQcV3o/kio42Awo
         qApwnwavZ26UwMviSYMltpMhPPj3iB3aePSpK1GOXjxOJYXx1puGEOMazmp0jVyvgeGs
         /QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844680; x=1783449480;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFnCgMpYG+xQqCYQN0TnUNN055QNl1XiG4EhNEjSplc=;
        b=M8+UhYve+pAePdqCUWizvqV3hQGjbx23fVVpJBzMM4TKoRiB1alN6DeWCokqhY3LVK
         jEVe/gFU9XcKMP1VfSbxRp2IJKYxoCdTaqS6fCc0mcpV0NUex4SDmhPLtbwF3IRcaxcD
         OrmLWcU3P8449AX8OmLLMusfDhVgpS1nSRu1OWH76oEqL4r7FVZjaFDRHbmp/QJeCaBS
         D3bY0QQSvAGDbfwQJz6GpOl0RnXhBy0lZc2wc00gg0bzIu+w3HcGRqz0fAvATlPHoIPG
         Cu/kwBSavClJa/uJKqIOUW0BT4qEVE7uO8KcOnWJFGLbj5sBd4h3Ht8/PkG5Z+ZEJtR2
         d+jg==
X-Forwarded-Encrypted: i=1; AFNElJ/LuMwbKlb573+jWJPbSHgUlhNbX9eZ8y5uaOld+nlQ1Sn2OmkpwvfnY55OyBBoWjzUbWHHLGCAX2nR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6uXOPfcKsJPYtzP11hbnjjq09UptnOFQQPuSlTXQ83hPENu1h
	Gr/rOQV9fWnkr0h3kYLWrFwMBym6kWmCr2EqaOjK2i18FPPqhphXyCho
X-Gm-Gg: AfdE7cl52l/xPOZDgLLXlfliohax/lCZaiL9aUTytshWFwgfjfDsf+CNZUnn9L3TGbJ
	75jtLglTKWqK3iCTtuDNSPQLi9xuT0Hy3zLtPb6pY+MdSycgnQe1sPmji2W5diat4VYxnrh2IJe
	AlRe/XVpd6XWpGP55AJ5QJOagMnGLc1ds1Vs2qz+uT5dOx0E+vsKvlG9LP18FPvUlLcEaxUC542
	+4gYx+e38DmUVj7fymA2femunhcxTkjix5UMgIchTx8fR6dAq/xGeOkSQ8pcM1RN3xucj4fkApy
	8HYWSR/svixJ/0vRotY7+qfYuoOyDXr7pOWl8//v7uwqvAZ+gtiThhzUbyEXyoIcAHkt8UR4hnN
	7j42jwugvGBvwwAPKsDe/sM8CZ1XXvDZwlVk4fZRdU8f3WFLr5EmqmPLLlIviAMTODOgBECA60y
	mKgSjdxBp1H0PO+LfJB3dUrf1iTQdAJCjNbG344ar50dZERJjlc4k=
X-Received: by 2002:a05:6830:2309:b0:7d7:e142:2ead with SMTP id 46e09a7af769-7e9ec705fe9mr4203432a34.20.1782844679723;
        Tue, 30 Jun 2026 11:37:59 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e9ebfd6ccfsm2940025a34.11.2026.06.30.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:37:59 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 0/5] fix section alignment on i386 when
 CONFIG_DRM_USE_DYNAMIC_DEBUG=Y
Date: Tue, 30 Jun 2026 12:37:49 -0600
Message-Id: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNzQ6CMBCEX4Xs2TX9oUv15HsYDhVq2QQKaQ3RE
 N7disdvZvLNBtkn9hmu1QbJr5x5jgXqUwXd4GLwyH1hUEKRIC3wyW90I4eIxl4abYmUJAllvyR
 fysN1bwsPnF9z+hzqVf7Sv8VIgy5PGHws3x1KXDUKJCseqtFE1Ne3MDkez908Qbvv+xfBmIe9p
 gAAAA==
X-Change-ID: 20260630-fix-align-589738662161
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782844678; l=2143;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=7r1xYU64yeON5vD0sKexuWkg/xhoE6sjr5ISOwW5LwM=;
 b=CJVzjW2/2gS453H8XNOAbQJTLwmqYF7vROlIvRzZhUva/WSe00kFk89L/Pl0bhOxHvmI15Ozp
 V68qISwHJAWAKrMcCh7lvCzKZ4nWr8w3j0PnlVxiKbxUYY2kNtaH2vx
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This fixes a section misalignement on i386, when CONFIG_DRM=y and
CONFIG_DRM_USE_DYNAMIC_DEBUG=Y

In this config, the __dyndbg_classes section gets a single
struct/record.  On i386 this is 28-bytes, breaking the required
ALIGN(8) on the following __dyndbg section.

This breaks dynamic_debug_init() with a NULL pointer dereference; the
section traversal logic encounters padding bytes instead of a valid
descriptor.

the series:

1. moves BOUNDED_SECTION_* macros from vmlinux.lds.h to its own file.
   v2- adds note that macros are for vmlinux.lds.h only, not for modules.

2. drops unused HEADERED_SECTION_* macros from that new file

3. adds ALIGN(8) into BOUNDED_SECTION* macros
   omission causing NULL ptr on i386
   adds,uses BOUNDED_SECTION _ALIGNED variants

4. removes now redundant ALIGN(8)s in vmlinux.lds.h

5. adds dyndbg.lds.S to KEEP sections in modules
   follows codetag.lds.h model

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3:
- move #includes to top of files,
- drop redundant ALIGN(8) in dydnbg.lds.S: DYNDBG_SECTIONS macro
- add Reviewed-by tag (thx Petr)

v2:
- avoid BOUNDED_SECTION in modules, dont need _start & _end symbols.
- sets 0 address to the sections, not just whatever current is.

---
Jim Cromie (5):
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules

 MAINTAINERS                                |  1 +
 include/asm-generic/bounded_sections.lds.h | 32 ++++++++++++++
 include/asm-generic/dyndbg.lds.h           | 18 ++++++++
 include/asm-generic/vmlinux.lds.h          | 68 ++++++------------------------
 scripts/module.lds.S                       |  2 +
 5 files changed, 66 insertions(+), 55 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260630-fix-align-589738662161

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

