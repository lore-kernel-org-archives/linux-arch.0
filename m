From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 11:59:16 -0700
Message-ID: <CA+55aFx2u6iUzJV1ZH4w_o6tTZesSGoOxMrOtJB8aXScou6zPg@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <20170330162241.GG7909@n2100.armlinux.org.uk>
 <20170330164342.GR29622@ZenIV.linux.org.uk> <CA+55aFzsGSKzbQjWAPxFvc=HeXyr6stk1KsB-1xGCKALgazYuQ@mail.gmail.com>
 <20170330184824.GS29622@ZenIV.linux.org.uk> <20170330185427.GT29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33473 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbdC3S7S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 14:59:18 -0400
In-Reply-To: <20170330185427.GT29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Thu, Mar 30, 2017 at 11:54 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Not even that - again, it will happily trigger page faults unless the
> caller disables those.  __copy_from_user_I_know_what_I_am_doing()?

That's a horrible name. Everybody always thinks they know what they are doing.

There's a reason I called the new odd user access functions
"unsafe_get/put_user()"

But regardless of that, I think you're being silly to even look at the
iovec code. That code simply *isn't* critical enough that one or two
extra instructions matter.

Show me profiles to the contrary. I dare you.

Those things shouldn't be using *anything* odd at all. They should be
using "copy_from_user()". Nothing else.

                   Linus
