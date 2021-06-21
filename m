Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C1EC49361
	for <linux-arch@archiver.kernel.org>; Mon, 21 Jun 2021 03:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C01B60FE6
	for <linux-arch@archiver.kernel.org>; Mon, 21 Jun 2021 03:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhFUEAH (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 21 Jun 2021 00:00:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39846 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhFUEAH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 00:00:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E7B9C2AA8A;
        Sun, 20 Jun 2021 23:57:50 -0400 (EDT)
Date:   Mon, 21 Jun 2021 13:57:54 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, schwab@linux-m68k.org
Subject: Re: [PATCH v3 2/3] m68k: correctly handle IO worker stack frame
 set-up
In-Reply-To: <1624176865-15570-3-git-send-email-schmitzmic@gmail.com>
Message-ID: <1547f9bc-441-6cfb-ad7c-57f7584dd63@linux-m68k.org>
References: <1624176865-15570-1-git-send-email-schmitzmic@gmail.com> <1624176865-15570-3-git-send-email-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 20 Jun 2021, Michael Schmitz wrote:

> Patch suggested by Linus (authored, actually - replace my signoff if 
> that's not appropriate, please).
> 

When the patch author is not the message sender, the message (commit log 
entry) would normally begin with "From: Author <author@example.com>".

That way, 'git am' will automatically attribute the commit to the actual 
author instead of the message sender.

'git send-email' should generate the extra From: line automatically if you 
set the authorship on the commit appropriately (e.g. using 'git commit 
--reset-author').
