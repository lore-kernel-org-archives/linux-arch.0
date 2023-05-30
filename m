Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D89C7EE23
	for <linux-arch@archiver.kernel.org>; Tue, 30 May 2023 12:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjE3MoW (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 30 May 2023 08:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjE3MoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 08:44:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28699184;
        Tue, 30 May 2023 05:43:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E3CAAB6;
        Tue, 30 May 2023 05:34:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1B753F67D;
        Tue, 30 May 2023 05:33:46 -0700 (PDT)
Date:   Tue, 30 May 2023 13:33:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        paulmck@kernel.org, peterz@infradead.org, sstabellini@kernel.org,
        will@kernel.org
Subject: Re: [PATCH 25/26] locking/atomic: docs: Add atomic operations to the
 driver basic API documentation
Message-ID: <ZHXtIj9cSfDpOpqL@FVFF77S0Q05N>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-26-mark.rutland@arm.com>
 <c38c6875-7ca2-55dd-a1ec-ce7f903b795d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38c6875-7ca2-55dd-a1ec-ce7f903b795d@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 24, 2023 at 11:10:48PM +0900, Akira Yokosawa wrote:
> On Mon, 22 May 2023 13:24:28 +0100, Mark Rutland wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Add the generated atomic headers to driver-api/basics.rst in order to
> > provide documentation for the Linux kernel's atomic operations.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: <linux-doc@vger.kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > [Mark: add atomic-long.h]
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Documentation/driver-api/basics.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
> > index 4b4d8e28d3be4..a1fbd97fb79fb 100644
> > --- a/Documentation/driver-api/basics.rst
> > +++ b/Documentation/driver-api/basics.rst
> > @@ -87,6 +87,12 @@ Atomics
> >  .. kernel-doc:: arch/x86/include/asm/atomic.h
> >     :internal:
> >  
> > +.. kernel-doc:: include/linux/atomic/atomic-arch-fallback.h
> > +   :internal:
> > +
> > +.. kernel-doc:: include/linux/atomic/atomic-long.h
> > +   :internal:
> > +
> 
> Why not add
> 
>   .. kernel-doc:: include/linux/atomic/atomic-instrumented.h
>      :internal:
> 
> as well ??
> 
> I think those kernel-doc comments are the most relevant ones
> for driver writers.

Yes, that should be there too.

I've added that (and dropped the x86 header) with an updated commit message.

Thanks,
Mark.
