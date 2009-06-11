Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-146.bluehost.com ([67.222.38.36]:47516 "HELO
	outbound-mail-146.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760871AbZFKTZD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Jun 2009 15:25:03 -0400
Date: Thu, 11 Jun 2009 12:17:42 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: RFC: x86: cap iomem_resource to addressable physical memory
Message-ID: <20090611121742.2c0fae8d@jbarnes-g45>
In-Reply-To: <4A2F0D45.2040602@linux.intel.com>
References: <4A2F0D45.2040602@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Martin Mares <mj@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
Message-ID: <20090611191742.CeBwrl6LGvoRVYEquicCzxptGz2o6U2ajOLLQ63zJY4@z>

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
