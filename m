Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:46242 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750954AbYBTGQs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Feb 2008 01:16:48 -0500
Date: Tue, 19 Feb 2008 22:16:41 -0800
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: linux-next: Tree for Feb 20
Message-ID: <20080220061641.GA23878@puku.stupidest.org>
References: <20080220163457.79b9189f.sfr@canb.auug.org.au> <20080220055055.GC31832@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080220055055.GC31832@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Tue, Feb 19, 2008 at 09:50:55PM -0800, Greg KH wrote:

> What's the best way to constantly follow this tree?  I had cloned it
> a while ago, but now if I 'git pull' it wants to merge things, which
> isn't right.

I would guess:

  $ git remote add linux-next git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
  $ git fetch linux-next

then use the remote branch names when poking about:

  $ git log -p linux-next/master

etc?


Or is there a better way?
