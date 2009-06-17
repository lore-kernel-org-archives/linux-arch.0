Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34265 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZFQE0T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2009 00:26:19 -0400
Message-ID: <4A38705A.3060007@zytor.com>
Date: Tue, 16 Jun 2009 21:26:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com> <20090616121909.GA1547@linux-mips.org>
In-Reply-To: <20090616121909.GA1547@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org
Message-ID: <20090617042602.tgLz-UUkbT6izcQMSOzNdcWqxQZ_TU7etj7h25o1kGI@z>

Ralf Baechle wrote:
> 
> I2C or similar busses can be a particularly annoying if they contain
> essential configuration information such as memory size which is needed
> long before anything else.  So for far a common solution is that platforms
> are carrying a private (aka redundant, ugly) early-i2c system that's just
> about sufficient for this purpose.
> 

For what it's worth, this is true for pretty much ALL systems with
removable memory modules, since Serial Presence Detect (SPD) is
electrically equivalent to I2C.

However, on most systems, even embedded, bringing up memory falls on
firmware (sometimes in the form of a boot loader) so Linux rarely sees it.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

