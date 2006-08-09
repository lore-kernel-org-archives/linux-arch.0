Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27500 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751251AbWHIR64 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Aug 2006 13:58:56 -0400
Date: Wed, 9 Aug 2006 10:58:54 -0700
From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Message-ID: <20060809175854.GA14382@intel.com>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com> <20060807194159.f7c741b5.akpm@osdl.org> <17624.7310.856480.704542@cargo.ozlabs.ibm.com> <200608080714.21151.ak@suse.de> <1155025073.26277.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155025073.26277.18.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 08, 2006 at 10:17:53AM +0200, Martin Schwidefsky wrote:
> "vmalloc reserve first; allocate pages later" would be a really nice
> feature. We could use this on s390 to implement the virtual mem_map
> array spanning the whole 64 bit address range (with holes in it). To
> make it perfect a "deallocate pages; keep vmalloc reserve" should be
> added, then we could free parts of the mem_map array again on hot memory
> remove. 

IA-64 already has some arch. specific code to allocate a sparse
virtual memory map ... having generic code to do so would be
nice, but I foresee some chicken&egg problems in getting enough
of the vmalloc/vmap framework up & running before mem_map[] has
been allocated.

That and the hotplug memory folks don't like the virtual mem_map
code and have spurned it in favour of SPARSE.

-Tony
