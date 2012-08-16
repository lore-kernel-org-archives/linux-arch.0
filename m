From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 03/31] arm64: Exception handling
Date: Thu, 16 Aug 2012 11:54:10 +0000
Message-ID: <201208161154.10891.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <201208151303.47743.arnd@arndb.de> <20120816100536.GF31784@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64154 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab2HPMiD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Aug 2012 08:38:03 -0400
In-Reply-To: <20120816100536.GF31784@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday 16 August 2012, Will Deacon wrote:
> On Wed, Aug 15, 2012 at 02:03:47PM +0100, Arnd Bergmann wrote:
> > On Tuesday 14 August 2012, Catalin Marinas wrote:
> > 
> > > +#ifdef CONFIG_AARCH32_EMULATION
> > > +#define compat_thumb_mode(regs) \
> > > +   (((regs)->pstate & COMPAT_PSR_T_BIT))
> > > +#else
> > > +#define compat_thumb_mode(regs) (0)
> > > +#endif
> > 
> > The symbol we use on other platforms is CONFIG_COMPAT. I don't think you
> > need to have a separate CONFIG_AARCH32_EMULATION
> 
> Using COMPAT does preclude the possibility of doing something like the x32
> ABI later on though. Some other architectures seem to do something similar
> (MIPS32_COMPAT, IA32_EMULATION).

Ok, fair enough.

	Arnd
