From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] pci/of: Match PCI devices to OF nodes dynamically
Date: Fri, 08 Apr 2011 09:22:23 +1000
Message-ID: <1302218543.2458.48.camel@pasglop>
References: <20110407.152707.39195948.davem@davemloft.net>
	 <20110407.152937.59699180.davem@davemloft.net>
	 <20110407.153121.115952367.davem@davemloft.net>
	 <20110407.155247.260074665.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55866 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab1DGXWf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 7 Apr 2011 19:22:35 -0400
In-Reply-To: <20110407.155247.260074665.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bheglaas@google.com, monstr@monstr.eu, tglx@linuxtronix.de, bigeasy@linuxtronix.de

On Thu, 2011-04-07 at 15:52 -0700, David Miller wrote:
> > I don't think it's a good idea to mix the things you're trying to do
> > with all of the existing stuff in of_pci.c, why not create a new
> file
> > for the stuff you're trying to consolidate?
> 
> Something like the following could be done to your first patch.
> 
> My sparc64 machine boots up properly with this change added to your
> patch series:

Ok, thanks for testing !

Grant, do you prefer this or that I move the function to
drivers/pci/of.c ?

Cheers,
Ben.
