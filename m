Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:61991 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754273AbeDTKCj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Apr 2018 06:02:39 -0400
Subject: Re: [PATCH 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling for
 powerpc
References: <20180420073414.23169-1-npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <099a9e24-6881-48fd-3db3-4fe3132372e4@c-s.fr>
Date: Fri, 20 Apr 2018 12:02:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180420073414.23169-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Message-ID: <20180420100237.4DaCsIro_j1xs2yYDJPkt7zeuJ3tgz-4qU9uTXroEQU@z>



Le 20/04/2018 à 09:34, Nicholas Piggin a écrit :
> A few people have been interested in this again. And I promised
> if it remains dead code it should be removed, so I would like to
> have another try.
> 
> I think I got snagged on the modules problem last time and did
> not take the time to work it out, this time I just turned off the
> compile options for modules (the linker option was never set anyway
> so no loss).
> 
> This includes some linker script catches and ideas from others, I
> didn't documnt them all, but thanks for looking.

Thanks a lot.

It works well on both my 8xx and 83xx targets. I don't have 
CONFIG_MODULE set.

Christophe

> 
> I would be interested to help other archs get this working too, if
> anybody needs some help.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    kbuild: Fix asm-generic/vmlinux.lds.h for
>      LD_DEAD_CODE_DATA_ELIMINATION
>    kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
>      -ffunction-sections/-fdata-sections for module build
>    kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if
>      enabled
>    powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected
> 
>   Makefile                          |  4 +--
>   arch/Kconfig                      | 15 ----------
>   arch/powerpc/Kconfig              |  1 +
>   arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++-------
>   include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
>   init/Kconfig                      | 27 +++++++++++++++++
>   6 files changed, 70 insertions(+), 48 deletions(-)
> 
