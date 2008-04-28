Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49999 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933359AbYD1Nzp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Apr 2008 09:55:45 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LNX.1.10.0804252143170.20150@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0804252143170.20150@fbirervta.pbzchgretzou.qr> <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org> <20080425185251.GL14990@parisc-linux.org> <48122CB0.7020003@zytor.com> <20080425192858.GM14990@parisc-linux.org> <48123325.30003@zytor.com> 
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Mon, 28 Apr 2008 14:55:37 +0100
Message-ID: <4489.1209390937@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: dhowells@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>
Message-ID: <20080428135537.V70HmppuBXuLjHOzzmTLRTbs0TkTEseDCmBhQkqNXxg@z>

Jan Engelhardt <jengelh@computergmbh.de> wrote:

> In the kernel's *printk, we are free to do what we want :)

Subject to -Wformat in gcc, of course...

David
