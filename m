Return-Path: <SRS0=028w=A4=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:58073 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726079AbgGQO0e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 10:26:34 -0400
Date: Fri, 17 Jul 2020 10:26:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200717142632.GA1147780@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20200717142632.83kzd8_XyvNp0fZCo5D-JkrTRc9SFmwk6PmDgg5E7CU@z>

On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:

...
> +Note that when the cmpxchg_release() fails due to another task already
> +having done it, a second smp_load_acquire() is required, since we still
> +need to acquire the data that the other task released.

When people talk about releasing data, they usually mean something 
different from what you mean here (i.e., they usually mean 
deallocating).  Likewise, acquiring data (to the extent that it means 
anything) would generally be regarded as meaning a simple read.  I 
recommend changing the last phrase above to:

	... since we still need a load-acquire of the data on which
	the other task performed a store-release.

Alan Stern
