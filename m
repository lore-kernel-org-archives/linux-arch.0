Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269020AbUIABQH@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57522 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265139AbUIABP6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Aug 2004 21:15:58 -0400
Date: Wed, 1 Sep 2004 03:15:55 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: domain setup in 2.6.9rc1-bk6
Message-Id: <20040901031555.7e9a1a2a.ak@suse.de>
In-Reply-To: <413514D0.2020308@yahoo.com.au>
References: <m3llfvk4vh.fsf@averell.firstfloor.org>
	<20040831100924.GI26072@krispykreme>
	<20040831113328.GA11830@wotan.suse.de>
	<413514D0.2020308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: anton@samba.org, ak@muc.de, akpm@osdl.org, linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

On Wed, 01 Sep 2004 10:16:16 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > Currently all I want is to disable SD_SHARE_POWER when one flag 
> > is set. A simple way to do this would be appreciated.
> > 
> 
> You can define ARCH_HAS_SCHED_TUNE, and define your own
> SD_SIBLING_INIT, SD_CPU_INIT, SD_NODE_INIT. Also, you just

Hmm, it seems to be evaluated at run time. That may actually
work. 

Basically i just need a function call to determine the flags
for SD_SIBLING_INIT.


-Andi
