From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 1/5] tools/memory-model: Add an exception for limitations
 on _unless() family
Date: Thu, 27 Feb 2020 13:16:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.2002271314081.1730-100000@iolanthe.rowland.org>
References: <20200227164901.jxwk26ey3i2n2yhu@yquem.inria.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200227164901.jxwk26ey3i2n2yhu@yquem.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Maranget <luc.maranget@inria.fr>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 27 Feb 2020, Luc Maranget wrote:

> > On Thu, 27 Feb 2020, Boqun Feng wrote:
> > 
> > > According to Luc, atomic_add_unless() is directly provided by herd7,
> > > therefore it can be used in litmus tests. So change the limitation
> > > section in README to unlimit the use of atomic_add_unless().
> > 
> > Is this really true?  Why does herd treat atomic_add_unless() different
> > from all the other atomic RMS ops?  All the other ones we support do
> > have entries in linux-kernel.def.
> 
> I think this to be true :)
> 
> As far as I remember atomic_add_unless is quite different fron other atomic
> RMW ops and called for a specific all-OCaml implementation, without an
> entry in linux-kernel.def. As to  atomic_long_add_unless, I was not aware
> of its existence.

Can you explain what is so different about atomic_add_unless?

Alan
