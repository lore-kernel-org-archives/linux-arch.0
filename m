Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:40547 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751641AbZFKUqu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jun 2009 16:46:50 -0400
Message-ID: <4A316D3C.7080403@linux.intel.com>
Date: Thu, 11 Jun 2009 13:46:52 -0700
From: "H. Peter Anvin" <hpa@linux.intel.com>
MIME-Version: 1.0
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
References: <4A2F0D45.2040602@linux.intel.com> <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com>
In-Reply-To: <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
Message-ID: <20090611204652.v8ZxldXWp3C9F1QnTtOh1c3ykT6WPwC7IxchinZmGBc@z>

Yinghai Lu wrote:
> 
> do we need do that on every cpu?
> 
> looks like we could do that in identify_boot_cpu.
> 

What if the CPUs are heterogenous?  It's obviously a suboptimal
situation, but it doesn't seem like something we can rely on.

	-hpa

