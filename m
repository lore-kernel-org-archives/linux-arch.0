Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0084.outbound.protection.outlook.com ([104.47.34.84]:24064
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751152AbdFSPSd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jun 2017 11:18:33 -0400
Date: Mon, 19 Jun 2017 18:18:18 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
Message-ID: <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
 <20170618235108.peaxdi367jpkt542@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170618235108.peaxdi367jpkt542@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20170619151818.0RuwWk2SUeNY3UPIq_bb-pSkLM76hTtENpUW1cnVwbc@z>

On Mon, Jun 19, 2017 at 02:51:08AM +0300, Yury Norov wrote:
> Hi Florian,
> 
> Some questions and thoughts inline.
> 
> Yury
> 
> On Fri, Jun 16, 2017 at 05:07:42PM -0700, Florian Fainelli wrote:
> > Define a generic fncpy() implementation largely based on the ARM version
> > that requires an 8 bytes alignment for the destination address where to
> > copy this function as well as the function's own address.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  include/asm-generic/fncpy.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 include/asm-generic/fncpy.h

One else thing I forgot to ask - now you have the generic
implementation for fncpy(), so do you really need to save arm
version of it?

Yury
