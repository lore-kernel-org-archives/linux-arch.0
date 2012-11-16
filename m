From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 32/40] i8042: don't build on METAG
Date: Fri, 16 Nov 2012 16:50:29 +0000
Message-ID: <50A66ED5.6020805@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091428.42998.arnd@arndb.de> <50A61E51.8000306@imgtec.com> <201211161520.03974.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54470 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538Ab2KPQud (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Nov 2012 11:50:33 -0500
In-Reply-To: <201211161520.03974.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Hi Arnd,

On 16/11/12 15:20, Arnd Bergmann wrote:
> I think the baseline should be:
> 
> config LEGACY_PC_IO
> 	bool
> 	# selected by X86 || ALPHA || SPARC || M32R ||
> 	# (PPC && !4xx && !8xx) || 
>         # (ARM && (ARCH_FOOTBRIDGE || ARCH_NETWINDER) ||
> 	# (M68K && (Q40 || SUN3X)) ||
> 	# (MIPS && (JAZZ || MALTA || SNI_RM))

Thanks!

> 
> config ARCH_MAY_HAVE_PC_FDC
> 	def_bool LEGACY_PC_IO && !M32R && (!PPC || (PCI && !PPC_PSERIES))
> 	# selected by ARCH_RPC
> 
> config HAVE_PARPORT_PC
> 	def_bool LEGACY_PC_IO || PCI

So would you say that all architecture's that can have PCI should have a
parport.h (generic-y at least)? Current architectures which can enable
non-broken PCI and don't have parport.h are:
currently not excluded: CRIS
currently excluded: FRV, MN10300, XTENSA

Cheers
James
