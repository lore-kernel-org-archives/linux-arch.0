From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH-mm 4/7] sh: wire up arch overrides for unaligned access
 on the SH4a
Date: Sun, 30 Nov 2008 23:14:17 -0800
Message-ID: <1228115658.5482.1.camel@brick>
References: <1228012830.26141.1029.camel@brick>
	 <20081201065123.GB30438@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:36314 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYLAHOU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Dec 2008 02:14:20 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2332108rvb.1
        for <linux-arch@vger.kernel.org>; Sun, 30 Nov 2008 23:14:20 -0800 (PST)
In-Reply-To: <20081201065123.GB30438@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Mon, 2008-12-01 at 15:51 +0900, Paul Mundt wrote:
> On Sat, Nov 29, 2008 at 06:40:30PM -0800, Harvey Harrison wrote:
> > Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> > ---
> >  arch/sh/include/asm/unaligned-sh4a.h |  258 ----------------------------------
> >  arch/sh/include/asm/unaligned.h      |   76 ++++++++--
> >  2 files changed, 61 insertions(+), 273 deletions(-)
> > 
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> 
> Thanks for looking at this!

No worries, I've also CC'd the AVR32 maintainer as I think his arch
could do something similar as that arch also provides limited
unaligned access that might be worth adding an override for.

Cheers,

Harvey
