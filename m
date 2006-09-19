Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:34945 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751899AbWISLTV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Sep 2006 07:19:21 -0400
Date: Tue, 19 Sep 2006 13:19:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/3] Directed yield take 3.
Message-ID: <20060919111917.GB21713@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: mingo@elte.hu, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-18 at 10:53 -0700, Andrew Morton wrote:
> > nobody has complained about my spinlock yield patches.
> 
> Complain.
> 
> I had to hunt around a bit to discover that this functionality has
> something to do with "giving up the timeslice of a virtual cpu in favour of
> a specific cpu".  And also that it is expected to be of some
> briefly-alluded-to benefit on powerpc.
> 
> So...  Could you please flesh out the description/rationale rather a lot
> and cc linux-kernel on the patches?

Ok here we go, 
added some more beef to the description of patch #1 and replaced the
description of patch #2. Good enough now?
 
-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
