Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:64170 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966AbbBBMtm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2015 07:49:42 -0500
MIME-Version: 1.0
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 2 Feb 2015 13:49:20 +0100
Message-ID: <CAPybu_16LBPDjuhL-Vw-rqFK-13+gLHrRc-3KuYwUTi0XyDX7Q@mail.gmail.com>
Subject: Can this be a invalid memory access? (was: Re: [PATCH] spi/xilinx:
 Cast ioread32/iowrite32 function pointers)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20150202124920.SFa-fSLEmasV5u4nEEO1GML5IweXJ59cMeXKOy_cAd8@z>

Hello

Regarding ioread8 et al.

On include/asm-generic/io.h is defined as:
extern unsigned int ioread8(void __iomem *);

On include/asm-generic/io.h:
static inline u8 ioread8(const volatile void __iomem *addr)

Please ignore the qualifiers right now. The first function returns an
unsigned integer, the second a u8.

Through #ifdefs, different arches uses the first or the second definitions.

If we consider this code:

u8 varA;
u8 varB;
u8 varC;
void * pvar=varB;
*pvar = ioread8(valid_memory);

Depending if ioread8 returns a u8 or a unsigned int, aren't we also
accessing varC?

Could not this be a problem?

If I decide to send a patch and fix it, is there a clever script that
I can run on my x86 computer to test if the patch works on all arches?


Thanks

-- 
Ricardo Ribalda
