From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] arm64: Use include/asm-generic/io.h
Date: Fri, 11 Jul 2014 14:58:09 +0200
Message-ID: <201407111458.09884.arnd@arndb.de>
References: <1404918699-17284-1-git-send-email-thierry.reding@gmail.com> <201407101514.16530.arnd@arndb.de> <20140711121923.GE11473@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53914 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbaGKM6Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jul 2014 08:58:25 -0400
In-Reply-To: <20140711121923.GE11473@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday 11 July 2014, Catalin Marinas wrote:
> ioread32() is indeed an alias for readl on arm64 but if the address it
> gets as argument looks like an I/O port, it adds PCI_IOBASE (via the inl
> macro). This would no longer happen with Thierry's patches.
> 
> So I guess that for this patch to work, we also need ioport_map() to
> return an address from the PCI_IOBASE range. Should we merge this now as
> well:
> 
> http://linux-arm.org/git?p=linux-ld.git;a=commitdiff;h=3423064d8e42a38164a8436bcdf7434cf9cd2192

This is also part of patch 1/3 in Thierry's series.

	Arnd
