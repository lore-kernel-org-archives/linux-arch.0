From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Wed, 29 Mar 2017 22:03:23 +0100
Message-ID: <20170329210322.GJ29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
 <CA+55aFxJ6HnkLzRTwoXRoWMmH4npUmT5S1gSbMges9msXKzuow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxJ6HnkLzRTwoXRoWMmH4npUmT5S1gSbMges9msXKzuow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 29, 2017 at 01:37:30PM -0700, Linus Torvalds wrote:
> On Wed, Mar 29, 2017 at 1:29 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > BTW, I wonder if inlining all of the copy_{to,from}_user() is actually a win.
> 
> I would suggest against it.
> 
> The only part I think is worth inlining is the compile time size
> checks for kasan - and that only because of the obvious "sizes are
> constant only when inlining" issue.
> 
> We used to inline a *lot* of user accesses historically, pretty much
> all of them were bogus.
> 
> The only ones that really want inlining are the non-checking ones that
> people should never use directly, but that are just helper things used
> by other routines (ie the "unsafe_copy_from_user()" kind of things
> that are designed for strncpy_from_user()).
> 
> Once you start checking access ranges, and have might_fault debugging
> etc, it shouldn't be inlined.

FWIW, that's why I'd put those knobs (INLINE_COPY_{TO,FROM}_USER) in there;
if for some architectures making those inlined is really a win, they can
request the inlining; for now I'd mostly set them to match what architectures
had been doing, but I also strongly suspect that in a lot of cases that
inlining is counterproductive.  Building it both ways is simply a matter of
deleting those two lines in asm/uaccess.h in question, and if testing
shows that out-of-line works better on given architecture, well... 

I would expect that the final variant will have those remain only on a few
architectures.  IMO decision whether to inline them or not is up to
architecture - it's not as if having the possibility to inline them
would really complicate the generic side of things...
