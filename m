From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Date: Wed, 11 Dec 2019 15:57:00 +0100
Message-ID: <20191211145700.GA639677@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <22533595.7ohjOCJ8As@skinner.arch.suse.de>
 <20191211142647.GB605616@kroah.com>
 <2139491.Komy7AgBfX@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2139491.Komy7AgBfX@skinner.arch.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

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
