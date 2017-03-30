From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 20:10:09 +0100
Message-ID: <20170330191009.GU29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <20170330162241.GG7909@n2100.armlinux.org.uk>
 <20170330164342.GR29622@ZenIV.linux.org.uk>
 <CA+55aFzsGSKzbQjWAPxFvc=HeXyr6stk1KsB-1xGCKALgazYuQ@mail.gmail.com>
 <20170330184824.GS29622@ZenIV.linux.org.uk>
 <20170330185427.GT29622@ZenIV.linux.org.uk>
 <CA+55aFx2u6iUzJV1ZH4w_o6tTZesSGoOxMrOtJB8aXScou6zPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54102 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934299AbdC3TKS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 15:10:18 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFx2u6iUzJV1ZH4w_o6tTZesSGoOxMrOtJB8aXScou6zPg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Thu, Mar 30, 2017 at 11:59:16AM -0700, Linus Torvalds wrote:

> But regardless of that, I think you're being silly to even look at the
> iovec code. That code simply *isn't* critical enough that one or two
> extra instructions matter.
> 
> Show me profiles to the contrary. I dare you.
> 
> Those things shouldn't be using *anything* odd at all. They should be
> using "copy_from_user()". Nothing else.

That they very definitely should not.  And not because of access_ok() or
might_fault() - this is one place where zero-padding is absolutely wrong.
So unless you are going to take it out of copy_from_user() and pray
that random shit ioctls in random shit drivers check the return value
properly, copy_from_user() is no-go here.
