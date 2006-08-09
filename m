Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:175 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030418AbWHIC2B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2006 22:28:01 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Signal restarting happing multiple time in do_signal
Date: Wed, 9 Aug 2006 04:26:55 +0200
References: <20060808110437.GB18770@linux-mips.org> <20060808.152504.55835990.davem@davemloft.net>
In-Reply-To: <20060808.152504.55835990.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090426.55225.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: ralf@linux-mips.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> 
> So after the first iteration, the next time through here we
> won't be "from a system call".

Thanks for the analysis David. I agree it shouldn't be a problem for x86.

-Andi

