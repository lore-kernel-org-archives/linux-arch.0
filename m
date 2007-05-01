Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:59081 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755475AbXEAD3P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Apr 2007 23:29:15 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7B3AE1226B
	for <linux-arch@vger.kernel.org>; Tue,  1 May 2007 05:29:14 +0200 (CEST)
Date: Tue, 1 May 2007 06:26:55 +0200
From: Andi Kleen <ak@suse.de>
Subject: You might need vmalloc_sync_all()
Message-ID: <20070501042655.GL25929@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Since someone mentioned again.

Right now only x86 implements vmalloc_sync_all(). But iff:

- Your module mappings might require a page fault calling C 
code in kernel
- You got a pagefault notifier at the beginning of the page fault
handler

you risk a endless pagefault recursion with modular pagefault
notifiers. vmalloc_sync_all should sync all the available mappings 
on notifier register so that the C pf handler is not called for module 
faults.

Apparently at least ARM has this problem.

If the kernel module fault is only assembler code without notifier
(e.g. to reload a TLB) it is probably not needed.

-Andi

