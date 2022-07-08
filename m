Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6224EC433EF
	for <linux-arch@archiver.kernel.org>; Fri,  8 Jul 2022 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiGHOrG (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiGHOqu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jul 2022 10:46:50 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B6A4779688
        for <linux-arch@vger.kernel.org>; Fri,  8 Jul 2022 07:45:19 -0700 (PDT)
Received: (qmail 7716 invoked by uid 1000); 8 Jul 2022 10:45:06 -0400
Date:   Fri, 8 Jul 2022 10:45:06 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Marco Elver <elver@google.com>
Cc:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH v2] tools/memory-model: Clarify LKMM's limitations in
 litmus-tests.txt
Message-ID: <YshC8sJ4dZq3m2wy@rowland.harvard.edu>
References: <Yqdb3CZ8bKtbWZ+z@rowland.harvard.edu>
 <20220614154812.1870099-1-paul.heidekrueger@in.tum.de>
 <CANpmjNOkXz=+221i70CWJexQWwfA_By3+7Cnimwgjmwn7RQdBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNOkXz=+221i70CWJexQWwfA_By3+7Cnimwgjmwn7RQdBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 08, 2022 at 01:44:06PM +0200, Marco Elver wrote:
> On Tue, 14 Jun 2022 at 17:49, Paul Heidekrüger
> <paul.heidekrueger@in.tum.de> wrote:
> >
> > As discussed, clarify LKMM not recognizing certain kinds of orderings.
> > In particular, highlight the fact that LKMM might deliberately make
> > weaker guarantees than compilers and architectures.
> >
> > Link: https://lore.kernel.org/all/YpoW1deb%2FQeeszO1@ethstick13.dse.in.tum.de/T/#u
> > Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> > Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> However with the Co-developed-by, this is missing Alan's SOB.

For the record:

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

(Note that according to Documentation/process/submitting-patches.rst, 
the submitting author's SOB is supposed to come last.)

Alan
