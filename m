Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:38158 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYDYTnv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Apr 2008 15:43:51 -0400
Date: Fri, 25 Apr 2008 21:43:50 +0200 (CEST)
From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
In-Reply-To: <48123325.30003@zytor.com>
Message-ID: <alpine.LNX.1.10.0804252143170.20150@fbirervta.pbzchgretzou.qr>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
 <20080425185251.GL14990@parisc-linux.org> <48122CB0.7020003@zytor.com> <20080425192858.GM14990@parisc-linux.org> <48123325.30003@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>
Message-ID: <20080425194350.ItkerG_W2CBa9lPIuym4klgsxVX307ZCijT2asR8xHk@z>


On Friday 2008-04-25 21:38, H. Peter Anvin wrote:
>> Understood, and agreed.  It just seemed like an opportune time to
>> mention the problem of printing a u64.
>> 
>
> I have to admit to liking the Windows extension %I64u for this kind of stuff.
> Unfortunately gcc/glibc decided to use I for internationalized digits instead
> :(

In the kernel's *printk, we are free to do what we want :)

%_64u perhaps?
