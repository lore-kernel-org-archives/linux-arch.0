Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12227
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751337AbWAIUut (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jan 2006 15:50:49 -0500
Date: Mon, 09 Jan 2006 12:51:00 -0800 (PST)
Message-Id: <20060109.125100.44834738.davem@davemloft.net>
Subject: Re: Adding compat_ptrace_request
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060109230017.6ca9aed6.sfr@canb.auug.org.au>
References: <20060109065914.GS26499@krispykreme>
	<20060109.010355.69867251.davem@davemloft.net>
	<20060109230017.6ca9aed6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: sfr@canb.auug.org.au
Cc: anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 9 Jan 2006 23:00:17 +1100

> On Mon, 09 Jan 2006 01:03:55 -0800 (PST) "David S. Miller" <davem@davemloft.net> wrote:
> >
> > > +		return copy_siginfo_to_user32(data, &lastinfo);
> > 
> > It would be nice to rename this copy_siginfo things to not
> > have "32" and instead "compat" in their names.
> 
> I agree entirely.  Can I do that as a separate patch on top of this one?

Do it seperately if you like.
