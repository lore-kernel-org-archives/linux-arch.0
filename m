Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33774 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754935AbdDDU1C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2017 16:27:02 -0400
Date: Tue, 4 Apr 2017 13:26:29 -0700
From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Message-ID: <20170404202629.GA31611@octofox.metropolis>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.linux@gmail.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@mellanox.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Chris Zankel <chris@zankel.net>
Message-ID: <20170404202629.KaOBn8YrPHSyYKV9Qmi3xoKCBdPWIY9cqr_o2mXRDXI@z>

On Wed, Mar 29, 2017 at 06:57:06AM +0100, Al Viro wrote:
> I hope that infrastructure part is stable enough to put it into never-rebased
> state.  Some of per-architecture branches might be even done right; however,
> most of them got no testing whatsoever, so any help with testing (as well
> as "Al, for fuck sake, dump that garbage of yours, here's the correct patch"
> from maintainers) would be very welcome.  So would the review, of course.

For the xtensa part:
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

I believe that the xtensa part needs the following correction:

---8<---
