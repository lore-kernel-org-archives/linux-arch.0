From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: USE_ELF_CORE_DUMP?
Date: Thu, 23 Apr 2009 12:48:23 -0600
Message-ID: <20090423184823.GV1926@parisc-linux.org>
References: <20090423183331.GA19899@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:41362 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbZDWSsY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Apr 2009 14:48:24 -0400
Content-Disposition: inline
In-Reply-To: <20090423183331.GA19899@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org

On Thu, Apr 23, 2009 at 08:33:31PM +0200, Christoph Hellwig wrote:
> Currently all architectures but microblaze unconditionally define
> USE_ELF_CORE_DUMP.  The microblaze ommision seems like an error to
> me, so can we just kill this ifdef and make sure we are the same
> everywhere?

That's presumably a leftover from a.out days ... kill it.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
