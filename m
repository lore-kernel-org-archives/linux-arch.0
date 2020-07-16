From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: clean up address limit helpers v2
Date: Thu, 16 Jul 2020 16:49:24 -0700
Message-ID: <20200716164924.15e373f4dbb3071e9d4ee37c@linux-foundation.org>
References: <20200714105505.935079-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgGPXtZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jul 2020 19:49:25 -0400
In-Reply-To: <20200714105505.935079-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 12:54:59 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> in preparation for eventually phasing out direct use of set_fs(), this
> series removes the segment_eq() arch helper that is only used to
> implement or duplicate the uaccess_kernel() API, and then adds
> descriptive helpers to force the kernel address limit.
> 
> 
> Changes since v1:
>  - drop to incorrect hunks
>  - fix a commit log typo

I think this *is* v1.  I can't find any differences in the patches and I
was unable to eyeball any changelog alterations?
