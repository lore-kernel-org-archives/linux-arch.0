From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Wed, 29 Mar 2017 21:29:39 +0100
Message-ID: <20170329202939.GI29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@sout>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 29, 2017 at 01:08:12PM -0700, Vineet Gupta wrote:

> Hi Al,
> 
> Thx for taking this up. It seems ARC was missing INLINE_COPY* switch likely due to
> existing 2 variants (inline/out-of-line) we already have.
> I've added a patch for that (attached too) - boot tested the series on ARC.

BTW, I wonder if inlining all of the copy_{to,from}_user() is actually a win.
It's probably arch-dependent and it would be nice if somebody compared
performance with and without inlining those...  ARC, in particular, has
__arc_copy_{to,from}_user() inlining a whole lot, even in case of non-constant
size and your patch, AFAICS, will inline all of it in *all* cases.  It might
end up being a win, but that's not apriori obvious...  Do you have any
profiling results in that area?
