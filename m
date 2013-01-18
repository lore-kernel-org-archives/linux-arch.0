Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:51647 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab3ARQMF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jan 2013 11:12:05 -0500
Date: Sat, 19 Jan 2013 01:01:07 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 28/76] ARC: I/O and DMA Mappings
Message-ID: <20130118160106.GD14019@linux-sh.org>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
 <1358511930-7424-29-git-send-email-vgupta@synopsys.com>
 <201301181555.43487.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201301181555.43487.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130118160107.bCEfeAUTgXCnFnc1FXF5lHN5r9ycy1e25zqlpYBjeuw@z>

On Fri, Jan 18, 2013 at 03:55:43PM +0000, Arnd Bergmann wrote:
> On Friday 18 January 2013, Vineet Gupta wrote:
> > TBD: Do we need early ioremap support like openrisc
> > 
> > Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> 
> Can you explain why early ioremap is necessary for you?
> 
> I wasn't aware that openrisc has it. In a lot of cases,
> you can use fixmap as a replacement.
> 
The two don't need to be mutually exclusive, either. sh implements early
ioremap transparently via fixmaps for example:

	arch/sh/mm/ioremap.c
	arch/sh/mm/ioremap_fixed.c
