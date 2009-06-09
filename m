From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/27] score arch files for linux
Date: Tue, 9 Jun 2009 20:19:06 +0200
Message-ID: <200906092019.06812.arnd@arndb.de>
References: <OF54D30DF0.6974DE98-ON482575D0.0021670B-482575D0.00234606@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:63907 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbZFISTt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 14:19:49 -0400
In-Reply-To: <OF54D30DF0.6974DE98-ON482575D0.0021670B-482575D0.00234606@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> Hi Arnd, Andrew Morton and linus,
> 
> According to your comment on score arch code, 
> we update score code base on asm-generic#next repository.
> use arch microblaze and blackfin as reference.

Ok, just finished looking over the patches and I am generally
very happy about their quality, it usually takes much longer
for a submission of this size to get into a mergeable shape.

The only thing that I think needs to be fixed before a
2.6.31 release is my comment about unistd.h still containing
the __ARCH_WANT_SYSCALL_* #defines. I consider that my fault
because I did not make it clear enough what those are meant
for in asm-generic/unistd.h.

One more general thought: I noticed that you split the header
files by alphabetical ordering. While there is no good way to
split a set of interdependent files, a logical grouping
(e.g. ABI, memory management, device, cpu) would be nice.

Everything else I found are only polite suggestions of what
can still be improved, not issues that I think need to
be addressed immediately. I especially love how the work
that Remis and I put into the generic header files starts
paying off, because it makes reviewing an architecture so
much simpler.

Please add my 'Reviewed-by: Arnd Bergmann <arnd@arndb.de>'
to your patches.

Thanks,

	Arnd <><
