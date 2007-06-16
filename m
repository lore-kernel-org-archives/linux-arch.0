Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60212 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbXFPLVk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Jun 2007 07:21:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
Date: Sat, 16 Jun 2007 13:21:35 +0200
References: <200706150159.l5F1xNgM000459@hera.kernel.org> <1181986686.25228.639.camel@pmac.infradead.org> <200706161226.40875.arnd@arndb.de>
In-Reply-To: <200706161226.40875.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706161321.35940.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Saturday 16 June 2007, Arnd Bergmann wrote:
> On Saturday 16 June 2007, David Woodhouse wrote:
> > Will GCC know that it needs to emit code to handle that (mis)alignment?
> 
> I've tested this with gcc-4.0.3, and it does the right thing, which
> is to split a 4 byte aligned 64 bit load/store into two 32 bit accesses,
> if you pass -mstrict-align.

I just realized this was correct but slightly misleading. On powerpc, we
don't set the 'attribute((aligned(4)))' on compat_64, so there is never
a reason to handle the misalignment, even though it would work.

On x86_64, misaligned loads are always ok, so gcc never needs to
care about this, even attribute((packed)) does not cause byte access
here.

	Arnd <><
