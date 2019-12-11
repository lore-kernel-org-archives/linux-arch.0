From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Date: Wed, 11 Dec 2019 15:52:33 +0100
Message-ID: <2139491.Komy7AgBfX@skinner.arch.suse.de>
References: <20191206162421.15050-1-trenn@suse.de> <22533595.7ohjOCJ8As@skinner.arch.suse.de> <20191211142647.GB605616@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211142647.GB605616@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wednesday, December 11, 2019 3:26:47 PM CET Greg KH wrote:
> On Wed, Dec 11, 2019 at 03:12:51PM +0100, Thomas Renninger wrote:
> > On Wednesday, December 11, 2019 2:56:19 PM CET Greg KH wrote:
> > > On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:

...

> > I hope it is agreed that this info is worth exporting via sysfs.
> 
> I don't think anyone is saying it is worth exporting this information
> via sysfs at all here.

Ok. I go for cpuid userspace tool then.

I'd still say general files like:
cpu/info/{name,vendor}
make sense, so that if exported by an arch like in cpuinfo, it should show up 
in the same file.
Every cpu has a model name and a vendor and cpuid is x86 only.

If there should be need for /sys/devices/cpu/cpu0.. info/feature/name
whatever in the future..., let me know ;)

   Thomas
