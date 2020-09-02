Return-Path: <SRS0=7ttA=CL=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575A8C433E2
	for <linux-arch@archiver.kernel.org>; Wed,  2 Sep 2020 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF2520BED
	for <linux-arch@archiver.kernel.org>; Wed,  2 Sep 2020 08:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBIKT (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:10:19 -0400
Received: from verein.lst.de ([213.95.11.211]:58232 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBIKS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 04:10:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3CF9067373; Wed,  2 Sep 2020 10:10:04 +0200 (CEST)
Date:   Wed, 2 Sep 2020 10:10:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v2
Message-ID: <20200902081003.GB26677@lst.de>
References: <20200827150030.282762-1-hch@lst.de> <a8bb0319-0928-4687-9e9c-777c5860dbdd@csgroup.eu> <20200901172512.GI1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901172512.GI1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 01, 2020 at 06:25:12PM +0100, Al Viro wrote:
> On Tue, Sep 01, 2020 at 07:13:00PM +0200, Christophe Leroy wrote:
> 
> >     10.92%  dd       [kernel.kallsyms]  [k] iov_iter_zero
> 
> Interesting...  Could you get an instruction-level profile inside iov_iter_zero(),
> along with the disassembly of that sucker?

So the interesting thing here is with that none of these code paths
should have changed at all, and the biggest items on the profile look
the same modulo some minor reordering.
