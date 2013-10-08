From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 27/29] get_signal_to_deliver: remove regs and cookie args
Date: Tue, 8 Oct 2013 08:52:52 -0700
Message-ID: <20131008155252.GA14080@infradead.org>
References: <1381232179-4385-1-git-send-email-richard@nod.at>
 <1381232179-4385-3-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41580 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab3JHPxO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Oct 2013 11:53:14 -0400
Content-Disposition: inline
In-Reply-To: <1381232179-4385-3-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, vgupta@synopsys.com, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, vapier@gentoo.org, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, yasutake.koichi@jp.panasonic.com, ralf@linux-mips.org, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, lethal@linux-sh.org, cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, linux-xtensa@linux-xtensa.org, akpm@linux-foundation.org, oleg@redhat.com, tj@kernel.org

On Tue, Oct 08, 2013 at 01:36:17PM +0200, Richard Weinberger wrote:
> Both arguments are unused, remove them.

And with the get_signal macro left as the only caller, that one should
become the implementation function.
