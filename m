From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
Date: Sun, 21 Jun 2009 00:40:35 -0700
Message-ID: <4A3DE3F3.4000100@linux.intel.com>
References: <4A2F0D45.2040602@linux.intel.com> <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com> <4A316D3C.7080403@linux.intel.com> <20090621064201.GD1656@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:26546 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751399AbZFUHkz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 21 Jun 2009 03:40:55 -0400
In-Reply-To: <20090621064201.GD1656@ucw.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Yinghai Lu <yhlu.kernel@gmail.com>, Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org

Pavel Machek wrote:
> On Thu 2009-06-11 13:46:52, H. Peter Anvin wrote:
>> Yinghai Lu wrote:
>>> do we need do that on every cpu?
>>>
>>> looks like we could do that in identify_boot_cpu.
>>>
>> What if the CPUs are heterogenous?  It's obviously a suboptimal
>> situation, but it doesn't seem like something we can rely on.
> 
> Is it ok if that changes during runtime? What if someone hotplugs
> heterogenous cpu? I'd say basing it on boot cpu seems simplest.
> 									Pavel
> 

If someone hotplugs heterogenous CPUs it should do the right thing if 
the right thing is possible to do.  If you already have resource 
assignments that are unfulfillable you're screwed anyway.

	-hpa
