Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268196AbUIGOxS@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268131AbUIGOuY
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Sep 2004 10:50:24 -0400
Date: Tue, 7 Sep 2004 15:50:22 +0100
From: Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040907145022.GI642@parcelfarce.linux.theplanet.co.uk>
References: <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
Sender: <willy@www.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 07, 2004 at 07:40:53AM -0700, Linus Torvalds wrote:
> Now, it will _only_ break systems that are _both_ 64-bit _and_ big-endian. 
> Little-endian or 32-bit boxes will never care.
> 
> So it's ppc64, sparc64, s390x and sh64. I suspect the breakage is 

... and parisc64.  Not that we have 64 bit userland yet either.

> basically zero, since not only aren't there _that_ many machines out 
> there, the percentage of them that use setaffinity or mbind is likely not 
> that high either.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
