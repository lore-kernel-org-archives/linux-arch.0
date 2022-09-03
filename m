Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA57ECAAD4
	for <linux-arch@archiver.kernel.org>; Sat,  3 Sep 2022 15:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiICPyb (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 3 Sep 2022 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiICPya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 11:54:30 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5F65138A7
        for <linux-arch@vger.kernel.org>; Sat,  3 Sep 2022 08:54:28 -0700 (PDT)
Received: (qmail 304901 invoked by uid 1000); 3 Sep 2022 11:54:27 -0400
Date:   Sat, 3 Sep 2022 11:54:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <Paul.Heidekrueger@in.tum.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH v3] tools/memory-model: Weaken ctrl dependency definition
 in explanation.txt
Message-ID: <YxN4s+ZcPiV7u5XG@rowland.harvard.edu>
References: <20220902211341.2585133-1-paul.heidekrueger@in.tum.de>
 <YxKtmk2q8Uzb+Qk9@rowland.harvard.edu>
 <D7E3D42D-2ABE-4D16-9DCA-0605F0C84F7D@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7E3D42D-2ABE-4D16-9DCA-0605F0C84F7D@in.tum.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 03, 2022 at 01:41:34PM +0200, Paul Heidekrüger wrote:
> On 3. Sep 2022, at 03:27, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Fri, Sep 02, 2022 at 09:13:40PM +0000, Paul Heidekrüger wrote:
> >> +Finally, a read event X and another memory access event Y are linked by
> >> +a control dependency if Y syntactically lies within an arm of an if
> >> +statement and X affects the evaluation of the if condition via a data or
> >> +address dependency (or similarly for a switch statement).  Simple
> >> +example:
> >> 
> >> 	int x, y;
> 
> Hang on, shouldn't this read "a write event" instead of "another memory
> access event"? Control dependencies only provide ordering from READ_ONCE to
> WRITE_ONCE, not from READ_ONCE to (READ | WRITE)_ONCE?
> 
> Or am I missing something?

Whoops, you're right.  Somehow I missed that.  Go ahead and change it; 
you can keep by S-O-B.

Alan
