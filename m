Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267943AbUHaLeP@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:62102 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267934AbUHaLeP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Aug 2004 07:34:15 -0400
Date: Tue, 31 Aug 2004 13:33:28 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: domain setup in 2.6.9rc1-bk6
Message-ID: <20040831113328.GA11830@wotan.suse.de>
References: <m3llfvk4vh.fsf@averell.firstfloor.org> <20040831100924.GI26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831100924.GI26072@krispykreme>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@muc.de>, nickpiggin@yahoo.com.au, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 31, 2004 at 08:09:24PM +1000, Anton Blanchard wrote:
> 
> > Problem is that I need a architecture specific hook to 
> > turn off SMT idle for AMD dual core CPUs, which otherwise
> > look like SMT siblings. I suppose I will do more tunings
> > in this area in the future anyways, so having it in the 
> > architecture would be better.
> 
> From a ppc64 perspective I liked the merging of the domains code.
> 
> We could have the ability to override generic domain setup per
> architecture but leave all the default stuff in there.

Currently all I want is to disable SD_SHARE_POWER when one flag 
is set. A simple way to do this would be appreciated.

Later overriding would be fine. A simple way to do this would
be to declare it weak.

-Andi
