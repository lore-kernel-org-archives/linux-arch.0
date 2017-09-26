From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH for 4.14 2/3] membarrier: selftest: Test private
 expedited cmd
Date: Tue, 26 Sep 2017 23:15:20 +0200
Message-ID: <20170926211520.GA28529@kroah.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <20170926175151.14264-2-mathieu.desnoyers@efficios.com>
 <CAKocOOPtzm+P-hbUAGDwpPMbPdrbQSpkJH-ideDvsD4-uUZepw@mail.gmail.com>
 <1861482846.19234.1506455717905.JavaMail.zimbra@efficios.com>
 <CAKocOOMQ6Nk=Oytay2T12L0jT_3vnPgX5CEt=9+_kmTnFTfigg@mail.gmail.com>
 <998801080.19251.1506456925340.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <998801080.19251.1506456925340.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuahkhan@gmail.com>, Alice Ferrazzi <alice.ferrazzi@gmail.com>, Paul Elder <paul.elder@pitt.edu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kselftest <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 26, 2017 at 08:15:25PM +0000, Mathieu Desnoyers wrote:
> 
> 
> ----- On Sep 26, 2017, at 4:08 PM, Shuah Khan shuahkhan@gmail.com wrote:
> 
> > On Tue, Sep 26, 2017 at 1:55 PM, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >> ----- On Sep 26, 2017, at 3:41 PM, Shuah Khan shuahkhan@gmail.com wrote:
> >>
> >>> Hi Mathew,
> >>>
> >>> On Tue, Sep 26, 2017 at 11:51 AM, Mathieu Desnoyers
> >>> <mathieu.desnoyers@efficios.com> wrote:
> >>>> Test the new MEMBARRIER_CMD_PRIVATE_EXPEDITED and
> >>>> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED commands.
> >>>>
> >>>> Add checks expecting specific error values on system calls expected to
> >>>> fail.
> >>>>
> >>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>>> CC: Peter Zijlstra <peterz@infradead.org>
> >>>> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >>>> CC: Boqun Feng <boqun.feng@gmail.com>
> >>>> CC: Andrew Hunter <ahh@google.com>
> >>>> CC: Maged Michael <maged.michael@gmail.com>
> >>>> CC: gromer@google.com
> >>>> CC: Avi Kivity <avi@scylladb.com>
> >>>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>>> CC: Paul Mackerras <paulus@samba.org>
> >>>> CC: Michael Ellerman <mpe@ellerman.id.au>
> >>>> CC: Dave Watson <davejwatson@fb.com>
> >>>> CC: Alan Stern <stern@rowland.harvard.edu>
> >>>> CC: Will Deacon <will.deacon@arm.com>
> >>>> CC: Andy Lutomirski <luto@kernel.org>
> >>>> CC: linux-arch@vger.kernel.org
> >>>> ---
> >>>>  .../testing/selftests/membarrier/membarrier_test.c | 109
> >>>
> >>> Did you run get_maintainers script on this patch? I am curious why
> >>> get_maintainers didn't include linux-kselftest@vger.kernel.org and
> >>> shuah@kernel.org
> >>
> >> My mistake. I'll add this script to my checklist before I send out
> >> patches.
> >>
> >> If OK with you, I can just add the ML in CC here.
> >>
> > 
> > Please add everybody get_maintainers suggest for this patch as well.
> > If this patch is going through linux-kselftest, you will have to resend the
> > patch to me at some point, so I can pull it in.
> > 
> > I am guessing this has dependency on the other patches in the series
> > and will go through the primary tree. In that case CC is just fine and I will
> > review it and Ack it.
> 
> Indeed, it has a dependency on another patch part of this
> series, which is aimed to go through Paul E. McKenney's tree.
> 
> Adding Greg, Alice, and Paul Elder in CC as suggested by get_maintainers.
> 
> Do you need me to re-send the series, or is this thread ok ?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
