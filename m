Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55907 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457AbXFPK1b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Jun 2007 06:27:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
Date: Sat, 16 Jun 2007 12:26:40 +0200
References: <200706150159.l5F1xNgM000459@hera.kernel.org> <200706151131.38429.arnd@arndb.de> <1181986686.25228.639.camel@pmac.infradead.org>
In-Reply-To: <1181986686.25228.639.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706161226.40875.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Saturday 16 June 2007, David Woodhouse wrote:
> Will GCC know that it needs to emit code to handle that (mis)alignment?

I've tested this with gcc-4.0.3, and it does the right thing, which
is to split a 4 byte aligned 64 bit load/store into two 32 bit accesses,
if you pass -mstrict-align.

> Preliminary tests show that it does load the value bytewise if we use
> the 'packed' attribute structure on ppc64, but doesn't if we use
> compat_u64. But then, I don't think it actually _needs_ to handle it n
> ppc64 anyway, so maybe that's not such a good test.

Right. Note that the behaviour of compat_u64 is the same as when you
pass attribute((packed,aligned(4))) to the structure, where it also won't
do byte accesses, and split the 64 bit access only if you pass
-mstrict-align.

	Arnd <><
