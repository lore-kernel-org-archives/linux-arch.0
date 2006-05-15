Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3201 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965255AbWEOVVZ
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 May 2006 17:21:25 -0400
Date: Mon, 15 May 2006 14:24:31 -0700
From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch] s390 kconfig cleanup.
Message-ID: <20060515212431.GA25010@moss.sous-sol.org>
References: <20060515171645.GA11397@skybase> <200605151930.32241.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605151930.32241.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-ID: <linux-arch.vger.kernel.org>

* Andi Kleen (ak@suse.de) wrote:
> > That is where the arch people get involved. Can we come
> > up with a method how to "tag" all menus in the Kconfig files
> > under drivers/ with a positive list of the architectures
> > that actually want to include the menu/driver? Or even
> > better tag the menu/driver with the bus that is required
> > to attach the device?
> 
> Xen has a similar problem. They currently have tons of ugly negative
> checks too. REAL_HARDWARE or similar is needed there, but it might
> not fit the s390.
> 
> Checking PCI is a good start and should apply to most menus already.

I like the idea of extending this to the bus like PCI already does.
Do you have some examples where this doesn't work well?

thanks,
-chris
