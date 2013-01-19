Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47139 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab3ASDeJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 22:34:09 -0500
Date: Sat, 19 Jan 2013 03:34:07 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 19/76] ARC: Signal handling
Message-ID: <20130119033407.GK4939@ZenIV.linux.org.uk>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
 <1358511930-7424-20-git-send-email-vgupta@synopsys.com>
 <20130119032357.GB23552@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130119032357.GB23552@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Message-ID: <20130119033407.5fjfNEY-Dua28bviUZRFX1TiCmOhsPN3_1asDfO7kW8@z>

On Sat, Jan 19, 2013 at 03:23:57AM +0000, Al Viro wrote:
> ITYM current_pt_regs()...
> 
> > +	if (unlikely(is_do_ss_needed(magic)))
> > +		if (do_sigaltstack(&sf->uc.uc_stack, NULL, regs->sp) == -EFAULT)
> 	if (!restore_altstack(&sf->uc.uc_stack))
> please...

... only without the braino - if (restore_altstack(...))
