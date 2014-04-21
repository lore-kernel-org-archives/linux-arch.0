From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 01/28] nios2: Build infrastructure
Date: Mon, 21 Apr 2014 11:26:41 +0800
Message-ID: <1398050801.7753.7.camel@leyfoon-vm>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	 <1397824031-4892-2-git-send-email-lftan@altera.com>
	 <1397850104.4750.8.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from [65.55.169.136] ([65.55.169.136]:25195 "EHLO
	na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751293AbaDUDoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 20 Apr 2014 23:44:14 -0400
In-Reply-To: <1397850104.4750.8.camel@x220>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

On Jum, 2014-04-18 at 21:41 +0200, Paul Bolle wrote:
> On Fri, 2014-04-18 at 20:26 +0800, Ley Foon Tan wrote:
> > diff --git a/arch/nios2/kernel/Makefile b/arch/nios2/kernel/Makefile
> [...]
> > +obj-$(CONFIG_CONSOLE)		+= console.o
> 
> CONFIG_CONSOLE seems never to be defined. And there appears to be no
> arch/nios2/console.c or .../console.S anyway.
> 
> 
> Paul Bolle
> 
Good catch. Will remove this.
Thanks.

Regards
Ley Foon
