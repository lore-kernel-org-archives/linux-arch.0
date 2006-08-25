Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:1748 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422788AbWHYAHh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Aug 2006 20:07:37 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7P07TQt007877
	for <linux-arch@vger.kernel.org>; Thu, 24 Aug 2006 20:07:29 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7P07RY0208442
	for <linux-arch@vger.kernel.org>; Thu, 24 Aug 2006 18:07:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7P07RCp000649
	for <linux-arch@vger.kernel.org>; Thu, 24 Aug 2006 18:07:27 -0600
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060824235806.GD3580@holomorphy.com>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <20060824235806.GD3580@holomorphy.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:07:21 -0700
Message-Id: <1156464441.12011.151.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2006-08-24 at 16:58 -0700, William Lee Irwin III wrote:
> You can't be serious.
> 
> Stuffing incomplete tables of logarithms in mm/Kconfig is not the way.

It may be crazy, but it is crazy enough for at least three architectures
to do it this way, already.  I'd rather consolidate the insanity all in
one place than have it spread far and wide.  Have a gander at
arch/{parisc,ia64,sparc64}/Kconfig.

I'd be glad to fill make the table more complete if it helps.  Do you
have any ideas how it might be done more elegantly?

-- Dave

