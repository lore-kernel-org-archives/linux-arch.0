Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:54952 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbXGQLmu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2007 07:42:50 -0400
Date: Tue, 17 Jul 2007 05:42:48 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch 041/234] Report that kernel is tainted if there was an OOPS
Message-ID: <20070717114248.GA14791@parisc-linux.org>
References: <200707171103.l6HB3gDf013411@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707171103.l6HB3gDf013411@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, xemul@openvz.org, linux-arch@vger.kernel.org, randy.dunlap@oracle.com, Kyle McMartin <kyle@mcmartin.ca>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 17, 2007 at 04:03:42AM -0700, akpm@linux-foundation.org wrote:
> From: Pavel Emelianov <xemul@openvz.org>
> 
> If the kernel OOPSed or BUGed then it probably should be considered as
> tainted.  Thus, all subsequent OOPSes and SysRq dumps will report the
> tainted kernel.  This saves a lot of time explaining oddities in the
> calltraces.

Any reason parisc is missing?

diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index c3ec9f1..07a4e7b 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -264,6 +264,7 @@ KERN_CRIT "                     ||     ||\n");
 
 	show_regs(regs);
 	dump_stack();
+	add_taint(TAINT_DIE);
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
