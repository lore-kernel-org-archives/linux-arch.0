From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: [PATCH v2 06/19] OpenRISC: PTrace
Date: Sun, 3 Jul 2011 21:40:09 +0200
Message-ID: <20110703194009.GA4366@joi.lan>
References: <1309641352-18714-1-git-send-email-jonas@southpole.se>
 <1309641352-18714-7-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:63324 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1GCTkd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2011 15:40:33 -0400
Content-Disposition: inline
In-Reply-To: <1309641352-18714-7-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Jul 02, 2011 at 11:15:39PM +0200, Jonas Bonn wrote:
> +	pr_debug(KERN_INFO
> +		 "ptrace get_next_address: pc 0x%.8lx insn. 0x%.8lx opc. 0x%.2x\n",
> +		 pc, insn, opc);
> +

This evaluates to printk(KERN_DEBUG KERN_INFO "ptrace...", ...), which does not seem
to be ok ;). This mistake is repeated several times in this patchset...

Marcin
