Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33081 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdC2VYj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 17:24:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170329210322.GJ29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk> <CA+55aFxJ6HnkLzRTwoXRoWMmH4npUmT5S1gSbMges9msXKzuow@mail.gmail.com>
 <20170329210322.GJ29622@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Mar 2017 14:24:37 -0700
Message-ID: <CA+55aFyEQ_naUW6Q+qVoBA24bgBh1=2H+V54k501uV2pKFv+nw@mail.gmail.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.linux@gmail.com>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@mellanox.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Chris Zankel <chris@zankel.net>
Message-ID: <20170329212437.e8_rISKZTUY5a2cpecrbAT1H3bfke7aT2ggBPpRx6eI@z>

On Wed, Mar 29, 2017 at 2:03 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> it's not as if having the possibility to inline them
> would really complicate the generic side of things...

I disagree.

I think one of the biggest problems with our current uaccess.h mess is
just how illegible the header files are, and the
INLINE_COPY_{TO,FROM}_USER thing is not helping.

I think it would be much better if the header file just had

 extern unsigned long _copy_from_user(void *, const void __user *,
unsigned long);

and nothing else. No unnecessary noise.

The same goes for things like [__]copy_in_user() - why is that thing
still inlined? If it was a *macro*, it might be useful due to the
might_fault() thing giving the caller information, but that's not even
the case here, so we'd actually be much better off without any of that
inlining stuff. Do it all in lib/usercopy.c, and move the
might_fault() in there too.

                Linus
