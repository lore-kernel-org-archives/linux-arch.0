Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60115 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfLQSfN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Dec 2019 13:35:13 -0500
Date: Tue, 17 Dec 2019 19:35:10 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: RFC: kill off ioremap_nocache
Message-ID: <20191217183510.GA32372@lst.de>
References: <20191209135823.28465-1-hch@lst.de> <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mips <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <20191217183510.E8q7RQltuZuup8XWxPd3q7EP5WRTHgMNaQftJ83hIPg@z>

I've pushed this out to the for-next branch and thus linux-next.  Let's
see if anyone screams.
