Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:56269 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262077AbUB2Qwp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 29 Feb 2004 11:52:45 -0500
Subject: Re: [RFC] Implement dma_boundary in the generic device
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040229164630.GH25779@parcelfarce.linux.theplanet.co.uk>
References: <1078070182.1756.11.camel@mulgrave>
	<20040229164630.GH25779@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 29 Feb 2004 10:52:41 -0600
Message-Id: <1078073562.1756.46.camel@mulgrave>
Mime-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2004-02-29 at 10:46, Matthew Wilcox wrote:
> <nitpick style=janitor> Space between "if" and "(" </nitpick>

Well, I think I've already proved I'm not a very good janitor with the
attempt to shift coherent_dma_mask ...

> Don't all architectures want a limit to 4GB boundaries, to avoid crossing
> the first 4GB?

That is the fundamental limit, that's why I set it up to 4GB at
initialisation.  I anticipate that if platforms want to enforce an upper
bound, they would override dma_set_boundary().

James
