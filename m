Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268087AbUHVTwW@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:25986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268085AbUHVTwW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 22 Aug 2004 15:52:22 -0400
Date: Sun, 22 Aug 2004 12:51:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <16672.45037.630064.539644@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0408221245380.17766@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040812004654.GX11200@holomorphy.com>
 <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org> <20040813144115.4c59a2f0.davem@redhat.com>
 <16672.45037.630064.539644@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Mon, 16 Aug 2004, David Mosberger wrote:
> 
> Very interesting. I tried something similar on a dual 1.5GHz Itanium
> 2.  I tried two versions of clear_page: one with .nta (no-temporal
> affinity hint, which is the default) and one without.  The result for
> 5 runs of a fairly minimal kernel-compile (with make -j8):
> 
> 	with .nta:			without .nta:
> 
> real	80.0 70.2 71.0 70.4 70.3	79.4 69.5 69.5 69.5 69.3
> sys	 4.6  4.6  4.6  4.6  4.5	 5.3  5.4  5.3  5.4  5.4
> 
> Note that the first run was with cold page cache, hence the longer
> runtime.
> 
> So, on average, dropping the .nta costs us 0.78 seconds of kernel-time
> but, overall, the kernel-builds complete about 0.94 seconds faster.

I obviously love the result, since it validates my theory that it's better
to have a nice hot "clear_page()" and avoid cache misses elsewhere. Score
one for WAGging.

That said, I suspect it does so exactly because the Itanium 2 has largish
caches, and it's likely that smaller (or external, slower) caches or other 
loads will see different behaviour.

My basic point stands: hotspots in profiling are NOT automatically a sign 
of anything bad. I'd rather have hotspots where you can say "this is an 
important function" than try to smush the costs out. I personally prefer a 
profile that clearly shows where the work is being done to one that has 
most of the costs in a long tail of random functions.

		Linus
