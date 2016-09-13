From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] mm: move phys_mem_access_prot_allowed() declaration
 to pgtable.h
Date: Tue, 13 Sep 2016 14:50:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609131449460.6233@nanos>
References: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58632 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbcIMMyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Sep 2016 08:54:35 -0400
In-Reply-To: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: ralf@linux-mips.org, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, akpm@linux-foundation.org, paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org, yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com, toshi.kani@hpe.com, dan.j.williams@intel.com, luto@kernel.org, JBeulich@suse.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xie.baoyou@zte.com.cn

On Tue, 13 Sep 2016, Baoyou Xie wrote:

> We get 1 warning when building kernel with W=1:
> drivers/char/mem.c:220:12: warning: no previous prototype for 'phys_mem_access_prot_allowed' [-Wmissing-prototypes]
>  int __weak phys_mem_access_prot_allowed(struct file *file,
> 
> In fact, its declaration is spreading to several header files
> in different architecture, but need to be declare in common
> header file.
> 
> So this patch moves phys_mem_access_prot_allowed() to pgtable.h.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  arch/mips/include/asm/pgtable.h      | 2 --
>  arch/x86/include/asm/pgtable_types.h | 2 --
>  include/asm-generic/pgtable.h        | 3 +++
>  3 files changed, 3 insertions(+), 4 deletions(-)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
