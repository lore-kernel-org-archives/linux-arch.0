From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Query about merging memblock and bootmem into one new alloc
Date: Mon, 21 Dec 2015 23:01:01 +0100
Message-ID: <201512212301.02148.arnd@arndb.de>
References: <CANDtUrciap2iHDWpB4SWwACJaUPaLRP4nFb9u9j1=iCJTiuK8Q@mail.gmail.com> <567835B4.3090101@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:54717 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbbLUWBW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Dec 2015 17:01:22 -0500
In-Reply-To: <567835B4.3090101@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Sumit Gupta <sumit.g.007@gmail.com>, inux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 21 December 2015, Laura Abbott wrote:
> ARM no longer uses bootmem, just memblock (see 84f452b1e8fc73ac0e31254c66e3e2260ce5263d
> ARM: mm: Remove bootmem code and switch to NO_BOOTMEM). Any bootmem calls
> just go to mm/nobootmem.c which is a wrapper around memblock for compatibility.

It seems the same is true on arc, arm64, powerpc, s390, sparc, tile and x86,
and we'd ideally move all others the same way.

Almost all uses of the bootmem interfaces are in architectures specific code
these days, the only exceptions I could find at all are alloc_bootmem_pages
in drivers/xen/swiotlb-xen.c, and alloc_bootmem in drivers/macintosh/smu.c
and init/main.c.

I don't know how the effort to remove bootmem is progressing, but I guess
we could avoid adding new users if we move the existing implementation into
the architectures that still use it, remove the interfaces not used by
those architectures and rename the other ones to have a prefix identifying
the architecture.

	Arnd
