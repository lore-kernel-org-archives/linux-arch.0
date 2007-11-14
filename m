Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pat.uio.no ([129.240.10.15]:39232 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927AbXKNWS4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2007 17:18:56 -0500
Subject: Re: [PATCH 3/3] nfs: use ->mmap_prepare() to avoid an AB-BA
	deadlock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <1195077034.22457.6.camel@lappy>
References: <20071114200136.009242000@chello.nl>
	 <20071114201528.514434000@chello.nl> <20071114212246.GA31048@wotan.suse.de>
	 <1195075905.22457.3.camel@lappy>
	 <1195076485.7584.66.camel@heimdal.trondhjem.org>
	 <1195077034.22457.6.camel@lappy>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 17:18:50 -0500
Message-Id: <1195078730.7584.86.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>


On Wed, 2007-11-14 at 22:50 +0100, Peter Zijlstra wrote:
> Right, but I guess what Nick asked is, if pages could be stale to start
> with, how is that avoided in the future.
> 
> The way I understand it, this re-validate is just a best effort at
> getting a coherent image.

The normal convention for NFS is to use a close-to-open cache
consistency model. In that model, applications must agree never to open
the file for reading or writing if an application on a different NFS
client already holds it open for writing.

However there is no standard locking model for _enforcing_ such an
agreement, so some setups do violate it. One obvious model that we try
to support is that where the applications are using POSIX locking in
order to ensure exclusive access to the data when requires.

Another model is to rely rather on synchronous writes and heavy
attribute revalidation to detect when a competing application has
written to the file (the 'noac' mount option). While such a model is
obviously deficient in that it can never guarantee cache coherency, we
do attempt to ensure that it works on a per-operation basis (IOW: we
check cache coherency before each call to read(), to mmap(), etc) since
it is by far the easiest model to apply if you have applications that
cannot be rewritten and that satisfy the requirement that they rarely
conflict.

Cheers
  Trond

