From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 19:54:27 +0100
Message-ID: <20170330185427.GT29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <20170330162241.GG7909@n2100.armlinux.org.uk>
 <20170330164342.GR29622@ZenIV.linux.org.uk>
 <CA+55aFzsGSKzbQjWAPxFvc=HeXyr6stk1KsB-1xGCKALgazYuQ@mail.gmail.com>
 <20170330184824.GS29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:53610 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933891AbdC3Syd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 14:54:33 -0400
Content-Disposition: inline
In-Reply-To: <20170330184824.GS29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Thu, Mar 30, 2017 at 07:48:24PM +0100, Al Viro wrote:

> BTW, ..._inatomic is a very unfortunate name, IMO - it's *not* safe
> to use in atomic contexts as-is, to start with; the caller needs to take
> care of pagefault_disable().  If anything, __copy_from_user_nofault() would
> probably be better...

Not even that - again, it will happily trigger page faults unless the
caller disables those.  __copy_from_user_I_know_what_I_am_doing()?
