From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Mon, 1 Dec 2008 00:20:56 +0900
Message-ID: <20081201002056.d9f9204c.h.mitake@gmail.com>
References: <200811290056.mAT0uTuk028924@terminus.zytor.com>
	<20081129164736.0b5a71db.h.mitake@gmail.com>
	<20081129093858.GC26691@elte.hu>
	<20081129192610.716a2d57.h.mitake@gmail.com>
	<20081129105229.GA9643@uranus.ravnborg.org>
	<20081129222449.e341f028.h.mitake@gmail.com>
	<20081129180144.GA15533@uranus.ravnborg.org>
	<20081130171604.dc3c8715.h.mitake@gmail.com>
	<20081130083700.GA31644@elte.hu>
	<20081130092407.GA10802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:64043 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbYK3PVF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 30 Nov 2008 10:21:05 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1397040tic.23
        for <linux-arch@vger.kernel.org>; Sun, 30 Nov 2008 07:21:03 -0800 (PST)
In-Reply-To: <20081130092407.GA10802@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Ravnborg <sam@ravnborg.org>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, 30 Nov 2008 10:24:07 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> the 32-bit build broke promptly - readq/writeq is a family of APIs that 
> has to be either fully provided or not provided at all. The fix is below.

Thanks for your fix and adding!
When will this patch be added to mainline?
I want to rewrite x38_edac.c to adapt new APIs.
