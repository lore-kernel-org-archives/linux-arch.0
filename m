Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7CECAAA3
	for <linux-arch@archiver.kernel.org>; Fri, 26 Aug 2022 16:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiHZQXm (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHZQXl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 12:23:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ADBDDB46;
        Fri, 26 Aug 2022 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RSEtVb8ScTY+XbkAjUrnggVuIxKCMda8Fd55AmgV0fE=; b=fa9QMCKdpqHUPNujkPgLB1i7at
        WfD+1EdVsjpFAP/NhxZcY7W6p2HcLnCYfdUB1EyznM7rJlCvfM8YyjWaE68VTDEi/Yp3SbR5TH0CY
        k7878izQCPeUPCgKyW9Bbmq0evzWZKIsEuXIjUOpGyrW1zKLFrFIMvyikRw2lwpqg6TVRDhabmzzM
        VAi44bDQlAUuiXu610xEBloWYCSzYnTwS+lElAgsgz24eAhB4adTGQ4gDkm7bas7WTsaGigvMX6WW
        dd/mh/HGknOMVN97PJrG8nu+uUGxzpXOwhZxNs4DrDt5faaZhr3JNFwAJoRH4id8l1ylBL3o3PY3Q
        dvqkVPBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRc7C-000gTQ-Fl; Fri, 26 Aug 2022 16:23:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 262579802D7; Fri, 26 Aug 2022 18:23:24 +0200 (CEST)
Date:   Fri, 26 Aug 2022 18:23:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 05:48:12AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> I have not yet done more than glance at this one, but figured I should
> send it along sooner rather than later.
> 
> "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
> Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
> Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
> https://arxiv.org/abs/2111.15240
> 
> The claim is that the queued spinlocks implementation with CNA violates
> LKMM but actually works on all architectures having a formal hardware
> memory model.
> 
> Thoughts?

So the paper mentions the following defects:

 - LKMM doesn't carry a release-acquire chain across a relaxed op

 - some babbling about a missing propagation -- ISTR Linux if stuffed
   full of them, specifically we require stores to auto propagate
   without help from barriers

 - some handoff that is CNA specific and I've not looked too hard at
   presently.


I think we should address that first one in LKMM, it seems very weird to
me a RmW would break the chain like that. Is there actual hardware that
doesn't behave?


