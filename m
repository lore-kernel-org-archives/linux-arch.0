Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58980 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbXEQJ45 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2007 05:56:57 -0400
Subject: Re: sparse (was: Re: [RFC] Explicitly mark global functions with
	vmlinux with __global)
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0705171147240.20754@anakin>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
	 <alpine.LFD.0.98.0705161119110.3890@woody.linux-foundation.org>
	 <1179370402.2859.390.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0705171147240.20754@anakin>
Content-Type: text/plain
Date: Thu, 17 May 2007 17:56:49 +0800
Message-Id: <1179395810.2859.462.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-05-17 at 11:49 +0200, Geert Uytterhoeven wrote:
> I guess af_ipx.c didn't include the relevant header file?
> 
> This is something sparse can find out now, too (as I found out
> yesterday): if something is non-static, sparse gives a warning if it
> hasn't seen a prototype in a header file.

In the IPX case, af_ipx.c _does_ have a prototype for the offending
function; it's just that it doesn't actually match the function itself.

-- 
dwmw2

