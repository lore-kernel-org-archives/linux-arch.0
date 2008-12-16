Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:60680 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbYLPVfE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Dec 2008 16:35:04 -0500
Message-ID: <49481EF9.3090304@redhat.com>
Date: Tue, 16 Dec 2008 22:34:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] preadv & pwritev syscalls.
References: <1229340977-24345-1-git-send-email-kraxel@redhat.com> <20081215160311.GA23153@linux-mips.org> <4946C4B4.1020605@redhat.com> <20081216160502.GA15331@linux-mips.org> <4947DBFA.9050108@redhat.com> <20081216170209.GC410@bombadil.infradead.org>
In-Reply-To: <20081216170209.GC410@bombadil.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@infradead.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20081216213449.0VlqibVrraBhJzjotFnlH76gh65sLtxPLfEO_WckHLQ@z>

Kyle McMartin wrote:
> On Tue, Dec 16, 2008 at 05:48:58PM +0100, Gerd Hoffmann wrote:
>> i.e. the ordering of the splitted argument depends on the os endianness?
>> What is the reason for this?
> 
> Eh? The splitting will occur at the C ABI level, not as a result of
> glibc (though, it could be done that way if you really wanted, but then
> you're just moving the wrapper up the chain.)

Ah, ok.  You'll just declare 64bit arg for userspace, gcc splits it into
two 32bit in native byte order, and then the kernel picks up the two
32bit values and has to reassemble them correctly, right?

The application-visible API must be compatible to the existing
implementations, i.e. this ...

   pread(long fd, struct iovec *vec, long vlen, off_t pos);

... prototype with the unaligned 64bit pos argument (in 32compat case).

Looks like there is no way around wrapping stuff then for the archs
wanting aligned 64bit values.  The only choice we have is to do the
wrap-o-magic in glibc or in the kernel.

I'd tend handle the wrapping in kernel space then because it is less
confusing and we have to wrap only in case the ABI for $arch requires it.

Comments?

  Gerd
