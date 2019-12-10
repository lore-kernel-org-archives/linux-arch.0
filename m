Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLJOrk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 09:47:40 -0500
Date: Tue, 10 Dec 2019 15:47:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Message-ID: <20191210144737.GB3975980@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <25032400.G9DUGnJgnc@skinner.arch.suse.de>
 <20191209173804.GD7489@willie-the-truck>
 <11195456.EmMzWPVPDU@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11195456.EmMzWPVPDU@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: Will Deacon <will@kernel.org>, Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Message-ID: <20191210144737.16HC8fa9Mx-WxbqoVEtKVE4tHRuwDbJej8iNcFQqrlY@z>

On Tue, Dec 10, 2019 at 02:33:07PM +0100, Thomas Renninger wrote:
> On Monday, December 9, 2019 6:38:05 PM CET Will Deacon wrote:
> > On Mon, Dec 09, 2019 at 12:28:44PM +0100, Thomas Renninger wrote:
> > > On Monday, December 9, 2019 11:31:11 AM CET Will Deacon wrote:
> > > > On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> > > > > From: Felix Schnizlein <fschnizlein@suse.de>
> > > > > 
> > > > > Export all information from /proc/cpuinfo to sysfs:
> > > > > implementer, architecture, variant, part, revision,
> > > > > bogomips and flags are exported.
> > > > > 
> > > > > Example:
> > > > > /sys/devices/system/cpu/cpu1/info/:[0]# head *
> > > 
> > > ...
> > > 
> > > > > ==> flags <==
> > > > > fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> > > 
> > > ...
> > > 
> > > > I don't understand why we need this on arm64
> 
> Again: proc is moving to sys.

No.  New stuff is to be added to /sys/, don't add new things to /proc
unless it deals with processes.

There is no mass-migration of existing /proc files to sysfs for no good
reason.

> You probably export feature flags in /proc/cpuinfo for a good reason.
> So where in sysfs should this show up?

Why does it have to live in sysfs if it is already in /proc and parsed
properly by tools?

thanks,

greg k-h
