Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:41297 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbXBRVZR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 18 Feb 2007 16:25:17 -0500
Subject: Re: [RFC] killing the NR_IRQS arrays.
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20070216124117.GB4218@elte.hu>
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
	 <20070216124117.GB4218@elte.hu>
Content-Type: text/plain
Date: Sun, 18 Feb 2007 22:24:45 +0100
Message-Id: <1171833885.3261.208.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-02-16 at 13:41 +0100, Ingo Molnar wrote:
> * Eric W. Biederman <ebiederm@xmission.com> wrote:
> 
> > So I propose we remove all assumptions from the code that we actually 
> > have an array of irqs.  That will allow for irq_desc to be dynamically 
> > allocated instead of statically allocated saving memory and reducing 
> > kernel complexity.
> 
> hm. I'd suggest to do this without changing request_irq() - and then we 
> could avoid the 'massive, every driver affected' change, right?

if request_irq() changes we might as well make a variant that takes a
PCI device struct rather than a number, for the 99% of PCI drivers that
use that.. (and then msi and other stuff becomes simpler :)


