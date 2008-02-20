Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:53802 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbYBTHtS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Feb 2008 02:49:18 -0500
Message-ID: <47BBDB6E.5040109@suse.de>
Date: Wed, 20 Feb 2008 08:49:02 +0100
From: Frank Seidel <fseidel@suse.de>
MIME-Version: 1.0
Subject: Re: linux-next: Tree for Feb 20
References: <20080220163457.79b9189f.sfr@canb.auug.org.au>	<20080220055055.GC31832@kroah.com> <20080220175756.ab1ada1d.sfr@canb.auug.org.au>
In-Reply-To: <20080220175756.ab1ada1d.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

Stephen Rothwell wrote:
> That would work.  Chris has the right idea, though.  Just set up
> linux-next as a remote on any existing clone of Linus' tree and the
> "fetch" will forcibly update the linux-next/master branch (remember to
> not have that branch checked out when you fetch).
> 
> If you keep a continuing git tree for this, you will have the history of
> all the next trees because I tag each one.

Thanks for that hint. Added it to the FAQ on the Wiki
(http://linux.f-seidel.de/linux-next/pmwiki/).

Frank
