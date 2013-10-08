From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 28/29] tracehook_signal_handler: Remove sig, info, ka and
 regs
Date: Tue, 8 Oct 2013 16:45:20 +0100
Message-ID: <20131008154520.GD13318@ZenIV.linux.org.uk>
References: <1381232179-4385-1-git-send-email-richard@nod.at>
 <1381232179-4385-4-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59687 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab3JHPpp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Oct 2013 11:45:45 -0400
Content-Disposition: inline
In-Reply-To: <1381232179-4385-4-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vgupta@synopsys.com, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, vapier@gentoo.org, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, yasutake.koichi@jp.panasonic.com, ralf@linux-mips.org, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, lethal@linux-sh.org, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, linux-xtensa@linux-xtensa.org, akpm@linux-foundation.org, oleg@redhat.com, tj@kernel.org

On Tue, Oct 08, 2013 at 01:36:18PM +0200, Richard Weinberger wrote:
> These parameters are nowhere used, so we can remove them.

I'm not sure it's a good idea...  OTOH, it probably has no business in
tracehook.h anymore - it's only called from signal_delivered(), so if
we decide to insert some ptrace-related work, we can bloody well do it
there these days.  It used to be called all over the place in arch/*,
which made a centralized definition (and getting all potentially relevant
data to it) a lot more important.  So I'd probably suggest killing that
function off completely - signal_delivered() acts as such centralized
location these days.
