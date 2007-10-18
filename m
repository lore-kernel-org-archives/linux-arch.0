Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:51900 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765324AbXJRP0E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2007 11:26:04 -0400
Date: Thu, 18 Oct 2007 16:25:53 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/21] KGDB: Request to merge KGDB
Message-ID: <20071018152552.GA13985@infradead.org>
References: <4713B238.4030409@windriver.com> <20071017212025.d8a52694.akpm@linux-foundation.org> <20071018152310.GA7299@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071018152310.GA7299@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Jason Wessel <jason.wessel@windriver.com>, lkml <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Oct 19, 2007 at 12:23:10AM +0900, Paul Mundt wrote:
> It would also be nice to balance this out with the utrace merge, as both
> are going to cause quite a lot of pain on the architecture side.

I don't think a utrace merge as in one big merge is going to happen ever.
It's just a too big patch doing too many things at once.  And the flag day
for switching all architectures over is another blocker.

