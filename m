Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268090AbUI1XQD@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39577 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268088AbUI1XQD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Sep 2004 19:16:03 -0400
Subject: Re: [PATCH] ppc64: Fix 32 bits conversion of SI_TIMER signals
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040928152210.1550b3c3.davem@davemloft.net>
References: <200409260205.i8Q25pGb013827@hera.kernel.org>
	 <1096181913.18234.300.camel@gaston>
	 <20040928152210.1550b3c3.davem@davemloft.net>
Content-Type: text/plain
Message-Id: <1096413218.20202.15.camel@gaston>
Mime-Version: 1.0
Date: Wed, 29 Sep 2004 09:13:38 +1000
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-09-29 at 08:22, David S. Miller wrote:
> Ben, have you taken a quick look to see if any other
> platforms doing compat stuff need a fix like this as
> well?  If not, could you do so real quick?  Thanks.

Olaf signaled me some other failures of glibc make check, so I
need to spend more time on that. 

As far as SI_TIMER is concerned, I first copied the sparc64 "fix" and it
appeared to be wrong, I'm not sure at this point if it's a different
alignement of the int and the void * in the union or if the sparc fix
was just wrong in the first place.

Ben.
