Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLITsX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Dec 2019 14:48:23 -0500
Date: Mon, 9 Dec 2019 20:48:19 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: RFC: kill off ioremap_nocache
Message-ID: <20191209194819.GA28157@lst.de>
References: <20191209135823.28465-1-hch@lst.de> <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mips <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <20191209194819.shw1AikQcBLNPmQCl-UwMwpz4aGvgTum3o8Aeadlgo0@z>

On Mon, Dec 09, 2019 at 10:48:20AM -0800, Linus Torvalds wrote:
> How many conflicts will this result in generally? I like it, but I'd
> like to have some idea of whether it ends up being one of those
> "really painful churn" things?
> 
> A couple of conflicts isn't an issue - they'll be trivial to fix. It's
> the "this causes fifty silly conflicts" that I worry about, partly
> because it then makes submaintainers inevitably do the wrong thing (ie
> "I foresee an excessive amount of 'git rebase' rants next release").

I had about a dozend and a half conflicts rebasing this weekend,
the previous version was approx -rc6 IIRC.
