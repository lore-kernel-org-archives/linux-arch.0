Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793FC77B6C
	for <linux-arch@archiver.kernel.org>; Thu,  6 Apr 2023 21:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjDFVgR (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDFVgQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 17:36:16 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 74BCAC5
        for <linux-arch@vger.kernel.org>; Thu,  6 Apr 2023 14:36:14 -0700 (PDT)
Received: (qmail 23178 invoked by uid 1000); 6 Apr 2023 17:36:13 -0400
Date:   Thu, 6 Apr 2023 17:36:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Will Deacon <will@kernel.org>
Subject: Litmus test names
Message-ID: <e00896d4-29e6-4373-b1c2-a995ffb0fdf5@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Paul:

I just saw that two of the files in tools/memory-model/litmus-tests have 
almost identical names:

	Z6.0+pooncelock+pooncelock+pombonce.litmus
	Z6.0+pooncelock+poonceLock+pombonce.litmus

They differ only by a lower-case 'l' vs. a capital 'L'.  It's not at all 
easy to see, and won't play well in case-insensitive filesystems.

Should one of them be renamed?

Alan
