Return-Path: <SRS0=ECFR=CK=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1557C433E6
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 07:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C734E204EC
	for <linux-arch@archiver.kernel.org>; Tue,  1 Sep 2020 07:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIAHIs (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:08:48 -0400
Received: from verein.lst.de ([213.95.11.211]:52124 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHIq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 03:08:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B84668B05; Tue,  1 Sep 2020 09:08:42 +0200 (CEST)
Date:   Tue, 1 Sep 2020 09:08:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        lkp@lists.01.org, rui.zhang@intel.com, yu.c.chen@intel.com
Subject: Re: [fs] ef30fb3c60: kernel write not supported for file
 /sys/kernel/softlockup_panic
Message-ID: <20200901070841.GA29847@lst.de>
References: <20200827150030.282762-2-hch@lst.de> <20200901064849.GI4299@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901064849.GI4299@shao2-debian>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks like since the start of this series we've grown new code to
use kernel_write on sysctl files based on boot parameters.  The good
news is that this just means I need to resurrect the sysctl series
as all that work was done already.
