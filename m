From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 6/7] dump_stack: unify debug information printed by show_regs()
Date: Fri, 12 Apr 2013 16:37:18 -0400
Message-ID: <5168707E.6040304@tilera.com>
References: <1365016497-32033-1-git-send-email-tj@kernel.org> <1365016497-32033-7-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:60900 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab3DLUhU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2013 16:37:20 -0400
In-Reply-To: <1365016497-32033-7-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org, rth@twiddle.net, linux@arm.linux.org.uk, msalter@redhat.com, starvik@axis.com, dhowells@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, jonas@southpole.se, rkuo@codeaurora.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, davem@davemloft.net, lethal@linux-sh.org, vgupta@synopsys.com, chris@zankel.net, ysato@users.sourceforge.jp, gxt@mprc.pku.edu.cn, jdike@addtoit.com, Heiko Carstens <heiko.carstens@de.ibm.com>

On 4/3/2013 3:14 PM, Tejun Heo wrote:
> show_regs() is inherently arch-dependent but it does make sense to
> print generic debug information and some archs already do albeit in
> slightly different forms.  This patch introduces a generic function to
> print debug information from show_regs() so that different archs print
> out the same information and it's much easier to modify what's
> printed.
>
> show_regs_print_info() prints out the same debug info as dump_stack()
> does plus task and thread_info pointers.
>
> * Archs which didn't print debug info now do.
>
>   alpha, arc, blackfin, c6x, cris, frv, h8300, hexagon, ia64, m32r,
>   metag, microblaze, mn10300, openrisc, parisc, score, sh64, sparc,
>   um, xtensa
>
> * Already prints debug info.  Replaced with show_regs_print_info().
>   The printed information is superset of what used to be there.
>
>   arm, arm64, avr32, mips, powerpc, sh32, tile, unicore32, x86

Acked-by: Chris Metcalf <cmetcalf@tilera.com> [for tile]

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
