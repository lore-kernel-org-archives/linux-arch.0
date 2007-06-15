Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:50280 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbXFONwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jun 2007 09:52:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
Date: Fri, 15 Jun 2007 15:52:20 +0200
References: <200706150159.l5F1xNgM000459@hera.kernel.org> <200706151442.23939.arnd@arndb.de> <20070615134512.GG8154@parisc-linux.org>
In-Reply-To: <20070615134512.GG8154@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200706151552.20915.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Friday 15 June 2007, Matthew Wilcox wrote:
> Here's a program which illustrates the source of confusion:
> 
> #include <stdio.h>
> #include <stddef.h>
> 
> typedef unsigned long long __attribute__((aligned(4))) compat_u64;
> 
> struct foo {
>         int y;
>         unsigned long long __attribute__((aligned(4))) x;
> };
> 
> struct bar {
>         int y;
>         compat_u64 x;
> };
> 
> int main(void)
> {
>         printf("offset of foo->x is %lu\n", offsetof(struct foo, x));
>         printf("offset of bar->x is %lu\n", offsetof(struct bar, x));
>         return 0;
> }
> 
> output (on ia64, and I'm told other 64-bit platforms) is:
> 
> $ ./test 
> offset of foo->x is 8
> offset of bar->x is 4
> 
> I'll try and come up with some wording that works for the GCC manual.



I just talked to Ulrich Weigand, who explained to me that
__attribute__((packed)) should not be specified on a typedef that is
not also a struct/union/enum definition, because it can not change the
type anyway.

Also, the attribute((aligned(x))) works differently in a typedef than
in a field or variable declaration:

In your struct foo, __attribute__((aligned(4))) does not have any
effect because the attribute on a field declaration will only increase
the alignment if you specify a larger value than the default alignment
for the member type.

In struct bar, you have two members that both have type with a default
alignment of 4, because the typedef overwrote the default alignment
for the compat_u64 type.

	Arnd <><
