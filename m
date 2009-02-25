From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Make exported headers use strict posix types
Date: Wed, 25 Feb 2009 22:42:44 +0100
Message-ID: <200902252242.45755.arnd@arndb.de>
References: <20090225032553.GD6690@bombadil.infradead.org> <200902251917.49017.arnd@arndb.de> <20090225201131.GA26110@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49821 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbZBYVoA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 16:44:00 -0500
In-Reply-To: <20090225201131.GA26110@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Kyle McMartin <kyle@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 25 February 2009, Sam Ravnborg wrote:

 
> Does this change really belong in this patchset?
 
> Yes - I can build kernels again. But I think we should skip this change..

> This change looks correct - but I assume this is a separate patch.
> 
> Rest looks good.

Agreed on all points, I had the changes sitting in a dirty git tree
and got sloppy. Thanks for looking through it!

	Arnd <><
