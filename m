From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
Date: Wed, 19 Oct 2016 16:50:26 +0200
Message-ID: <24ebaba8-d20c-bc2e-8430-599cab2dbb33@suse.com>
References: <20161015124352.10795-1-npiggin@gmail.com>
 <20161015124352.10795-3-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43753 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942319AbcJSOu3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Oct 2016 10:50:29 -0400
In-Reply-To: <20161015124352.10795-3-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

Hi Nick,

sorry for the late feedback.

Dne 15.10.2016 v 14:43 Nicholas Piggin napsal(a):
> +# .S file exports must have their C prototypes defined in asm/asm-prototypes.h
> +# or a file that it includes, in order to get versioned symbols. We build a
> +# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
> +# the .S file (with trailing ';'), and run genksyms on that, to extract vers.
> +#
> +# These mirror gensymtypes_c and co above, keep them in synch.
> +cmd_gensymtypes_S =                                                         \
> +    (echo "\#include <linux/kernel.h>" ;                                    \
> +     echo "\#include <asm/asm-prototypes.h>" ;                              \
> +     grep EXPORT_SYMBOL $< | sed 's/$$/;/' ) |                              \
> +    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
> +    $(GENKSYMS) $(if $(1), -T $(2))                                         \
> +     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
> +     $(if $(KBUILD_PRESERVE),-p)                                            \
> +     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))

I think it would be cleaner to add the #include to the .S files
themselves and grep for both EXPORT_SYMBOL and #include here. The reason
is that some files might need additional #includes to allow genksyms to
properly expand some function prototypes.

Michal
