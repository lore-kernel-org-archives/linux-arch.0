Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966312AbcKAOUB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Nov 2016 10:20:01 -0400
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
References: <20161015124352.10795-1-npiggin@gmail.com>
 <7315031.MmlhY1rulM@wuerfel> <20161020145827.453025a6@roar.ozlabs.ibm.com>
 <16513464.3RM484EDf1@wuerfel> <c9adb10a-1c5f-1b90-ead3-37c6665a903b@suse.com>
 <20161031221445.34e50e69@roar.ozlabs.ibm.com>
From: Michal Marek <mmarek@suse.com>
Message-ID: <bd7b413a-3290-b9cc-35c2-09b22bc2ef71@suse.com>
Date: Tue, 1 Nov 2016 15:19:59 +0100
MIME-Version: 1.0
In-Reply-To: <20161031221445.34e50e69@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20161101141959.Hbhk6can3sGdMeWjQK4LYXkNZRYG_CHYY7RenzE8bMo@z>

On 2016-10-31 12:14, Nicholas Piggin wrote:
> +# This is convoluted. The .S file must first be preprocessed to run guards and
> +# expand names, then the resulting exports must be constructed into plain
> +# EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
> +# to make the genksyms input.
>  #
>  # These mirror gensymtypes_c and co above, keep them in synch.
>  cmd_gensymtypes_S =                                                         \
>      (echo "\#include <linux/kernel.h>" ;                                    \
>       echo "\#include <asm/asm-prototypes.h>" ;                              \
> -     grep EXPORT_SYMBOL $< | sed 's/$$/;/' ) |                              \
> +    $(CPP) $(a_flags) $< |                                                  \
> +     grep ^___EXPORT_SYMBOL |                                               \
> +     sed 's/___EXPORT_SYMBOL \([a-zA-Z0-9_]*\),.*/EXPORT_SYMBOL(\1);/' ) |  \

Is this sed pass necessary? Just add -D__GENKSYMS__ also to the first
cpp run and EXPORT_SYMBOL will stay intact.

Anyway, I'm going to merge your patch 2/2 now.

Michal

>      $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
>      $(GENKSYMS) $(if $(1), -T $(2))                                         \
>       $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
> 

