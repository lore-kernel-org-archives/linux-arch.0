From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Fri, 22 May 2015 06:11:26 -0700
Message-ID: <20150522131126.GF6776@linux.vnet.ibm.com>
References: <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520154617.GE11498@arm.com>
 <20150520181606.GT6776@linux.vnet.ibm.com>
 <20150521192422.GC19204@arm.com>
 <20150521200212.GW6776@linux.vnet.ibm.com>
 <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
 <20150522064344.GA17518@gmail.com>
 <20150522104332.5FBFF33CA8@vlsi1.gnat.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:40802 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441AbbEVNLg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2015 09:11:36 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 22 May 2015 07:11:36 -0600
Content-Disposition: inline
In-Reply-To: <20150522104332.5FBFF33CA8@vlsi1.gnat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kenner <kenner@vlsi1.ultra.nyu.edu>
Cc: mingo@kernel.org, akpm@linux-foundation.org, c++std-parallel@accu.org, dhowells@redhat.com, gcc@gcc.gnu.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mark.Batty@cl.cam.ac.uk, michaelw@ca.ibm.com, Peter.Sewell@cl.cam.ac.uk, peterz@infradead.org, Ramana.Radhakrishnan@arm.com, torvalds@linux-foundation.org, will.deacon@arm.com

On Fri, May 22, 2015 at 06:43:32AM -0400, Richard Kenner wrote:
> > (Assuming it's a goal of this standard to be human parseable to more 
> > than a few dozen people on the planet.)
> 
> Unfortunately, that's rarely a goal of most standards. ;-)

My experience does match Richard's, sad to say.  There has been some
vigorous discussion in another thread involving undefined behavior and
value narrowing, which has resulted in some useful changes to Section 7.9.
The updated document is here:

	http://www2.rdrop.com/users/paulmck/RCU/consume.2015.05.22a.pdf

							Thanx, Paul
