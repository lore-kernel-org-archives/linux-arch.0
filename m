Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:56715 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbXFPJiM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 16 Jun 2007 05:38:12 -0400
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200706151131.38429.arnd@arndb.de>
References: <200706150159.l5F1xNgM000459@hera.kernel.org>
	 <1181897905.26853.66.camel@localhost.localdomain>
	 <200706151128.39566.arnd@arndb.de>  <200706151131.38429.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 16 Jun 2007 10:38:06 +0100
Message-Id: <1181986686.25228.639.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-06-15 at 11:31 +0200, Arnd Bergmann wrote:
> Hopefully, this patch improves the situation, it introduces two
> new types, compat_u64 and compat_s64. These are defined on all
> architectures to have the same size and alignment as the 32 bit
> version of u64 and s64. 

Will GCC know that it needs to emit code to handle that (mis)alignment?
Preliminary tests show that it does load the value bytewise if we use
the 'packed' attribute structure on ppc64, but doesn't if we use
compat_u64. But then, I don't think it actually _needs_ to handle it n
ppc64 anyway, so maybe that's not such a good test.

I'll send a simple patch to fix the bug for now, just making the new
wrapper conditional on X86_64||IA64.

-- 
dwmw2

