Return-Path: <SRS0=VMqq=ID=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618D3C433DB
	for <linux-arch@archiver.kernel.org>; Fri,  5 Mar 2021 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246EA6508D
	for <linux-arch@archiver.kernel.org>; Fri,  5 Mar 2021 15:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCEPhT (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:37:19 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40167 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230401AbhCEPg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:36:56 -0500
Received: (qmail 39458 invoked by uid 1000); 5 Mar 2021 10:36:55 -0500
Date:   Fri, 5 Mar 2021 10:36:55 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tools/memory-model: Fix smp_mb__after_spinlock() spelling
Message-ID: <20210305153655.GC38200@rowland.harvard.edu>
References: <20210305102823.415900-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210305102823.415900-1-bjorn.topel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 11:28:23AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> A misspelled invokation of git-grep, revealed that
-------------------^

Smetimes my brain is a little slow...  Do you confirm that this is a 
joke?

Alan
