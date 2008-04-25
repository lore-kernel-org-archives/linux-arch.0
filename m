Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:35503 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543AbYDYTtP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Apr 2008 15:49:15 -0400
Received: by wa-out-1112.google.com with SMTP id m16so6175626waf.23
        for <linux-arch@vger.kernel.org>; Fri, 25 Apr 2008 12:49:14 -0700 (PDT)
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <alpine.LFD.1.10.0804251243590.2779@woody.linux-foundation.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
	 <1209078352-7593-2-git-send-email-hpa@zytor.com>
	 <1209078352-7593-3-git-send-email-hpa@zytor.com>
	 <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr>
	 <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
	 <20080425185251.GL14990@parisc-linux.org> <48122CB0.7020003@zytor.com>
	 <20080425192858.GM14990@parisc-linux.org> <48123325.30003@zytor.com>
	 <alpine.LFD.1.10.0804251243590.2779@woody.linux-foundation.org>
Content-Type: text/plain
Date: Fri, 25 Apr 2008 12:49:16 -0700
Message-ID: <1209152956.14173.2.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <matthew@wil.cx>, Jan Engelhardt <jengelh@computergmbh.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>
Message-ID: <20080425194916.r1hbF3Tb_dmL3uhZbhp5EfH99-Pdem8Z0hnyRjIEX7Q@z>

On Fri, 2008-04-25 at 12:45 -0700, Linus Torvalds wrote:
> 
> On Fri, 25 Apr 2008, H. Peter Anvin wrote:
> > 
> > I have to admit to liking the Windows extension %I64u for this kind of stuff.
> > Unfortunately gcc/glibc decided to use I for internationalized digits instead
> > :(
> 
> The sad part is that this is purely a gcc thing. We could easily do the 
> right thing in the kernel vsnprintf stuff, but then we'd have to drop the 
> nice format warnings from gcc ;(

This looks like something sparse could be made to check though, should
we lose the gcc checking.

In fact, didn't Al Viro mention adding just this kind of checking to
sparse recently?

Harvey

