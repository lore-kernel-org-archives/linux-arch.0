Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:37474 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbZIHOPk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2009 10:15:40 -0400
Date: Tue, 8 Sep 2009 10:15:30 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all
	architectures [try #5]
Message-ID: <20090908141530.GQ19494@bombadil.infradead.org>
References: <20090904142440.GM19494@bombadil.infradead.org> <20090903015707.GL19494@bombadil.infradead.org> <20090902072053.3578.69125.stgit@warthog.procyon.org.uk> <20090902072129.3578.81364.stgit@warthog.procyon.org.uk> <29063.1252047959@redhat.com> <32631.1252074944@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32631.1252074944@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>, jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090908141530.gF3RHYwBytIZuEgwmSC4NM3xibm8doorcaTanCu_bi0@z>

On Fri, Sep 04, 2009 at 03:35:44PM +0100, David Howells wrote:
> Kyle McMartin <kyle@mcmartin.ca> wrote:
> 
> > I don't think this depends on the previous patches in the series... it
> > would probably be easiest if I just merged it with the rest of them
> > though...
> 
> The problem I've got is that patch 9/9 depends on this change, but James
> doesn't have your patch in his tree.
> 

I'm planning to submit the tracehook branch immediately after the merge
window opens... would it be a problem to do it in two quick stages?

Or just drop the parisc hunk until the rest of it goes upstream and then
send that along?

regards, Kyle
