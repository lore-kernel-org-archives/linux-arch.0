Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:53305 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbXFOMnR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jun 2007 08:43:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
Date: Fri, 15 Jun 2007 14:42:23 +0200
References: <200706150159.l5F1xNgM000459@hera.kernel.org> <200706151131.38429.arnd@arndb.de> <20070615121133.GF8154@parisc-linux.org>
In-Reply-To: <20070615121133.GF8154@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200706151442.23939.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Friday 15 June 2007, Matthew Wilcox wrote:
> You're relying on compat_[us]64 being only used in structures which are
> already packed.  If someone uses them in a non-packed struct, they won't
> decrease the alignment.  I think it would be more effective to specify
> it as:
> 
> __attribute__((aligned(4), packed))

That's what I thought as well at first, since this is how the gcc 
documentation seems to describe it. However, recent version of gcc
complain about this:

gcc-4.1 -Wall -O2 test.c  -c
test.c:1: warning: 'packed' attribute ignored

I have tested versions 2.95, 3.3 and 4.1, an they all ignore do the
right thing when you do not specify the packed attribute.

> The other problem is that if someone defines a struct like this:
> 
> struct foo {
>         short bar;
>         compat_s64 baz;
> } __attribute__((packed))
> 
> it'll have different definitions on x86 and ia64.
> 
> So I think we should be aiming for the ((aligned, packed)) definition and
> remove the __attribute__((packed)) from the struct definitions.  What do
> you think?

There should never be an __attribute__((packed)) to solve this alignment
problem, neither in the definition of compat_s64 nor in the definition of
a data structure using it.

We might ask the gcc developers to clarify the documentation, which as of 4.1
states:

     The `aligned' attribute can only increase the alignment; but you
     can decrease it by specifying `packed' as well.  See below.

My understanding is that this only applies to statically allocated variables,
but not to automatic stack variables and to usage of the type inside of
a data structure.

	Arnd <><
