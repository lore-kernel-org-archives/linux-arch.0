Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:64416 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262031AbUCDRLW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2004 12:11:22 -0500
Date: Thu, 4 Mar 2004 18:11:23 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: disable_hlt()/enable_hlt() look racy
Message-Id: <20040304181123.3b21f357.ak@suse.de>
In-Reply-To: <200403041001.42725.bjorn.helgaas@hp.com>
References: <200403041001.42725.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-arch@vger.kernel.org, awilliam@fc.hp.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 4 Mar 2004 10:01:42 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Alex Williamson implemented disable_hlt()/enable_hlt() for ia64,
> and in the process, we noticed that the implementations on
> other architectures look racy because hlt_counter is not
> protected.

As far as I can see only the floppy driver calls it ever and 
and it does so from inside an own spinlock.

But I agree that it's better to use atomic_t. I will do that
change for x86-64.

-Andi
