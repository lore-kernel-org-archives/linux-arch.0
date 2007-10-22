Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755442AbXJVSOf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Oct 2007 14:14:35 -0400
Date: Mon, 22 Oct 2007 20:14:32 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: - kexec-introduce-bootmem_exclusive.patch removed from -mm tree
Message-ID: <20071022181432.GA28693@suse.de>
References: <200710212315.l9LNF7nT031930@imap1.linux-foundation.org> <20071022130222.GB16201@suse.de> <20071022111135.0f7527ea.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071022111135.0f7527ea.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ebiederm@xmission.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@in.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

* Andrew Morton <akpm@linux-foundation.org> [2007-10-22 20:11]:
> On Mon, 22 Oct 2007 15:02:22 +0200 Bernhard Walle <bwalle@suse.de> wrote:
> 
> > * Andrew Morton <akpm@linux-foundation.org> [2007-10-22 01:08]:
> > > 
> > > The patch titled
> > >      kexec: introduce BOOTMEM_EXCLUSIVE
> > > has been removed from the -mm tree.  Its filename was
> > >      kexec-introduce-bootmem_exclusive.patch
> > > 
> > > This patch was dropped because it had testing failures
> > 
> > Is it possible for me to find out which "testing failures" the patch
> > had?
> 
> I didn't realise that it actually breaks the build on all non-x86.  I
> cannot carry a patch like that.

That's clear, but I already posted the fixup patch for all other
architectures on Friday.



Thanks,
   Bernhard
