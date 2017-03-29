From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Wed, 29 Mar 2017 13:37:30 -0700
Message-ID: <CA+55aFxJ6HnkLzRTwoXRoWMmH4npUmT5S1gSbMges9msXKzuow@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329202939.GI29622@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 29, 2017 at 1:29 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, I wonder if inlining all of the copy_{to,from}_user() is actually a win.

I would suggest against it.

The only part I think is worth inlining is the compile time size
checks for kasan - and that only because of the obvious "sizes are
constant only when inlining" issue.

We used to inline a *lot* of user accesses historically, pretty much
all of them were bogus.

The only ones that really want inlining are the non-checking ones that
people should never use directly, but that are just helper things used
by other routines (ie the "unsafe_copy_from_user()" kind of things
that are designed for strncpy_from_user()).

Once you start checking access ranges, and have might_fault debugging
etc, it shouldn't be inlined.

              Linus
