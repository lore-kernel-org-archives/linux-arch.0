Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8D3C433E9
	for <linux-arch@archiver.kernel.org>; Thu,  7 Jan 2021 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648442333F
	for <linux-arch@archiver.kernel.org>; Thu,  7 Jan 2021 11:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbhAGLzS (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:55:18 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:43284 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbhAGLzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jan 2021 06:55:18 -0500
Date:   Thu, 07 Jan 2021 11:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1610020475; bh=1c0zIRSp5j+9jPf96D96lWaXSqjKgRxuaqZWXnp1GJA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=QSf4PK1l/0z+lqNG/RN+SWI8NiSqHOQYaqNMT8tTimEIsiiENHGqnuihCuJ3YfoTS
         PwSAP0XUEjMITW1M5igKo6aiOLj+hPQ/VbHC404RmbVM7zmG89DsY0Fv2hyhFJ4ZNz
         1XPd99TE8cWH/9iL0qyVCv2k+6igCBxmqW7kCSiAKWcPe1GAvIEAmC+/qJlZWV3IF/
         HegvS3yUPHnrgTtRi1vsPzSH02S6gvkG76xhpSPZLFAlcqCM6jVtk3HiLdvJT8g6Cj
         aIT5D9n9qMw0z1SZ6HCDiay0gmxBlNIf12r3H+iRq7DHCrv6PnTUtDcTvsP714KN+m
         djC48Y9URNyEw==
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        clang-built-linux@googlegroups.com
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v3 mips-next 7/7] MIPS: select ARCH_WANT_LD_ORPHAN_WARN
Message-ID: <20210107115329.281266-7-alobakin@pm.me>
In-Reply-To: <20210107115329.281266-1-alobakin@pm.me>
References: <20210107115120.281008-1-alobakin@pm.me> <20210107115329.281266-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now, after that all the sections are explicitly described and
declared in vmlinux.lds.S, we can enable ld orphan warnings to
prevent from missing any new sections in future.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d68df1febd25..d3e64cc0932b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -18,6 +18,7 @@ config MIPS
 =09select ARCH_USE_QUEUED_SPINLOCKS
 =09select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 =09select ARCH_WANT_IPC_PARSE_VERSION
+=09select ARCH_WANT_LD_ORPHAN_WARN
 =09select BUILDTIME_TABLE_SORT
 =09select CLONE_BACKWARDS
 =09select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
--=20
2.30.0


