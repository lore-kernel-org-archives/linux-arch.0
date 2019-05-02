Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOBf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 May 2019 10:01:35 -0400
Date: Thu, 2 May 2019 16:01:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: remove asm-generic/ptrace.h
Message-ID: <20190502140122.GC7323@redhat.com>
References: <20190501173943.5688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501173943.5688-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190502140122.C3pQZAG-nc1SSedgjodQwb_g8sMVAC9ri0KtT4eIoXA@z>

On 05/01, Christoph Hellwig wrote:
>
> Hi all,
>
> asm-generic/ptrace.h is a little weird in that it doesn't actually
> implement any functionality, but it provided multiple layers of macros
> that just implement trivial inline functions.  We implement those
> directly in the few architectures and be off with a much simpler
> design.

Oh, thanks, I was always confused by these macros ;)

Oleg.
