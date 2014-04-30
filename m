Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:60532 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933648AbaD3Pie (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Apr 2014 11:38:34 -0400
Received: by mail-we0-f171.google.com with SMTP id w62so995289wes.30
        for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2014 08:38:33 -0700 (PDT)
Date: Wed, 30 Apr 2014 16:38:25 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [RFC PATCH V4 6/7] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
Message-ID: <20140430153824.GA7166@linaro.org>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-7-git-send-email-steve.capper@linaro.org>
 <20140430152047.GF31220@arm.com>
 <20140430153317.GG31220@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140430153317.GG31220@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Message-ID: <20140430153825.FwwWmrVR4Wddp2iDiZdMzN4S9Mt_L3YUbR1MSUrPI40@z>

On Wed, Apr 30, 2014 at 04:33:17PM +0100, Catalin Marinas wrote:
> On Wed, Apr 30, 2014 at 04:20:47PM +0100, Catalin Marinas wrote:
> > On Fri, Mar 28, 2014 at 03:01:31PM +0000, Steve Capper wrote:
> > > In order to implement fast_get_user_pages we need to ensure that the
> > > page table walker is protected from page table pages being freed from
> > > under it.
> > > 
> > > This patch enables HAVE_RCU_TABLE_FREE, any page table pages belonging
> > > to address spaces with multiple users will be call_rcu_sched freed.
> > > Meaning that disabling interrupts will block the free and protect the
> > > fast gup page walker.
> > > 
> > > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> > 
> > While this patch is simple, I'd like to better understand the reason for
> > it. Currently HAVE_RCU_TABLE_FREE is enabled for powerpc and sparc while
> > __get_user_pages_fast() is supported by a few other architectures that
> > don't select HAVE_RCU_TABLE_FREE. So why do we need it for fast gup on
> > arm/arm64 while not all the other archs need it?
> 
> OK, replying to myself. I assume the other architectures that don't need
> HAVE_RCU_TABLE_FREE use IPI for TLB shootdown, hence they gup_fast
> synchronisation for free.

Hi Catalin,
Yes that is roughly the case.
Essentially we want to RCU free the page table backing pages at a
later time when we aren't walking on them.

Other arches use IPI, some others have their own RCU logic. I opted to
activate some existing logic to reduce code duplication.

Cheers,
-- 
Steve

> 
> -- 
> Catalin
