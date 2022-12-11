Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F32C4332F
	for <linux-arch@archiver.kernel.org>; Sun, 11 Dec 2022 06:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiLKGUE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 11 Dec 2022 01:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiLKGTL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Dec 2022 01:19:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43B13CEB
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:53 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 124so6491649pfy.0
        for <linux-arch@vger.kernel.org>; Sat, 10 Dec 2022 22:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcrVxRUisDCIwNUwMSeJHwgn9tju9KUjMVhyouaiuRc=;
        b=lFe8X3Tz/J5t4ZHMzra4B7R2AyFJRzD9vb+SS/KtJhAHRX9zmlLEG+QdjJyku6Komw
         QHWzr2V1Q8I6gxOJXRb0iSO2xfUMEgNMJ3GkMHRnvCF7beM2HkY8dXwHGYdNucscAqQG
         jn0pg3sojLsW8LwNejFzV81kIewZIukI8OGMdX0aVV+L8/ZcxHhOlOGkYtD347dxkNzG
         dWUqCwPqe0IzmFXSZChwshXrHSbqpPHeYYwRL9+N92cWygqCZlYraUywikihIxzA8G/X
         vi+YM5eRyRA3HiTxORFlgBnsIN/EAjp9iu6NMiy+22gsour1B+rUZRnV1K6TglO1RHuP
         85Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcrVxRUisDCIwNUwMSeJHwgn9tju9KUjMVhyouaiuRc=;
        b=mQ1MjQJyO2HmgE4IgdpRGI2dbz2UQfZGi07Vc3pJGlGgKllbVeWq6K398VkVxkgrGM
         mtRiddi9b/OvKTPlRZjUKMhxEE6SYJJCpknRbEiR1Z+QKWvtCwZdGQ7IoJV9Z1ywBhkJ
         K93QiuQ5DME/yNk6aKOJq4L52/HNHp3o4WaH/NvjOZtkQ8urQBkOUHbYvuSvIxS2D8cj
         QXUSAKQG05gRCyuvopvtN9gZ8hLf3AJ0VYfgeP99BoWJ4LL4ZU4F3veFU3bbSW0qgPWg
         fxn9qOHbpcELW7NLfIoYjeEqY+TLc+ZNluzpzCWre/iq/XKwBPaHaLQmYABvLxjWIJ3l
         jeTQ==
X-Gm-Message-State: ANoB5pluzXKBJEpr9iSV+UopmI6IhFPxDg7KPZmJB84+GkORuVYJpYNA
        CnOXxkEcEUPlIgpi6B/KRBLGcp7pVBkqDw0B
X-Google-Smtp-Source: AA0mqf74kmm5QQ2t78EJYN+bbtPv6hSc3ZtlGYw3pqKaGbCI12kuNClxdaTI8S9NHEr0n5VHqw8R/Q==
X-Received: by 2002:a05:6a00:18a0:b0:577:3523:bd1f with SMTP id x32-20020a056a0018a000b005773523bd1fmr13542228pfh.14.1670739467794;
        Sat, 10 Dec 2022 22:17:47 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id c8-20020a624e08000000b0056c2e497b02sm3621357pfb.173.2022.12.10.22.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:47 -0800 (PST)
Subject: [PATCH v2 15/24] arm64: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:49 -0800
Message-Id: <20221211061358.28035-16-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/arm64/include/uapi/asm/setup.h | 25 -------------------------
 1 file changed, 25 deletions(-)
 delete mode 100644 arch/arm64/include/uapi/asm/setup.h

diff --git a/arch/arm64/include/uapi/asm/setup.h b/arch/arm64/include/uapi/asm/setup.h
deleted file mode 100644
index f9f51e5925aa..000000000000
--- a/arch/arm64/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Based on arch/arm/include/asm/setup.h
- *
- * Copyright (C) 1997-1999 Russell King
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_SETUP_H
-#define __ASM_SETUP_H
-
-#include <linux/types.h>
-
-#endif
-- 
2.38.1

