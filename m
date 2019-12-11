From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Date: Wed, 11 Dec 2019 14:56:19 +0100
Message-ID: <20191211135619.GA538980@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206163656.GC86904@kroah.com>
 <87sglroqix.fsf@nanos.tec.linutronix.de>
 <4737004.4U1sY2OxSp@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4737004.4U1sY2OxSp@skinner.arch.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Felix Schnizlein <fschnizlein@suse.com>, linux-kernel@vger.kernel.org, Felix Schnizlein <fschnizlein@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:
> If Greg (and others) are ok, I would add "page size exceeding" handling.
> Hm, quick searching for an example I realize that debugfs can exceed page 
> size. Is it that hard to expose a sysfs file larger than page size?

No, there is a simple way to do it, but I'm not going to show you how as
it is NOT how to use sysfs at all :)

Why are you wanting to dump this whole mess into one file and then parse
it, it's no different from having 100+ different sysfs files and then
doing a readdir(3) on the thing, right?

greg k-h
