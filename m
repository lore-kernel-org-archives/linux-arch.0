Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:19652 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1751476AbWCWR5i (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Mar 2006 12:57:38 -0500
Date: Thu, 23 Mar 2006 09:21:14 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
Message-ID: <20060323142114.GA612@quicksilver.road.mcmartin.ca>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323164623.699f569e.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 23, 2006 at 04:46:23PM +1100, Stephen Rothwell wrote:
> We had a copy of the compatibility version of struct timex in each 64 bit
> architecture.  This patch just creates a global one and replaces all the
> usages of the old ones.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>

Looks good.

Acked-by: Kyle McMartin <kyle@parisc-linux.org>  
