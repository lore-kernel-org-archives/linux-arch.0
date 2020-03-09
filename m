From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] docs: a few improvements for atomic_ops.rst
Date: Mon, 9 Mar 2020 10:06:50 +0100
Message-ID: <20200309090650.GF12561@hirez.programming.kicks-ass.net>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIJHH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 05:07:07 -0400
Content-Disposition: inline
In-Reply-To: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Mar 08, 2020 at 08:56:15PM +0100, Jonathan Neuschäfer wrote:
> Hi,
> 
> this is a short series of unrelated fixes that make the atomic
> operations documentation look and read a bit better.
> 
> Jonathan Neuschäfer (3):
>   docs: atomic_ops: Remove colons where they don't make sense
>   docs: atomic_ops: Move two paragraphs into the warning block above
>   docs: atomic_ops: Steer readers towards using refcount_t for reference
>     counts
> 
>  Documentation/core-api/atomic_ops.rst         | 24 ++++++++++++-------

FWIW, I consider this a dead document. I've written
Documentation/atomic_t.txt and Documentation/atomic_bitops.txt as a
replacement. If there is anything in atomic_ops you feel is missing from
those two, please tell as I'm planing to delete atomic_ops soon.
