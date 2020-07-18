From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Sat, 18 Jul 2020 10:21:43 -0400
Message-ID: <20200718142143.GB1179836@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717205340.GR7625@magnolia>
 <20200718005857.GB2183@sol.localdomain>
 <20200718012555.GA1168834@rowland.harvard.edu>
 <20200718020001.GO5369@dread.disaster.area>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:33941 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726640AbgGROVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Jul 2020 10:21:44 -0400
Content-Disposition: inline
In-Reply-To: <20200718020001.GO5369@dread.disaster.area>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Sat, Jul 18, 2020 at 12:00:01PM +1000, Dave Chinner wrote:
> Recipes are aimed at people who simply don't understand any of that
> goobledegook. This won't help them -write correct code-.

Indeed.	 Perhaps this writeup belongs in a different document (with a 
pointer	from the recipes file), and the actual recipe itself should
await the development of a general and robust API.

Alan Stern
