From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/3] string: provide strscpy() and strscpy_truncate()
Date: Thu, 7 May 2015 12:00:34 +0300
Message-ID: <20150507090034.GV16501@mwanda>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
 <1430409677-13284-3-git-send-email-cmetcalf@ezchip.com>
 <20150506150140.GB12986@mwanda>
 <554A3161.3030609@ezchip.com>
 <20150506155951.GS16501@mwanda>
 <CAMuHMdUuaRGn10_k+Gm7vG5P_=QfSw7Mao3oB_u2Poy=PeiGtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48665 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbbEGJBk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2015 05:01:40 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdUuaRGn10_k+Gm7vG5P_=QfSw7Mao3oB_u2Poy=PeiGtg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, May 06, 2015 at 06:45:56PM +0200, Geert Uytterhoeven wrote:
> On Wed, May 6, 2015 at 5:59 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > We actually do have a __must_check tag so it's easy enough to force
> > people to check.  A different option is we could make it trigger a
> 
> People tend to ignore compiler warnings...

We're doing a lot better these days with zero day build testing.  There
is not even one ignored __must_check return in my allmodconfig.

> 
> > WARN_ONCE().
> >
> > #define strXcpy(dest, src, len) (({                             \
> >         ssize_t __ret = strscpy_truncate(dest, src, len);       \
> >         WARN_ONCE(__ret < 0, "strXcpy trancates\n");            \
> >         __ret; }))
> 
> Which will probably trigger only in extreme cases in the wild, not during
> development.

It's less subtle than just putting an empty string there so we're more
likely to get bug reports than with the original code.

regards,
dan carpenter
