Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:41119 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767421AbXCIRVO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Mar 2007 12:21:14 -0500
Subject: Re: [PATCH] Complain about missing system calls.
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <p737itqbdnl.fsf@bingen.suse.de>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	 <p737itqbdnl.fsf@bingen.suse.de>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 17:20:02 +0000
Message-Id: <1173460802.12760.2.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, rmk@arm.linux.org.uk, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-03-09 at 17:11 +0100, Andi Kleen wrote:
> Of course the existing syscall numbers can't be changed, but for all new 
> calls one could just add automatically for everybody.
> 
> A global table with two entries (compat and non compat) and a per arch 
> override table should be sufficient.

Counterexample: sys_epoll_pwait.

It'd be nice if it were that simple.

It'd also be nice if people stopped thinking it was that simple :)

-- 
dwmw2

