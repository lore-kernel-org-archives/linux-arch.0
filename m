From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
Date: Thu, 11 Jun 2009 12:17:42 -0700
Message-ID: <20090611121742.2c0fae8d@jbarnes-g45>
References: <4A2F0D45.2040602@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4A2F0D45.2040602@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 09 Jun 2009 18:32:53 -0700
"H. Peter Anvin" <hpa@linux.intel.com> wrote:

> x86 cannot generate full 64-bit addresses; this patch clamps iomem
> addresses to the accessible range.
> 
> I wanted to post it for review before committing it, however; comments
> would be appreciated, especially of the kind "this is done too
> early/too late/in the wrong place/incorrectly".
> 
> 	-hpa

Seems reasonable, since the iomem_resource describes the CPU's view of
MMIO space it should probably reflect what it can actually access.

Reviewed-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
