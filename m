Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36818
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030202AbWCWISE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Mar 2006 03:18:04 -0500
Date: Thu, 23 Mar 2006 00:17:25 -0800 (PST)
Message-Id: <20060323.001725.98089946.davem@davemloft.net>
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060323174719.6d4387ff.sfr@canb.auug.org.au>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
	<buofyl9llau.fsf@dhapc248.dev.necel.com>
	<20060323174719.6d4387ff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: sfr@canb.auug.org.au
Cc: miles@gnu.org, miles.bader@necel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 23 Mar 2006 17:47:19 +1100

> On Thu, 23 Mar 2006 15:36:25 +0900 Miles Bader <miles.bader@necel.com> wrote:
> >
> > BTW, why not keep use the parisc version of the structure for the common
> > version, as it has comments for each field (not world breaking, but a
> > nice little thing)?
> 
> I figured if you wanted to understand the structure, you could look at the
> real struct timex.

Agreed.

I'm fine with these timex compat patches.
