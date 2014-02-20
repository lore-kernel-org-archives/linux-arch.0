From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/5] arch: atomic rework
Date: Thu, 20 Feb 2014 01:20:49 -0800
Message-ID: <20140220092049.GA22688@linux.vnet.ibm.com>
References: <20140218030002.GA15857@linux.vnet.ibm.com>
 <CA+55aFyqLrj4d2TA+2aazRqXnbVsUvs0yaBL2D5rXF1G=Kiu_g@mail.gmail.com>
 <CA+55aFwsq5E8kMoEeHJJ1f2=+QAUCu_HndfPxHNz8fUBprS-jQ@mail.gmail.com>
 <1392740258.18779.7732.camel@triegel.csb>
 <CA+55aFw7QYEMFs0BCxqRJW3Cz=tLbaku-tmN6hLXPKP9jbom7Q@mail.gmail.com>
 <1392752867.18779.8120.camel@triegel.csb>
 <CA+55aFxQPxQ8WOaZL8yAqBA=Y4k2gDn4r4oepMyi0uL6XLzv3w@mail.gmail.com>
 <20140220040102.GM4250@linux.vnet.ibm.com>
 <CA+55aFwwscSzwTr+xRdirtTx7HzugmMY9HrDe0GBqNhn=AuNVA@mail.gmail.com>
 <20140220083032.GN4250@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:43400 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaBTJUz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2014 04:20:55 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 20 Feb 2014 02:20:55 -0700
Content-Disposition: inline
In-Reply-To: <20140220083032.GN4250@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Torvald Riegel <triegel@redhat.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>

On Thu, Feb 20, 2014 at 12:30:32AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2014 at 08:43:14PM -0800, Linus Torvalds wrote:

[ . . . ]

> So, if you make one of two changes to your example, then I will agree
> with you.  The first change is to have a real data dependency between
> the read of "a" and the second read:
> 
>  - Initial state:
> 
>    a = &c, b = 0; c = 0;
> 
>  - Thread 1 ("consumer"):
> 
>     if (atomic_read(&a, consume))

And the above should be "if (atomic_read(&a, consume) != &c)".  Sigh!!!

							Thanx, Paul

>          return *a;
>     /* not yet initialized */
>     return -1;
> 
>  - Thread 2 ("initializer"):
> 
>      b = some_value_lets_say_42;
>      /* We are now ready to party */
>      atomic_write(&a, &b, release);
