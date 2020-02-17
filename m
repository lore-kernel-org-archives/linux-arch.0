Return-Path: <SRS0=3gME=4F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgBQLCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Feb 2020 06:02:22 -0500
Date: Mon, 17 Feb 2020 12:02:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Message-ID: <20200217110200.GO14914@hirez.programming.kicks-ass.net>
References: <20200214040132.91934-3-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141028280.1579-100000@iolanthe.rowland.org>
 <20200214235215.GB110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214235215.GB110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Message-ID: <20200217110200.0KYC9V5Pv7se884Z8OPtaxGY1wv5TWGjtLXmMpzBoas@z>

On Sat, Feb 15, 2020 at 07:52:15AM +0800, Boqun Feng wrote:
> I agree, and thanks for the suggestion! And I change the sentence in
> atomic_t.txt with:
> 
> 	A note for the implementation of atomic_set{}() is that it
> 	cannot break the atomicity of the RMW ops.
> 
> , since I think that part of the doc is more about the suggestion to
> anyone who want to implement the atomic_set(). Peter, is that OK to you?

Sure.
