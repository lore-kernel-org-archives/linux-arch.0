Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268169AbUJCVtA@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14773
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268166AbUJCVtA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 3 Oct 2004 17:49:00 -0400
Date: Sun, 3 Oct 2004 14:46:46 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ppc64: Fix 32 bits conversion of SI_TIMER signals
Message-Id: <20041003144646.2103291a.davem@davemloft.net>
In-Reply-To: <1096413218.20202.15.camel@gaston>
References: <200409260205.i8Q25pGb013827@hera.kernel.org>
	<1096181913.18234.300.camel@gaston>
	<20040928152210.1550b3c3.davem@davemloft.net>
	<1096413218.20202.15.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 29 Sep 2004 09:13:38 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> As far as SI_TIMER is concerned, I first copied the sparc64 "fix" and it
> appeared to be wrong, I'm not sure at this point if it's a different
> alignement of the int and the void * in the union or if the sparc fix
> was just wrong in the first place.

Ok, I'm now using the same code as ppc64 on sparc64.
Thanks for working on this and explaining things.
