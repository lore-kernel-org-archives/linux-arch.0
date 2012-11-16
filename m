From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 32/40] i8042: don't build on METAG
Date: Fri, 16 Nov 2012 17:20:38 +0000
Message-ID: <201211161720.38291.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211161520.03974.arnd@arndb.de> <50A66ED5.6020805@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53145 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab2KPRmK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2012 12:42:10 -0500
In-Reply-To: <50A66ED5.6020805@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Friday 16 November 2012, James Hogan wrote:
> > 
> > config ARCH_MAY_HAVE_PC_FDC
> > 	def_bool LEGACY_PC_IO && !M32R && (!PPC || (PCI && !PPC_PSERIES))
> > 	# selected by ARCH_RPC
> > 
> > config HAVE_PARPORT_PC
> > 	def_bool LEGACY_PC_IO || PCI
> 
> So would you say that all architecture's that can have PCI should have a
> parport.h (generic-y at least)? Current architectures which can enable
> non-broken PCI and don't have parport.h are:
> currently not excluded: CRIS
> currently excluded: FRV, MN10300, XTENSA

I think they should just all generate a link to asm-generic/parport.h, which
would do the right thing for them.

	Arnd
