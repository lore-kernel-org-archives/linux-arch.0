Return-Path: <SRS0=OX6G=DU=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628EAC433DF
	for <linux-arch@archiver.kernel.org>; Tue, 13 Oct 2020 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0EF252BA
	for <linux-arch@archiver.kernel.org>; Tue, 13 Oct 2020 16:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgJMQih (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 13 Oct 2020 12:38:37 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46233 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727535AbgJMQih (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Oct 2020 12:38:37 -0400
Received: (qmail 676836 invoked by uid 1000); 13 Oct 2020 12:38:36 -0400
Date:   Tue, 13 Oct 2020 12:38:36 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
Message-ID: <20201013163836.GC670875@rowland.harvard.edu>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
 <20201013163354.GO3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013163354.GO3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 13, 2020 at 09:33:54AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 13, 2020 at 02:14:29PM +0200, Mauro Carvalho Chehab wrote:
> > - The sysfs.txt file was converted to ReST and renamed;
> > - The control-dependencies.txt is not at
> >   Documentation/control-dependencies.txt. As it is at the
> >   same dir as the README file, which mentions it, just
> >   remove Documentation/.
> > 
> > With that, ./scripts/documentation-file-ref-check script
> > is now happy again for files under tools/.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Queued for review and testing, likely target v5.11.

Instead of changing the path in the README reference, shouldn't 
tools/memory-model/control-dependencies.txt be moved to its proper 
position in .../Documentation?

Alan Stern
