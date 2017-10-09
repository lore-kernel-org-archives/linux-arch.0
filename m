From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] bitfield: Use __ffs64(x) to fix missing __ffsdi2()
Date: Mon, 9 Oct 2017 15:53:11 -0700
Message-ID: <20171009155311.17e1c7f8@cakuba.netronome.com>
References: <1507538449-22775-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46375 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755845AbdJIWxT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 18:53:19 -0400
Received: by mail-qt0-f177.google.com with SMTP id 1so6101616qtn.3
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 15:53:18 -0700 (PDT)
In-Reply-To: <1507538449-22775-1-git-send-email-geert+renesas@glider.be>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, kbuild test robot <fengguang.wu@intel.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon,  9 Oct 2017 10:40:49 +0200, Geert Uytterhoeven wrote:
> On most architectures[*], gcc turns __builtin_ffsll() into a call to
> __ffsdi2(), which is not provided by any architecture, leading to
> failures like:
> 
>     rcar-gen3-cpg.c:(.text+0x289): undefined reference to `__ffsdi2'
> 
> To fix this, use __ffs64() instead, which is available on all
> architectures.
> 
> [*] Known exceptions are some 64-bit architectures like amd64, arm64,
>     ia64, powerpc64, and tilegx.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: 3e9b3112ec74f192 ("add basic register-field manipulation macros")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/bitfield.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 8b9d6fff002db113..0a827677372756fa 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -15,6 +15,7 @@
>  #ifndef _LINUX_BITFIELD_H
>  #define _LINUX_BITFIELD_H
>  
> +#include <linux/bitops.h>
>  #include <linux/bug.h>
>  
>  /*
> @@ -46,7 +47,7 @@
>   *  reg |= FIELD_PREP(REG_FIELD_C, c);
>   */
>  
> -#define __bf_shf(x) (__builtin_ffsll(x) - 1)
> +#define __bf_shf(x) __ffs64(x)

Hm.  The build bot failure made me think.  I think rcar-gen3-cpg.c may
be doing something wrong here, could you point me at the patch in
question?  I don't see any FIELD_* there in Linus's tree.

__bf_shf() is supposed to be used with constant masks only, therefore
the call must be optimized away completely.

>  #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
>  	({								\
