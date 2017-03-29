From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 00:42:46 +0100
Message-ID: <20170329234246.GL29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
 <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:52646 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbdC2Xm4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 19:42:56 -0400
Content-Disposition: inline
In-Reply-To: <32129bc4-0e0a-c21d-0e94-67f73a09ac6e@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <Jonas.Nils>

On Wed, Mar 29, 2017 at 02:14:22PM -0700, Vineet Gupta wrote:

> > BTW, I wonder if inlining all of the copy_{to,from}_user() is actually a win.
> 
> Just to be clear, your series was doing this for everyone.

Huh?  It's just that most of architectures *were* inlining that;
arc change was unintentional (copy_from_user/copy_to_user went
uninlined, which your patch deals with), but it's not that I'm forcing
inlining on every architecture out there.

> > It might
> > end up being a win, but that's not apriori obvious...  Do you have any
> > profiling results in that area?
> 
> Unfortunately not at the moment. The reason for adding out-of-line variant was not
> so much as performance but to improve the footprint for -Os case (some customer I
> think).

Just to make it clear - I'm less certain than Linus that uninlined is uniformly
better, but I have a strong suspicion that on most architectures it *is*.
And not just in terms of kernel size - I would expect better speed as well.
The only reason why these knobs are there is that I want to separate the
"who should switch to uninlined" from this series and allow for the possibility
that for some architectures inlined will really turn out to be better.
I do _not_ expect that there'll be many of those; if it turns out that there's
none, I'll be only glad to make the guts of copy_{to,from}_user() always
out of line.

IOW your patch reverts an unintentional change of behaviour, but I really
wonder if that (out-of-line guts of copy_{to,from}_user) isn't an overall
win for arc.  I've applied your patch, but it would be nice if you could
arrange for testing with and without inlining and post the results.  The
same goes for all architectures; again, I would expect out-of-line to end up
a win on most of them.
