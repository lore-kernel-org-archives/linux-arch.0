Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfLKO5E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 09:57:04 -0500
Date: Wed, 11 Dec 2019 15:57:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Message-ID: <20191211145700.GA639677@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <22533595.7ohjOCJ8As@skinner.arch.suse.de>
 <20191211142647.GB605616@kroah.com>
 <2139491.Komy7AgBfX@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2139491.Komy7AgBfX@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Message-ID: <20191211145700.CA6gLe869C-pmJ2FMzbyNY7eV6Po7Lv6ldgulk4Gp2M@z>

On Wed, Dec 11, 2019 at 03:52:33PM +0100, Thomas Renninger wrote:
> On Wednesday, December 11, 2019 3:26:47 PM CET Greg KH wrote:
> > On Wed, Dec 11, 2019 at 03:12:51PM +0100, Thomas Renninger wrote:
> > > On Wednesday, December 11, 2019 2:56:19 PM CET Greg KH wrote:
> > > > On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:
> 
> ...
> 
> > > I hope it is agreed that this info is worth exporting via sysfs.
> > 
> > I don't think anyone is saying it is worth exporting this information
> > via sysfs at all here.
> 
> Ok. I go for cpuid userspace tool then.
> 
> I'd still say general files like:
> cpu/info/{name,vendor}
> make sense, so that if exported by an arch like in cpuinfo, it should show up 
> in the same file.
> Every cpu has a model name and a vendor and cpuid is x86 only.

I think you just saw the ARM developers arguing about model names, so I
don't think people will agree with that :)

goo dluck!

greg k-h
