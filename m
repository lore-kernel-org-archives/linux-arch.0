Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from holomorphy.com ([66.93.40.71]:49627 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1030290AbWHYAPB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Aug 2006 20:15:01 -0400
Date: Thu, 24 Aug 2006 17:14:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060825001459.GE3580@holomorphy.com>
References: <20060824234445.6B519D52@localhost.localdomain> <20060824235806.GD3580@holomorphy.com> <1156464441.12011.151.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156464441.12011.151.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2006-08-24 at 16:58 -0700, William Lee Irwin III wrote:
>> You can't be serious.
>> Stuffing incomplete tables of logarithms in mm/Kconfig is not the way.

On Thu, Aug 24, 2006 at 05:07:21PM -0700, Dave Hansen wrote:
> It may be crazy, but it is crazy enough for at least three architectures
> to do it this way, already.  I'd rather consolidate the insanity all in
> one place than have it spread far and wide.  Have a gander at
> arch/{parisc,ia64,sparc64}/Kconfig.
> I'd be glad to fill make the table more complete if it helps.  Do you
> have any ideas how it might be done more elegantly?

With CONFIG_PAGE_SHIFT there doesn't need to be a CONFIG_PAGE_SIZE at
all; just let #define PAGE_SIZE (1 << PAGE_SHIFT) handle it.


-- wli
