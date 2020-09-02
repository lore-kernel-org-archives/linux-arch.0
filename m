Return-Path: <SRS0=7ttA=CL=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61AC433E7
	for <linux-arch@archiver.kernel.org>; Wed,  2 Sep 2020 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F972207D3
	for <linux-arch@archiver.kernel.org>; Wed,  2 Sep 2020 12:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBMg4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:36:56 -0400
Received: from verein.lst.de ([213.95.11.211]:59866 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIBMgy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 08:36:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9AC368B02; Wed,  2 Sep 2020 14:36:46 +0200 (CEST)
Date:   Wed, 2 Sep 2020 14:36:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
Message-ID: <20200902123646.GA31184@lst.de>
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-11-hch@lst.de> <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 02, 2020 at 08:15:12AM +0200, Christophe Leroy wrote:
>> -		return 0;
>> -	return (size == 0 || size - 1 <= seg.seg - addr);
>> +	if (addr >= TASK_SIZE_MAX)
>> +		return false;
>> +	if (size == 0)
>> +		return false;
>
> __access_ok() was returning true when size == 0 up to now. Any reason to 
> return false now ?

No, this is accidental and broken.  Can you re-run your benchmark with
this fixed?
