Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40977 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfCBP1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Mar 2019 10:27:23 -0500
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
References: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <8fbdcdc0-1f4e-e268-c183-0d65be3d39c9@gmail.com>
Date: Sun, 3 Mar 2019 00:27:12 +0900
MIME-Version: 1.0
In-Reply-To: <20190226134906.GG32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190302152712.byv5KJURd0o2nfU0kWH4pfsCQd-W3UjvywX61cap3R0@z>

Hello Peter,

On Tue, 26 Feb 2019 14:49:06 +0100, Peter Zijlstra wrote:
> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
>> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
>>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
>>> still broken.
>>
>> As requested on IRC:
> 
> What I asked was if you could get your GCC developer friends to have a
> look at this :-)
> 

JFYI, there is a bugzilla ticket regarding this behavior of GCC
at https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61502,
which started on 13 June 2014 and the latest entry was on
02 Feb 2019.

        Thanks, Akira
