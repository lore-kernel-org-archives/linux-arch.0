From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH -v19 00/25] Use lmb with x86
Date: Tue, 29 Jun 2010 12:06:12 -0600
Message-ID: <201006291206.13332.bjorn.helgaas@hp.com>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:44342 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0F2SFb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jun 2010 14:05:31 -0400
In-Reply-To: <1277227614-11581-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday, June 22, 2010 11:26:29 am Yinghai Lu wrote:
> New lmb could be used to replace early_res in x86.

Since you're fiddling in e820 anyway, can you fix places like
e820_print_map() so they use the %pR format?  I think it'd be
cleaner if e820_print_type() just returned a string pointer
rather than calling printk directly.  Then we'd only need a
single printk per region and wouldn't need the KERN_CONT junk.
