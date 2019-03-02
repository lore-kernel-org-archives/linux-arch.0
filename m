From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date: Sun, 3 Mar 2019 00:27:12 +0900
Message-ID: <8fbdcdc0-1f4e-e268-c183-0d65be3d39c9@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226134906.GG32494@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

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
