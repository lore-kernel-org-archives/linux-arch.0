From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Wed, 29 Mar 2017 17:27:40 -0700
Message-ID: <CA+55aFyGwYwdk8i7-GbXV7NLTn38e-bow3VD-hHcQmTr9ebAjw@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk> <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
 <20170329234246.GL29622@ZenIV.linux.org.uk> <09ead054-f62a-76e2-88e0-8d18592d2604@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34426 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbdC3A1m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 20:27:42 -0400
In-Reply-To: <09ead054-f62a-76e2-88e0-8d18592d2604@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <Jonas.Nilsson@synopsys.>

On Wed, Mar 29, 2017 at 5:02 PM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> I guess I can in next day or two - but mind you the inline version for ARC is kind
> of special vs. other arches. We have this "manual" constant propagation to elide
> the unrolled LD/ST for 1-15 byte stragglers, when @sz is constant.

I don't think that's special. We do that on x86 too, and I suspect ARC
copied it from there (or from somebody else who did it).

But at least on x86 is is limited entirely to the "__" versions, and
it's almost entirely pointless. We actually removed some of that kind
of code because it was *do* pointless, and it had just been copied
around into the "atomic" versions too.

See for example commit bd28b14591b9 ("x86: remove more uaccess_32.h
complexity"), which did that.

The basic "__" versions still do that constant-size thing, but they
really are questionable. Exactly because it's just the "__" versions -
the *regular* "copy_to/from_user()" is an unconditional function call,
because inlining it isn't just the access operations, it's the size
check, and on modern x86 it's also the "set AC to mark the user access
as safe".

.. and many distros enable some of the might_sleep() debugging code
etc. With any of that, inlining is simply a *bad* choice.

                  Linus
