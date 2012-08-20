From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 08/31] arm64: CPU support
Date: Mon, 20 Aug 2012 20:47:07 +0000
Message-ID: <201208202047.07991.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <20120815001043.GD19607@quad.lixom.net> <20120820155740.GA912@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55918 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab2HTUrM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Aug 2012 16:47:12 -0400
In-Reply-To: <20120820155740.GA912@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Olof Johansson <olof@lixom.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

On Monday 20 August 2012, Catalin Marinas wrote:
> > > --- /dev/null
> > > +++ b/arch/arm64/mm/proc-syms.c
> ...
> > > +EXPORT_SYMBOL(__cpuc_flush_kern_all);
> > > +EXPORT_SYMBOL(__cpuc_flush_user_all);
> > > +EXPORT_SYMBOL(__cpuc_flush_user_range);
> > > +EXPORT_SYMBOL(__cpuc_coherent_kern_range);
> > > +EXPORT_SYMBOL(__cpuc_flush_dcache_area);
> > 
> > See comment on other email about putting function pointers in a struct
> > instead.
> 
> There is no need to support multiple CPU architectures with different
> implementations, so allowing these functions to be called without
> indirection is better.

What is the __cpuc prefix about then? Could you just drop it?

	Arnd
