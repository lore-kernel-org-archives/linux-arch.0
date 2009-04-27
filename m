Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:52277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757737AbZD0PPy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2009 11:15:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 00/17] asm-generic ABI files for microblaze
Date: Mon, 27 Apr 2009 17:15:32 +0200
References: <200904271640.44445.arnd@arndb.de> <20090427151241.GA10558@uranus.ravnborg.org>
In-Reply-To: <20090427151241.GA10558@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200904271715.33676.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, john.williams@petalogix.com, monstr@monstr.eu, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, liqin.chen@sunplusct.com, Remis Lima Baima <remis.developer@googlemail.com>
Message-ID: <20090427151532.7BZMWPCdMFTQo6hLYN_5PVSHvkWJ2dROkuisvGF9r5M@z>

On Monday 27 April 2009, Sam Ravnborg wrote:
> The submission is seriously broken.
> - subject is missing
> - reply-to-all is broken
> 
> Can you resend with this fixed, then it makes review easier.
> 

Sure, I have already done this and identified the problem: I had
an extra '>' character in the description file I entered in quilt
mail. For some reason, kmail still showed the patches correctly,
by they got corrupted on the way out anyway. I'll look into
using git-send-email in the future.

	Arnd <><
