From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 13:59:58 -0700
Message-ID: <CA+55aFyQL75SOyx=zn1zWvy+TS-Ockv=O9Q59b_ZQwSeCh7WnQ@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk> <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
 <20170329234246.GL29622@ZenIV.linux.org.uk> <09ead054-f62a-76e2-88e0-8d18592d2604@synopsys.com>
 <CA+55aFyGwYwdk8i7-GbXV7NLTn38e-bow3VD-hHcQmTr9ebAjw@mail.gmail.com> <efb7aaa4-7d25-0c68-ebf8-cdd7eb1297dc@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33309 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdC3VAA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 17:00:00 -0400
In-Reply-To: <efb7aaa4-7d25-0c68-ebf8-cdd7eb1297dc@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <Jonas.Nilsson@synopsys.>

On Thu, Mar 30, 2017 at 1:40 PM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> So it's a mix bag really. Maybe we need some better directed test to really drill
> it down.

As mentioned inn the discussion about ARM, I seriously doubt that the
inlining will even be noticeable compared to other effects here.

The cases where I've seen this matter have been the small
constant-sized copies, and in every case the right fix was to use
"get_user()" instead of "copy_from_user()".

There are a couple of really special cases that can show up where
there's a slightly bigger and more complex case that still is
meaningful: the most noticeable of those being "stat()".

> So what you are saying is it is relatively costly on x86 because of SMAP which may
> not be true for arches w/o hardware support.
> Note that I'm not arguing for/against inlining per-se, it seems it doesn't matter

So on x86 (and ARM) we have the SMAP/UAO issue, and on other
architectures we have another expense entirely: maintenance and
testing.

(On ARM, hopefully the UAO bit is faster to set, but it's still
"another instruction before and after", so even if it's not as
expensive as clac/stac are on current x86 chips, it's an argument
against inlining)

And on the maintenance and testing side, it means that unless some
header organization makes sense on x86 or ARM (or power), it likely
doesn't make sense to try to tweak for any other architecture.

Or at the very least it would have to be a _really_ big and noticeable
issue, not something that might be hard/impossible to even measure.

                Linus
