Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46579 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbfGXC3l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jul 2019 22:29:41 -0400
Date: Tue, 23 Jul 2019 19:29:36 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Message-ID: <20190724022936.GA73305@archlinux-threadripper>
References: <1563914986-26502-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563914986-26502-1-git-send-email-cai@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: akpm@linux-foundation.org, davem@davemloft.net, arnd@arndb.de, dhowells@redhat.com, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190724022936.ID1Ni90nBEkBsOTQ-r58X44F7V6nbzu5Oj1sEs72yx8@z>

On Tue, Jul 23, 2019 at 04:49:46PM -0400, Qian Cai wrote:
> The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
> compilation warning because "rx_frag_size" is an "ushort" while
> PAGE_SHIFT here is 16. The commit changed the get_order() to be a
> multi-line macro where compilers insist to check all statements in the
> macro even when __builtin_constant_p(rx_frag_size) will return false as
> "rx_frag_size" is a module parameter.
> 
> In file included from ./arch/powerpc/include/asm/page_64.h:107,
>                  from ./arch/powerpc/include/asm/page.h:242,
>                  from ./arch/powerpc/include/asm/mmu.h:132,
>                  from ./arch/powerpc/include/asm/lppaca.h:47,
>                  from ./arch/powerpc/include/asm/paca.h:17,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:21,
>                  from ./arch/powerpc/include/asm/processor.h:39,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> drivers/net/ethernet/emulex/benet/be_main.c: In function
> 'be_rx_cqs_create':
> ./include/asm-generic/getorder.h:54:9: warning: comparison is always
> true due to limited range of data type [-Wtype-limits]
>    (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
>          ^
> drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
> of macro 'get_order'
>   adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
>                                  ^~~~~~~~~
> 
> Fix it by moving almost all of this multi-line macro into a proper
> function __get_order(), and leave get_order() as a single-line macro in
> order to avoid compilation errors.

Wouldn't it just be better to rename __get_order to get_order?

> Fixes: d66acc39c7ce ("bitops: Optimise get_order()")
> Signed-off-by: Qian Cai <cai@lca.pw>

Other than that, LGTM.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
