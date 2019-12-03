Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:34613 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfLCJMe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Dec 2019 04:12:34 -0500
Subject: Re: [PATCH 0/9] Improve boot command line handling
From: Christophe Leroy <christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
Message-ID: <8eb90163-0e6b-c5ee-179a-c20773d54e58@c-s.fr>
Date: Tue, 3 Dec 2019 10:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20191203091232.prNVXEQmtd2ss4ti3qBDBOEpLDE6DmPc60KWTWX1dX0@z>



Le 02/04/2019 à 11:08, Christophe Leroy a écrit :
> The purpose of this series is to improve and enhance the
> handling of kernel boot arguments.
> 
> It is first focussed on powerpc but also extends the capability
> for other arches.
> 
> This is based on suggestion from Daniel Walker <danielwa@cisco.com>

Looks like nobody has been interested in that series.

It doesn't apply anymore and I don't plan to rebase it, I'll retire it.

Christophe


> 
> Christophe Leroy (9):
>    powerpc: enable appending of CONFIG_CMDLINE to bootloader's cmdline.
>    Add generic function to build command line.
>    drivers: of: use cmdline building function
>    powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
>    powerpc: convert to generic builtin command line
>    Add capability to prepend the command line
>    powerpc: add capability to prepend default command line
>    Gives arches opportunity to use generically defined boot cmdline
>      manipulation
>    powerpc: use generic CMDLINE manipulations
> 
>   arch/powerpc/Kconfig                   | 23 ++------------
>   arch/powerpc/kernel/prom_init.c        | 38 ++++++++++-------------
>   arch/powerpc/kernel/prom_init_check.sh |  2 +-
>   drivers/of/fdt.c                       | 23 +++-----------
>   include/linux/cmdline.h                | 37 ++++++++++++++++++++++
>   init/Kconfig                           | 56 ++++++++++++++++++++++++++++++++++
>   6 files changed, 117 insertions(+), 62 deletions(-)
>   create mode 100644 include/linux/cmdline.h
> 
