From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 9/10] parisc: convert to generic helpers for IPI
	function calls
Date: Mon, 2 Jun 2008 12:09:43 -0400
Message-ID: <20080602160943.GB25011@phobos.i.cabal.ca>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com> <1212051504-12561-10-git-send-email-jens.axboe@oracle.com> <20080531070049.GA6623@phobos.i.cabal.ca> <20080602081749.GG5757@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:39712 "EHLO
	phobos.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYFBQJt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 12:09:49 -0400
Content-Disposition: inline
In-Reply-To: <20080602081749.GG5757@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>

On Mon, Jun 02, 2008 at 10:17:50AM +0200, Jens Axboe wrote:
> On Sat, May 31 2008, Kyle McMartin wrote:
> > On Thu, May 29, 2008 at 10:58:23AM +0200, Jens Axboe wrote:
> > > This converts parisc to use the new helpers for smp_call_function() and
> > > friends, and adds support for smp_call_function_single(). Not tested,
> > > not even compiled.
> > > 
> > > Cc: Kyle McMartin <kyle@parisc-linux.org>
> > > Cc: Matthew Wilcox <matthew@wil.cx>
> > > Cc: Grant Grundler <grundler@parisc-linux.org>
> > > Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> > >  
> > 
> > Do you have all this in an easily accessible git tree that I can merge
> > to test?
> 
> Yep, you can pull:
> 
> git://git.kernel.dk/linux-2.6-block.git generic-ipi
> 
> to get this patchset. I should have mentioned that in the intro
> mail...
> 

Thanks, I'll try it out this evening.

r, Kyle
