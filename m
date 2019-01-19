Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46410 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfASSfr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Jan 2019 13:35:47 -0500
MIME-Version: 1.0
References: <20190102205715.14054-1-mst@redhat.com> <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
 <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com> <20190109094959-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190109094959-mutt-send-email-mst@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 19 Jan 2019 19:35:33 +0100
Message-ID: <CANiq72npFGsoHmBQUSNRLohDmMBNQFka8AcmhMz--QU1v2Aorg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Eli Friedman <efriedma@codeaurora.org>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, Eric Christopher <echristo@google.com>
Message-ID: <20190119183533.eP3vcfRatHXBf24AEDYyUIwesrSsLcBxdokBZPAvi-s@z>

Hi Michael,

On Wed, Jan 9, 2019 at 3:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 09, 2019 at 11:35:52AM +0100, Miguel Ojeda wrote:
> > Note it would be nice to separate the patch into two (one for the
> > comments, another for OPTIMIZER_HIDE_VAR), and also possibly another
> > for barrier_data().
>
> Okay, I will try.

Did you have a chance to do it (or maybe I missed the patches)? If
not, no worries, I can send this to Linus as it is and get it in
already, then we can do the barrier_data later.

Cheers,
Miguel
