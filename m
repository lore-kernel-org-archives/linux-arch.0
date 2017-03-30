From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 02:15:17 +0100
Message-ID: <20170330011517.GM29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
 <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
 <20170329234246.GL29622@ZenIV.linux.org.uk>
 <09ead054-f62a-76e2-88e0-8d18592d2604@synopsys.com>
 <CA+55aFyGwYwdk8i7-GbXV7NLTn38e-bow3VD-hHcQmTr9ebAjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54250 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933103AbdC3BPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 21:15:38 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyGwYwdk8i7-GbXV7NLTn38e-bow3VD-hHcQmTr9ebAjw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <Jonas.Nilsson@s>

On Wed, Mar 29, 2017 at 05:27:40PM -0700, Linus Torvalds wrote:

> The basic "__" versions still do that constant-size thing, but they
> really are questionable. Exactly because it's just the "__" versions -
> the *regular* "copy_to/from_user()" is an unconditional function call,
> because inlining it isn't just the access operations, it's the size
> check, and on modern x86 it's also the "set AC to mark the user access
> as safe".

Keep in mind that come architectures have __copy_from_user() (well,
raw_copy_from_user(), now) used in __get_user().  This is a bad idea
for a lot of reasons, and it needs to be taken care of, but I really
don't want to mix __get_user()/__put_user() stuff (there's a lot
of boilerplate in that area as well) into this series.

Infrastructure for that would have to go into the uaccess.stem, and that
would pretty much guarantee that it wouldn't get into no-rebase mode for
extra couple of weeks.  As it is, uaccess.<arch> are on top of no-rebase
branch, so once architecture maintainers are happy with what's in it,
we can put it in no-rebase mode and have it pulled into that architecture's
tree.  That way we can avoid any merge conflicts; fighting the conflicts
between vfs.git and random growing set of architecture trees, all the way
through -next into the merge window... <shudder>

For even more fun, there's VFS (well, fs, actually - it's in ->write_end()
instances) work depending on the __copy_from_user_inatomic() not zero-padding
anything on short copy.  With the set of potential conflicts of its own,
with individual fs trees... ;-/
