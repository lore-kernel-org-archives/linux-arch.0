Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55827 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964980AbbLOPua (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Dec 2015 10:50:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH trivial] include: asm-generic: Notice about 80 columns in pgtable-no*.h
Date: Tue, 15 Dec 2015 16:50:06 +0100
Message-ID: <8033721.mSphpqy3yk@wuerfel>
In-Reply-To: <201512152302.Zy0UpM2T%fengguang.wu@intel.com>
References: <201512152302.Zy0UpM2T%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: Chen Gang <chengang@emindsoft.com.cn>, kbuild-all@01.org, trivial@kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20151215155006.PuO_11UBzvDzU7gc_abhu2-ZFKVRl3SolsdK0mmO9S0@z>

On Tuesday 15 December 2015 23:47:28 kbuild test robot wrote:
>                     from include/linux/mm.h:55,
>                     from arch/arm/mm/fault.c:13:
>    arch/arm/mm/fault.c: In function 'do_translation_fault':
> >> arch/arm/include/asm/pgtable-2level.h:187:27: error: expected expression before 'do'
>     #define set_pud(pud,pudp) do { } while (0)
>                               ^
>    include/asm-generic/pgtable-nopud.h:36:36: note: in expansion of macro 'set_pud'
>     #define set_pgd(pgdptr, pgdval)   (set_pud((pud_t *)(pgdptr), \
> 

This is a result of the added braces, please redo the patch.

	Arnd
