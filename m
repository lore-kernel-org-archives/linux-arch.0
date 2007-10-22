Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51987 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304AbXJVSME (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Oct 2007 14:12:04 -0400
Date: Mon, 22 Oct 2007 11:11:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: - kexec-introduce-bootmem_exclusive.patch removed from -mm tree
Message-Id: <20071022111135.0f7527ea.akpm@linux-foundation.org>
In-Reply-To: <20071022130222.GB16201@suse.de>
References: <200710212315.l9LNF7nT031930@imap1.linux-foundation.org>
	<20071022130222.GB16201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Bernhard Walle <bwalle@suse.de>
Cc: ebiederm@xmission.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@in.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 22 Oct 2007 15:02:22 +0200 Bernhard Walle <bwalle@suse.de> wrote:

> * Andrew Morton <akpm@linux-foundation.org> [2007-10-22 01:08]:
> > 
> > The patch titled
> >      kexec: introduce BOOTMEM_EXCLUSIVE
> > has been removed from the -mm tree.  Its filename was
> >      kexec-introduce-bootmem_exclusive.patch
> > 
> > This patch was dropped because it had testing failures
> 
> Is it possible for me to find out which "testing failures" the patch
> had?
> 

I didn't realise that it actually breaks the build on all non-x86.  I
cannot carry a patch like that.
