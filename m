Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268465AbUHLAwY@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:3814 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268414AbUHLALr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 20:11:47 -0400
Subject: Re: clear_user_highpage()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	 <20040811165307.46ff1eb6.davem@redhat.com>
	 <Pine.LNX.4.58.0408111654440.1839@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1092269196.2166.34.camel@gaston>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 10:06:37 +1000
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


> You didn't read my message. If it doesn't crap on the caches when you do 
> the stores, it _will_ crap on the bus both when you do the stores _and_ 
> when you actually read the page.
> 
> In other words, you will have taken _more_ of a hit later on. It's just 
> that it won't be a nice profile hit, it will be a nasty "everything runs 
> slower later".
> 
> Caches work best when you have good temporal locality. You are removing 
> that locality, and thus you are making your caches _less_ efficient.
> 
> That's a very _fundamental_ argument. 

Ok, that may be why it was removed from ppc then, I should ask Paul.

Ben.
