Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268807AbUIHA27@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:28822 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268805AbUIHA26 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 20:28:58 -0400
Date: Wed, 8 Sep 2004 10:24:08 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-ID: <20040908002408.GA25278@krispykreme>
References: <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org> <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org> <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com> <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org> <20040906141142.663941fb.pj@sgi.com> <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

 
> Now, it will _only_ break systems that are _both_ 64-bit _and_ big-endian. 
> Little-endian or 32-bit boxes will never care.
> 
> There aren't that many of those machines. I've got one right here (ppc64), 
> but that particular one is guaranteed not to break if only because it's 
> running a 32-bit user space.
> 
> So it's ppc64, sparc64, s390x and sh64. I suspect the breakage is 
> basically zero, since not only aren't there _that_ many machines out 
> there, the percentage of them that use setaffinity or mbind is likely not 
> that high either.

Oh we've felt it all right, both the cpu affinity calls and the numa api 
calls that pass node bitmaps around. I'll resend what patches I
currently have for this.

Anton
