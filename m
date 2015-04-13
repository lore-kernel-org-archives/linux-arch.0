From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 23/24] arch: Remove exec_domain from remaining archs
Date: Mon, 13 Apr 2015 10:19:15 +0200
Message-ID: <20150413081915.GT26081@axis.com>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
 <1428785283-20501-24-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:53514 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbbDMITW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Apr 2015 04:19:22 -0400
Content-Disposition: inline
In-Reply-To: <1428785283-20501-24-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jespern@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.orgole

On Sat, Apr 11, 2015 at 10:48:02PM +0200, Richard Weinberger wrote:
> Signed-off-by: Richard Weinberger <richard@nod.at>
>  arch/cris/arch-v10/kernel/signal.c      | 2 --
>  arch/cris/arch-v32/kernel/signal.c      | 2 --
>  arch/cris/include/asm/thread_info.h     | 2 --

For the CRIS parts:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
