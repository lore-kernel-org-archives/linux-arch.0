From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] 32-bit ABI: introduce ARCH_32BIT_OFF_T config option
Date: Tue, 29 Dec 2015 14:54:50 +0100
Message-ID: <37236912.quIluKB8iJ@wuerfel>
References: <1451381195-9315-1-git-send-email-ynorov@caviumnetworks.com> <2936028.iA62kEhLnJ@wuerfel> <20151229114341.GA15657@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51613 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbbL2Ny6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Dec 2015 08:54:58 -0500
In-Reply-To: <20151229114341.GA15657@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: cmetcalf@ezchip.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, klimov.linux@gmail.com

On Tuesday 29 December 2015 14:43:41 Yury Norov wrote:
> On Tue, Dec 29, 2015 at 12:02:33PM +0100, Arnd Bergmann wrote:
> > On Tuesday 29 December 2015 12:26:35 Yury Norov wrote:
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Should we merge the two patches through my asm-generic tree now, or should
> > we keep them in the ilp32 series, any preferences?
> > 
> > I think either way works.
> > 
> >       Arnd
> 
> I'd prefer asm-generic tree because they are not related to ILP32 only.
> 

Ok, I'll add it there after collecting a few more Acks. Generally speaking I
prefer to keep asm-generic patches in whatever series depends on them, as
there are normally very few changes, but it makes sense to merge this one
regardless just to make sure no other dependencies get added in case someone
submits a new architecture port at the same time.

	Arnd
