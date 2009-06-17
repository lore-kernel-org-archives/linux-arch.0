From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Wed, 17 Jun 2009 16:04:14 +0100
Message-ID: <20090617150414.GA18525@linux-mips.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com> <20090616121909.GA1547@linux-mips.org> <4A38705A.3060007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52370 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbZFQPFo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Jun 2009 11:05:44 -0400
Content-Disposition: inline
In-Reply-To: <4A38705A.3060007@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org

On Tue, Jun 16, 2009 at 09:26:02PM -0700, H. Peter Anvin wrote:

> > I2C or similar busses can be a particularly annoying if they contain
> > essential configuration information such as memory size which is needed
> > long before anything else.  So for far a common solution is that platforms
> > are carrying a private (aka redundant, ugly) early-i2c system that's just
> > about sufficient for this purpose.
> 
> For what it's worth, this is true for pretty much ALL systems with
> removable memory modules, since Serial Presence Detect (SPD) is
> electrically equivalent to I2C.
> 
> However, on most systems, even embedded, bringing up memory falls on
> firmware (sometimes in the form of a boot loader) so Linux rarely sees it.

There are embedded systems were the firmware does not provide a usuable
memory map or where that is plain broken.  Or Linux with some extra init
code serves as the firmware.  Often there is a single serial EEPROM for
the entire system.  If there is an atrocity that can save a penny it will
be commited at least in the embedded world.

  Ralf
