From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Wed, 29 Mar 2017 14:14:22 -0700
Message-ID: <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329202939.GI29622@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <Jona>
List-Id: linux-arch.vger.kernel.org

On 03/29/2017 01:29 PM, Al Viro wrote:
> On Wed, Mar 29, 2017 at 01:08:12PM -0700, Vineet Gupta wrote:
> 
>> Hi Al,
>>
>> Thx for taking this up. It seems ARC was missing INLINE_COPY* switch likely due to
>> existing 2 variants (inline/out-of-line) we already have.
>> I've added a patch for that (attached too) - boot tested the series on ARC.
> 
> BTW, I wonder if inlining all of the copy_{to,from}_user() is actually a win.

Just to be clear, your series was doing this for everyone.

> It's probably arch-dependent and it would be nice if somebody compared
> performance with and without inlining those...  ARC, in particular, has
> __arc_copy_{to,from}_user() inlining a whole lot, even in case of non-constant
> size and your patch, AFAICS, will inline all of it in *all* cases. 

Yes we do inline all of it: the non-constant case is actually simpler, it is a
simple byte loop.

		"	mov.f   lp_count, %0		\n"
		"	lpnz 3f				\n"
		"	ldb.ab  %1, [%3, 1]		\n"
		"1:	stb.ab  %1, [%2, 1]		\n"
		"	sub     %0, %0, 1		\n"

Doing it out of line (3 args) will be 4 instructions anyways.

For constant size, there's laddered copy for blocks of 16 bytes + stragglers 1-15.
We do "manual" constant propagation there to compile time optimize away the
straggler part. But yes all of this is emitted inline.


> It might
> end up being a win, but that's not apriori obvious...  Do you have any
> profiling results in that area?

Unfortunately not at the moment. The reason for adding out-of-line variant was not
so much as performance but to improve the footprint for -Os case (some customer I
think).
