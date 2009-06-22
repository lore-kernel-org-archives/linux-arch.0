From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
Date: Mon, 22 Jun 2009 00:54:14 -0700
Message-ID: <4A3F38A6.80906@linux.intel.com>
References: <4A2F0D45.2040602@linux.intel.com> <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com> <4A316D3C.7080403@linux.intel.com> <20090621064201.GD1656@ucw.cz> <4A3DE3F3.4000100@linux.intel.com> <20090621205534.GA4324@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20090621205534.GA4324@elf.ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Pavel Machek wrote:
> 
> Ok... and is there enough locking in there so that it is actually ok
> to change mask during hotplug? (Is it okay because it is single long
> and all the writers are somehow serialized by hotplug mechanism?)
> 									Pavel

Making it a locked reference probably would be a good idea (although I 
personally think it will never actually matter in practice).  Although 
on 32 bits (PAE) it can be more than one long, it doesn't matter because 
only the upper long can actually be modified.  It does, however, 
complicate the actual code somewhat... I'll look at it tomorrow.

	-hpa
