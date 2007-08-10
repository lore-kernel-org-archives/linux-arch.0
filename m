Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:39811 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbXHJXUG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Aug 2007 19:20:06 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 47/59] x86: optimize page faults like all other achitectures and kill notifier cruft
Date: Sat, 11 Aug 2007 01:17:33 +0200
References: <200708102200.l7AM0CnU011952@imap1.linux-foundation.org>
In-Reply-To: <200708102200.l7AM0CnU011952@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708110117.34171.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: hch@lst.de, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org, prasanna@in.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Saturday 11 August 2007 00:00:12 akpm@linux-foundation.org wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> x86(-64) are the last architectures still using the page fault notifier
> cruft for the kprobes page fault hook.  This patch converts them to the
> proper direct calls, and removes the now unused pagefault notifier bits
> aswell as the cruft in kprobes.c that was related to this mess.
> 
> I know Andi didn't really like this, but all other architecture maintainers
> agreed the direct calls are much better and besides the obvious cruft
> removal a common way of dealing with kprobes across architectures is
> important aswell.

This means the debuggers just have to readd it. Not merged.

If you worry about cycles notifiers could be probably optimized a bit
for the nothing registered case.

-Andi
