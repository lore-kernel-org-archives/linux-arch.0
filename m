Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267702AbUHaKNA@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:9676 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267725AbUHaKNA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Aug 2004 06:13:00 -0400
Date: Tue, 31 Aug 2004 20:09:24 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: domain setup in 2.6.9rc1-bk6
Message-ID: <20040831100924.GI26072@krispykreme>
References: <m3llfvk4vh.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3llfvk4vh.fsf@averell.firstfloor.org>
To: Andi Kleen <ak@muc.de>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> Problem is that I need a architecture specific hook to 
> turn off SMT idle for AMD dual core CPUs, which otherwise
> look like SMT siblings. I suppose I will do more tunings
> in this area in the future anyways, so having it in the 
> architecture would be better.

From a ppc64 perspective I liked the merging of the domains code.

We could have the ability to override generic domain setup per
architecture but leave all the default stuff in there.

Anton
