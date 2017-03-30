From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 11:56:33 -0700
Message-ID: <CA+55aFz_2H4sqx219hxRnTFXb8vKXdfHF_C0kjWhvCCm9khb3w@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <20170330162241.GG7909@n2100.armlinux.org.uk>
 <20170330164342.GR29622@ZenIV.linux.org.uk> <CA+55aFzsGSKzbQjWAPxFvc=HeXyr6stk1KsB-1xGCKALgazYuQ@mail.gmail.com>
 <20170330184824.GS29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170330184824.GS29622@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 30, 2017 at 11:48 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> This is not going into the tree - it's just a "let's check your
> theory about might_fault() overhead being the source of slowdown
> you are seeing" quick-and-dirty patch.

Note that for cached hdparm reads, I suspect a *much* bigger effects
than the fairly cheap might_fault() tests is just the random layout of
the data in the page cache.

Memory is just more expensive than CPU is.

The precise physical address that gets allocated for the page cache
entries ends up mattering, and is obviously fairly "sticky" within one
reboot (unless you have a huge working set and that flushes it, or you
use something like

    echo 3 > /proc/sys/vm/drop_caches

to flush filesystem caches manually).

The reason things like page allocation matter for performance testing
is simply that the CPU caches are physically indexed (the L1 might not
be, but outer levels definitely are), and so page allocation ends up
impacting caching unless you have very high associativity.

And even if your workload doesn't fit in your CPU caches (I'd hope
that the "cached" hdparm is still doing a fairly big area), you'll
still see memory performance depend on physical addresses.

Doing kernel performance testing without rebooting several times is
generally very hard.

                   Linus
