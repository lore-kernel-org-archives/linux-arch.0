Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47618 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbXFONSV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Jun 2007 09:18:21 -0400
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200706151131.38429.arnd@arndb.de>
References: <200706150159.l5F1xNgM000459@hera.kernel.org>
	 <1181897905.26853.66.camel@localhost.localdomain>
	 <200706151128.39566.arnd@arndb.de>  <200706151131.38429.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 23:16:43 +1000
Message-Id: <1181913403.26853.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-06-15 at 11:31 +0200, Arnd Bergmann wrote:
> One common problem with 32 bit system call and ioctl emulation
> is the different alignment rules between i386 and 64 bit machines.
> A number of drivers work around this by marking the compat
> structures as 'attribute((packed))', which is not the right
> solution because it breaks all the non-x86 architectures that
> want to use the same compat code.
> 
> Hopefully, this patch improves the situation, it introduces two
> new types, compat_u64 and compat_s64. These are defined on all
> architectures to have the same size and alignment as the 32 bit
> version of u64 and s64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sounds good

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


