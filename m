From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
Date: Sun, 21 Jun 2009 22:55:34 +0200
Message-ID: <20090621205534.GA4324@elf.ucw.cz>
References: <4A2F0D45.2040602@linux.intel.com> <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com> <4A316D3C.7080403@linux.intel.com> <20090621064201.GD1656@ucw.cz> <4A3DE3F3.4000100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A3DE3F3.4000100@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun 2009-06-21 00:40:35, H. Peter Anvin wrote:
> Pavel Machek wrote:
>> On Thu 2009-06-11 13:46:52, H. Peter Anvin wrote:
>>> Yinghai Lu wrote:
>>>> do we need do that on every cpu?
>>>>
>>>> looks like we could do that in identify_boot_cpu.
>>>>
>>> What if the CPUs are heterogenous?  It's obviously a suboptimal
>>> situation, but it doesn't seem like something we can rely on.
>>
>> Is it ok if that changes during runtime? What if someone hotplugs
>> heterogenous cpu? I'd say basing it on boot cpu seems simplest.
>
> If someone hotplugs heterogenous CPUs it should do the right thing if  
> the right thing is possible to do.  If you already have resource  
> assignments that are unfulfillable you're screwed anyway.

Ok... and is there enough locking in there so that it is actually ok
to change mask during hotplug? (Is it okay because it is single long
and all the writers are somehow serialized by hotplug mechanism?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
