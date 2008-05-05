From: John Williams <john.williams@petalogix.com>
Subject: RE: [PATCH 07/56] microblaze_v2: Signal support
Date: Tue, 06 May 2008 09:33:56 +1000
Message-ID: <1210030436.5798.148.camel@localhost>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
	 <9a7c6646e5dd9724c1cf34767adec181481fa3ef.1209897266.git.monstr@monstr.eu>
	 <20080505213244.8DC757A0084@mail70-wa4.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:50573 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbYEEXen (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 19:34:43 -0400
In-Reply-To: <20080505213244.8DC757A0084@mail70-wa4.bigfish.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: monstr@seznam.cz, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Mon, 2008-05-05 at 14:32 -0700, Stephen Neuendorffer wrote:
> (multiple places)  can this code (and flush_cache_sigtramp()) go away?
> 
> +#if 0
> +		flush_cache_sigtramp((unsigned long)frame->tramp);
> +#endif

You have to icache_invalidate the sigtramp because you are writing into
memory that will shortly be executed. 

I'm not sure why this is #if'd away in the first place?

John
