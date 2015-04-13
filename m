From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 23/24] arch: Remove exec_domain from remaining archs
Date: Mon, 13 Apr 2015 18:57:33 +0200
Message-ID: <20150413165733.GE2040@samfundet.no>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
 <1428785283-20501-24-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:43644 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbbDMQ6O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2015 12:58:14 -0400
Content-Disposition: inline
In-Reply-To: <1428785283-20501-24-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.comh

Around Sat 11 Apr 2015 22:48:02 +0200 or thereabout, Richard Weinberger wrote:
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/alpha/include/asm/thread_info.h    | 2 --
>  arch/avr32/include/asm/thread_info.h    | 3 ---
>  arch/avr32/kernel/asm-offsets.c         | 1 -

For the AVR32 related bits.

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

>  arch/c6x/include/asm/thread_info.h      | 2 --
>  arch/cris/arch-v10/kernel/signal.c      | 2 --
>  arch/cris/arch-v32/kernel/signal.c      | 2 --
>  arch/cris/include/asm/thread_info.h     | 2 --
>  arch/hexagon/include/asm/thread_info.h  | 2 --
>  arch/ia64/include/asm/thread_info.h     | 2 --
>  arch/metag/include/asm/thread_info.h    | 2 --
>  arch/metag/kernel/irq.c                 | 2 --
>  arch/mips/include/asm/thread_info.h     | 2 --
>  arch/mips/kernel/asm-offsets.c          | 1 -
>  arch/nios2/include/asm/thread_info.h    | 2 --
>  arch/openrisc/include/asm/thread_info.h | 2 --
>  arch/openrisc/kernel/signal.c           | 2 --
>  arch/parisc/include/asm/thread_info.h   | 2 --
>  arch/parisc/kernel/asm-offsets.c        | 1 -
>  arch/powerpc/include/asm/thread_info.h  | 2 --
>  arch/score/include/asm/thread_info.h    | 2 --
>  arch/score/kernel/asm-offsets.c         | 1 -
>  21 files changed, 39 deletions(-)

<snipp diff>

-- 
BR, HcE
