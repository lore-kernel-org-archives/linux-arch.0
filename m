Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268907AbUIHHCI@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:36243 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268899AbUIHHCE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2004 03:02:04 -0400
Date: Wed, 8 Sep 2004 08:58:58 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040908065858.GF27886@wotan.suse.de>
References: <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org> <20040907144936.GD20981@wotan.suse.de> <20040907214408.GB27284@linux-mips.org> <20040907155530.5008c02c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907155530.5008c02c.pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, ak@suse.de, torvalds@osdl.org, ak@muc.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 07, 2004 at 03:55:30PM -0700, Paul Jackson wrote:
> Ralf wrote:
> > Same situation here for mips64.  sched_setaffinity() is established and
> > being used in applications, including commercial products so changing is
> > not an option. 
> 
> Well ... not an option unless Linus makes it one.  It would be a win
> in the long term, I think.  We could introduce a new system call, and
> mark this one for eventual removal.
> 
> Meanwhile, if sched_setaffinity() is being used in products we can't
> really test, then that seems to me to be one more good reason to back
> out the API tweaking that Andi and Linus have been doing to it this
> last week, and just leave it be, as it was a week ago.

The changes me and Linus did do not change anything for these
products. When they pass length == sizeof(cpumask_t) everything 
is ok. The only behaviour change is for cases that would
previously have returned -EINVAL.

-Andi
