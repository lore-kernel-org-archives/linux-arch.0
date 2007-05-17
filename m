Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:41059 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbXEQN4w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2007 09:56:52 -0400
Subject: Re: sparse (was: Re: [RFC] Explicitly mark global functions with
	vmlinux with __global)
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0705171147240.20754@anakin>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
	 <alpine.LFD.0.98.0705161119110.3890@woody.linux-foundation.org>
	 <1179370402.2859.390.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0705171147240.20754@anakin>
Content-Type: text/plain
Date: Thu, 17 May 2007 21:56:47 +0800
Message-Id: <1179410207.2859.497.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-05-17 at 11:49 +0200, Geert Uytterhoeven wrote:
> This is something sparse can find out now, too (as I found out
> yesterday): if something is non-static, sparse gives a warning if it
> hasn't seen a prototype in a header file. 

Ah, nice :)

-- 
dwmw2

