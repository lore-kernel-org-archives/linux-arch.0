From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: xfs failure on parisc (and presumably other VI cache systems)
 caused by I/O to vmalloc/vmap areas
Date: Mon, 12 Oct 2009 23:13:03 -0500
Message-ID: <1255407183.2850.1235.camel@localhost.localdomain>
References: <1252434469.13003.3.camel@mulgrave.site>
	 <20091013014040.GA7931@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47205 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbZJMENo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Oct 2009 00:13:44 -0400
In-Reply-To: <20091013014040.GA7931@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org

On Tue, 2009-10-13 at 03:40 +0200, Christoph Hellwig wrote:
> So what's going to happen with this patch series?  Can we expect it to
> get merged one day?

Well, we need it for parisc, so we can just push it through our tree.  I
was sort of hoping for confirmation that the other arch bits worked ...
but they can't be more broken than they are today, so I suppose the risk
is low.

James
