From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 5/7] ARM: oprofile: Move non-ARM code into separate
 init/exit
Date: Sat, 9 Oct 2010 03:51:18 +0200
Message-ID: <20101009015118.GN13563@erda.amd.com>
References: <cover.1286584677.git.matt@console-pimps.org>
 <0de9eda11dbfe9c21348da07b57f04f35cd9effc.1286584677.git.matt@console-pimps.org>
 <20101009012647.GM13563@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:16583
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760052Ab0JIBwA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2010 21:52:00 -0400
Content-Disposition: inline
In-Reply-To: <20101009012647.GM13563@erda.amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>

On 09.10.10 03:26:47, Robert Richter wrote:
> There is a compile breakage caused by patch #4. Will move the renames
> to patch #4 when applying the patch.

(For some reason I did not receive your mail 0/7, so I reply here.)

Matt,

on the first glance you patches are looking good (the above is the
only thing I found). Will do some further testing and waiting for more
replies. If all goes well I am going to apply them.

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
