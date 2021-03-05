Return-Path: <SRS0=VMqq=ID=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF69C433E6
	for <linux-arch@archiver.kernel.org>; Fri,  5 Mar 2021 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3A5650A3
	for <linux-arch@archiver.kernel.org>; Fri,  5 Mar 2021 18:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCESkv (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:40:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:49802 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhCESk3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 13:40:29 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 125IX2ju027144;
        Fri, 5 Mar 2021 12:33:02 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 125IX0sO027136;
        Fri, 5 Mar 2021 12:33:00 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 5 Mar 2021 12:33:00 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-arch@vger.kernel.org, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, danielwa@cisco.com
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command line.
Message-ID: <20210305183300.GX29191@gate.crashing.org>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu> <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu> <20210303172810.GA19713@willie-the-truck> <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu> <20210303174627.GC19713@willie-the-truck> <dc6576ac-44ff-7db4-d718-7565b83f50b8@csgroup.eu> <20210303181651.GE19713@willie-the-truck> <87sg59rewl.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg59rewl.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 10:58:02PM +1100, Michael Ellerman wrote:
> Will Deacon <will@kernel.org> writes:
> > That's very similar to us; we're not relocated, although we are at least
> > in control of the MMU (which is using a temporary set of page-tables).
> 
> prom_init runs as an OF client, with the MMU off (except on some Apple
> machines), and we don't own the MMU. So there's really nothing we can do :)

You *could* take over all memory mapping.  This is complex, and I
estimate the change you get this to work correctly on all supported
systems to be between -400% and 0%.

And not very long later Linux jettisons OF completely anyway.

> Though now that I look at it, I don't think we should be doing this
> level of commandline handling in prom_init. It should just grab the
> value from firmware and pass it to the kernel proper, and then all the
> prepend/append/force etc. logic should happen there.

That sounds much simpler, yes :-)


Segher
