From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH trivial] include: asm-generic: Notice about 80 columns in pgtable-no*.h
Date: Tue, 15 Dec 2015 16:50:06 +0100
Message-ID: <8033721.mSphpqy3yk@wuerfel>
References: <201512152302.Zy0UpM2T%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201512152302.Zy0UpM2T%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Chen Gang <chengang@emindsoft.com.cn>, kbuild-all@01.org, trivial@kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
