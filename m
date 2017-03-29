From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Wed, 29 Mar 2017 16:43:05 -0700
Message-ID: <CA+55aFzvcU7sNa_qp6pkYau20RwL3UVDw5-dmce0EE1MX7JuKg@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk> <CA+55aFxJ6HnkLzRTwoXRoWMmH4npUmT5S1gSbMges9msXKzuow@mail.gmail.com>
 <20170329210322.GJ29622@ZenIV.linux.org.uk> <CA+55aFyEQ_naUW6Q+qVoBA24bgBh1=2H+V54k501uV2pKFv+nw@mail.gmail.com>
 <20170329230934.GK29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36079 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932829AbdC2XnH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 19:43:07 -0400
In-Reply-To: <20170329230934.GK29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Wed, Mar 29, 2017 at 4:09 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> IMO that's a separate series.  For now I would be bloody happy if we got
>         * arch-dependent asm fixes out of the way
>         * everything consolidated outside of arch/*
>         * arch/*/include/uaccess*.h simplified.

Sure, I agree.

At the same time, I just think that we really *should* aim for a
simpler uaccess.h in the long term, so I would prefer we not encourage
architectures to do things that simply won't matter.

> As for __copy_in_user()... I'm not sure we want to keep it in the long run -

I agree, it's probably not worth it at all.

In fact, I suspect none of the "__copy_.*_user()" versions are worth
it, and we should strive to remove them.

There aren't even that many users, and they _have_ caused security
issues when people have had some path that hasn't checked the range.

                Linus
