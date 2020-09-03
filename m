Return-Path: <SRS0=8TOP=CM=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88550C43461
	for <linux-arch@archiver.kernel.org>; Thu,  3 Sep 2020 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6895E20684
	for <linux-arch@archiver.kernel.org>; Thu,  3 Sep 2020 14:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgICOkv (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:40:51 -0400
Received: from verein.lst.de ([213.95.11.211]:38101 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbgICOkt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Sep 2020 10:40:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACD3967357; Thu,  3 Sep 2020 16:40:37 +0200 (CEST)
Date:   Thu, 3 Sep 2020 16:40:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Message-ID: <20200903144037.GA17821@lst.de>
References: <20200903142242.925828-1-hch@lst.de> <20200903142803.GM1236603@ZenIV.linux.org.uk> <20200903143003.GA17260@lst.de> <20200903143629.GN1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903143629.GN1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 03:36:29PM +0100, Al Viro wrote:
> FWIW, vfs.git#for-next is always a merge of independent branches; I don't
> put stuff directly into #for-next - too easy to lose that way.
> 
> IOW, that would be something like #base.set_fs, included into #for-next
> merge set.  And I've no problem with never-rebased branches...
> 
> Where in the mainline are the most recent prereqs of this series?

I can't think of anything past -rc1, but I haven't actually checked.
