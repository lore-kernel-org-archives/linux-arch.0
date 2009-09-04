From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all
	architectures [try #5]
Date: Fri, 4 Sep 2009 10:24:40 -0400
Message-ID: <20090904142440.GM19494@bombadil.infradead.org>
References: <20090903015707.GL19494@bombadil.infradead.org> <20090902072053.3578.69125.stgit@warthog.procyon.org.uk> <20090902072129.3578.81364.stgit@warthog.procyon.org.uk> <29063.1252047959@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:33562 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836AbZIDOYt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2009 10:24:49 -0400
Content-Disposition: inline
In-Reply-To: <29063.1252047959@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>, jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Sep 04, 2009 at 08:05:59AM +0100, David Howells wrote:
> Kyle McMartin <kyle@mcmartin.ca> wrote:
> 
> > Please drop these bits. I have done similar for .32 in the tracehook
> > branch.
> 
> Can you send me the patch to do this, so that I can add it to my tree too?
> 

Yeah...
http://git.kernel.org/?p=linux/kernel/git/kyle/parisc-2.6.git;a=commitdiff;h=9f4259771faf1ffd99888796d925adae4c93630b

I don't think this depends on the previous patches in the series... it
would probably be easiest if I just merged it with the rest of them
though...

regards, Kyle
