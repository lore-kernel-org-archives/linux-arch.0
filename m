From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
Date: Thu, 11 Jun 2009 13:46:52 -0700
Message-ID: <4A316D3C.7080403@linux.intel.com>
References: <4A2F0D45.2040602@linux.intel.com> <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <86802c440906111343g513a2ceau1e2bfdf14c295b2d@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Yinghai Lu wrote:
> 
> do we need do that on every cpu?
> 
> looks like we could do that in identify_boot_cpu.
> 

What if the CPUs are heterogenous?  It's obviously a suboptimal
situation, but it doesn't seem like something we can rely on.

	-hpa
