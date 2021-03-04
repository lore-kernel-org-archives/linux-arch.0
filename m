Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDA5C3F694
	for <linux-arch@archiver.kernel.org>; Thu,  4 Mar 2021 00:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A470D64F3A
	for <linux-arch@archiver.kernel.org>; Thu,  4 Mar 2021 00:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhCDAtX (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1453090AbhCDApT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 19:45:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA19D64E56;
        Thu,  4 Mar 2021 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818678;
        bh=8wUvzvMV9XoVLQ9s0QU1nWZT0dd0CJC4pPcE0vc7trM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=m8qrEh7xqoIYY6TjnJNQ7ZbWIo1Kg/RgdA872Sx4xSw3erYLxdIayemAOBHQlp3E5
         DMWjn4xVnWUDcfmJ7ovzxu1+vZpQ4hc5+O20Zh+fAIAr/qcygPOZHhBy6w8ALNeFpE
         TZbfysXoDDyw8EM6C4sYeMftcfjd0a8SZFVuX7Fl6Z4gWYQQ050rfgehENApz8yOFc
         d2FuXHZmaRH1dCQYLe0qRney71YDfvFPkyU4v+Zj3ZQ0fs9ceuBn3kQZGy0E7TqsEA
         /j44JFY7YmLKvsCBNzktW+3YYYO0A/zOnvjVg1BvZ9CBrZfk8yC+D+c2vbmxigXoGh
         fB/hikz2W6MHA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 780663522591; Wed,  3 Mar 2021 16:44:38 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:44:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/3] LKMM updates for v5.13
Message-ID: <20210304004438.GA25271@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series contains LKMM updates:

1.	Update rcu_dereference.rst reference, courtesy of Mauro Carvalho
	Chehab.

2.	tools/memory-model: Remove reference to atomic_ops.rst, courtesy
	of Akira Yokosawa.

3.	tools/memory-model: Add access-marking documentation.

						Thanx, Paul

------------------------------------------------------------------------

 access-marking.txt |  474 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 glossary.txt       |    2 
 simple.txt         |    1 
 3 files changed, 475 insertions(+), 2 deletions(-)
