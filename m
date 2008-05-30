From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 07/37] block: use get/put_endian helpers
Date: Fri, 30 May 2008 09:06:59 -0700
Message-ID: <1212163619.28403.189.camel@brick>
References: <1212092287.28403.109.camel@brick>
	 <20080530072220.GG25504@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:61943 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbYE3QHB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 12:07:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3377405wfd.4
        for <linux-arch@vger.kernel.org>; Fri, 30 May 2008 09:07:00 -0700 (PDT)
In-Reply-To: <20080530072220.GG25504@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

On Fri, 2008-05-30 at 09:22 +0200, Jens Axboe wrote:
> On Thu, May 29 2008, Harvey Harrison wrote:
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > ---
> >  drivers/block/cciss.c     |   11 +++++------
> >  drivers/block/paride/pd.c |    8 ++++----
> >  drivers/block/ub.c        |    4 ++--
> >  drivers/cdrom/cdrom.c     |    2 +-
> >  4 files changed, 12 insertions(+), 13 deletions(-)
> 
> What is the point of this? I'm honestly asking, what is the grand idea
> behind changing eg be32_to_cpu() to get_be32()?
> 

It started by introducing a put_be32(val, dest) to cover the idiom:

*(__be32 *)dest = cpu_to_be32(val);

I made put_be32 look like the existing put_unaligned_be32, essentially
adding an aligned helper.

Purely to make a symmetric api, I added the get_be32(ptr) which is
identical to be32_to_cpup (note the p suffix).

As part of this patchset I replaced places like:

be32_to_cpu(*(__be32 *)ptr) -> get_be32((__be32 *)ptr)

My initial version took a void *, but Al Viro requested I keep strict
typechecking, so I made it take a __be32 *.

This is profitable as some arches have an optimized return byte-swapped
from pointer implementation.  I could have just as easily replaced it
with be32_to_cpup.

Cheers,

Harvey
