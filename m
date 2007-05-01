Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:52640 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbXEAOQX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 10:16:23 -0400
Subject: Re: condingstyle, was Re: utrace comments
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0705011058330.27246@anakin>
References: <20061127165138.GA2991@lst.de>
	 <20070430040213.BF9901801A4@magilla.sf.frob.com>
	 <20070430091121.GC31397@infradead.org>
	 <20070430100917.439ebfc8.akpm@linux-foundation.org>
	 <a781481a0704301142sfec317cu8213750c9ab84416@mail.gmail.com>
	 <Pine.LNX.4.64.0705011058330.27246@anakin>
Content-Type: text/plain
Date: Tue, 01 May 2007 15:16:13 +0100
Message-Id: <1178028973.2875.78.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Satyam Sharma <satyam.sharma@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-05-01 at 11:00 +0200, Geert Uytterhoeven wrote:
> 
>         if (veryverylengthycondition1 &&
>             smallcond2 &&
>             (conditionnumber3a ||
>              condition3b)) {
>                 ...
>         }

It's horrid. I'd much rather see

        if (veryverylengthycondition1 &&
            smallcond2 &&
            (conditionnumber3a || condition3b)) {
                ...
        }

Even if that does take it over 80 columns, the 'failure' mode will be
that it gets wrapped round to the beginning of the screen or truncated
at 80 columns -- and for the _majority_ of the time, it doesn't matter.

Unless you're paying particular attention to the logic and debugging the
statement, a 'high-level' view of what's going on is perfectly
sufficient; you don't actually read every character anyway.

-- 
dwmw2

