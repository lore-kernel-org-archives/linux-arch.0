Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268756AbUIGW4h@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:47553 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268751AbUIGW4B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 18:56:01 -0400
Date: Tue, 7 Sep 2004 15:55:30 -0700
From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040907155530.5008c02c.pj@sgi.com>
In-Reply-To: <20040907214408.GB27284@linux-mips.org>
References: <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
	<20040904204850.48b7cfbd.pj@sgi.com>
	<Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
	<20040904211749.3f713a8a.pj@sgi.com>
	<20040904215205.0a067ab8.pj@sgi.com>
	<20040906182330.GA79122@muc.de>
	<Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
	<20040906141142.663941fb.pj@sgi.com>
	<Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
	<20040907144936.GD20981@wotan.suse.de>
	<20040907214408.GB27284@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: ak@suse.de, torvalds@osdl.org, ak@muc.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Ralf wrote:
> Same situation here for mips64.  sched_setaffinity() is established and
> being used in applications, including commercial products so changing is
> not an option. 

Well ... not an option unless Linus makes it one.  It would be a win
in the long term, I think.  We could introduce a new system call, and
mark this one for eventual removal.

Meanwhile, if sched_setaffinity() is being used in products we can't
really test, then that seems to me to be one more good reason to back
out the API tweaking that Andi and Linus have been doing to it this
last week, and just leave it be, as it was a week ago.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
