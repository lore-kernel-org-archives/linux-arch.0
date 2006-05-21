Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:26757 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932422AbWEUSbk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 May 2006 14:31:40 -0400
Date: Sun, 21 May 2006 11:31:37 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] move scatterlist accessors into scatterlist.h on ia64, sh and sh64
Message-ID: <20060521183137.GA699@taniwha.stupidest.org>
References: <1148221874.17239.3.camel@mulgrave.il.steeleye.com> <1148227178.3875.308.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148227178.3875.308.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>, linux-arch@vger.kernel.org, lethal@linux-sh.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 21, 2006 at 04:59:38PM +0100, David Woodhouse wrote:

> It doesn't matter for kernel addresses on CPUs like SH and MIPS,
> because it's just a mask anyway.

On mips KSEG0 only convers lowmem though.
