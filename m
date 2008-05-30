From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 07/37] block: use get/put_endian helpers
Date: Fri, 30 May 2008 09:22:21 +0200
Message-ID: <20080530072220.GG25504@kernel.dk>
References: <1212092287.28403.109.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:4868 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280AbYE3HWX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 03:22:23 -0400
Content-Disposition: inline
In-Reply-To: <1212092287.28403.109.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, May 29 2008, Harvey Harrison wrote:
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  drivers/block/cciss.c     |   11 +++++------
>  drivers/block/paride/pd.c |    8 ++++----
>  drivers/block/ub.c        |    4 ++--
>  drivers/cdrom/cdrom.c     |    2 +-
>  4 files changed, 12 insertions(+), 13 deletions(-)

What is the point of this? I'm honestly asking, what is the grand idea
behind changing eg be32_to_cpu() to get_be32()?

-- 
Jens Axboe
