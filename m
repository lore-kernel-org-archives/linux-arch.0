Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfHLSHF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 14:07:05 -0400
Date: Mon, 12 Aug 2019 11:06:49 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 27/31] tools/memory-model: Add data-race
 capabilities to judgelitmus.sh
Message-ID: <20190812180649.GM28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
 <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190812180649.nBkQo-ujolXiGS5Ia4xwX5OelMUoiB-wQ5WqXJD-TIY@z>

On Mon, Aug 12, 2019 at 11:32:35PM +0900, Akira Yokosawa wrote:
> Hi Paul,
> (CC: using Andrea's gmail address, adding Daniel)

Good point, I did forget to update at my end.  Fixed, thank you!

> Sorry for slow response, but please find inline comments below.
> 
> On Thu, 1 Aug 2019 15:20:52 -0700, Paul E. McKenney wrote:
> > This commit adds functionality to judgelitmus.sh to allow it to handle
> > both the "DATARACE" markers in the "Result:" comments in litmus tests
> > and the "Flag data-race" markers in LKMM output.  For C-language tests,
> > if either marker is present, the other must also be as well, at least for
> > litmus tests having a "Result:" comment.  If the LKMM output indicates
> > a data race, then failures of the Always/Sometimes/Never portion of the
> > "Result:" prediction are forgiven.
> 
> I'd like to see the reason _why_ they can be forgiven. Also, updating
> the header comment of judgelitimus.sh to mention these expansions would
> be of much help.
> 
> My guess is any data-race would moot the Always/Sometimes/Never
> prediction.

Exactly.  And good point, I will update the commit log to make this
explicit.

> This reminds me that update of LKMM documentation regarding plain
> accesses (data races) is yet to come.

Yes, this one is still on the to-do list.  Timely reminder, though!  ;-)

							Thanx, Paul

>         Thanks, Akira
> 
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
> > index ca9a19829d79..eaa2cc7d3b36 100755
> > --- a/tools/memory-model/scripts/judgelitmus.sh
> > +++ b/tools/memory-model/scripts/judgelitmus.sh
> > @@ -47,9 +47,27 @@ else
> >  	echo ' --- ' error: \"$LKMM_DESTDIR/$litmusout is not a readable file
> >  	exit 255
> >  fi
> > +if grep -q '^Flag data-race$' "$LKMM_DESTDIR/$litmusout"
> > +then
> > +	datarace_modeled=1
> > +fi
> >  if grep -q '^ \* Result: ' $litmus
> >  then
> >  	outcome=`grep -m 1 '^ \* Result: ' $litmus | awk '{ print $3 }'`
> > +	if grep -m1 '^ \* Result: .* DATARACE' $litmus
> > +	then
> > +		datarace_predicted=1
> > +	fi
> > +	if test -n "$datarace_predicted" -a -z "$datarace_modeled" -a -z "$LKMM_HW_MAP_FILE"
> > +	then
> > +		echo '!!! Predicted data race not modeled' $litmus
> > +		exit 252
> > +	elif test -z "$datarace_predicted" -a -n "$datarace_modeled"
> > +	then
> > +		# Note that hardware models currently don't model data races
> > +		echo '!!! Unexpected data race modeled' $litmus
> > +		exit 253
> > +	fi
> >  elif test -n "$LKMM_HW_MAP_FILE" && grep -q '^Observation' $LKMM_DESTDIR/$lkmmout > /dev/null 2>&1
> >  then
> >  	outcome=`grep -m 1 '^Observation ' $LKMM_DESTDIR/$lkmmout | awk '{ print $3 }'`
> > @@ -114,7 +132,7 @@ elif grep '^Observation' $LKMM_DESTDIR/$litmusout | grep -q $outcome || test "$o
> >  then
> >  	ret=0
> >  else
> > -	if test -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes
> > +	if test \( -n "$LKMM_HW_MAP_FILE" -a "$outcome" = Sometimes \) -o -n "$datarace_modeled"
> >  	then
> >  		flag="--- Forgiven"
> >  		ret=0
> > 
> 
