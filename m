Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3Lcf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 07:32:35 -0400
Date: Fri, 30 Aug 2019 13:32:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
Message-ID: <20190830113216.GE2369@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org>
 <cb9785b7-ed43-b91a-7392-e50216bd5771@gmail.com>
 <20190731202517.GF5913@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731202517.GF5913@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>, Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20190830113216.rBOIi9SP_NqC4GSXoL6gJskevfGo0lQTcgH-4yZaKos@z>

On Wed, Jul 31, 2019 at 01:25:17PM -0700, Paul E. McKenney wrote:
> Looks like a pretty clear consensus thus far.  Any objections to keeping
> these .txt for the time being?

Obviously I'm a huge proponent of abandoning RST and an advocate for
normal .txt files ;-)
