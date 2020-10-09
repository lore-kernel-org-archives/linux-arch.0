Return-Path: <SRS0=ghMK=DQ=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81539C433E7
	for <linux-arch@archiver.kernel.org>; Fri,  9 Oct 2020 22:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4076A2237B
	for <linux-arch@archiver.kernel.org>; Fri,  9 Oct 2020 22:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602281199;
	bh=BSdsYnSsWQ2YK6s+0hwikbexRRTi6RzXd6Oify0LIKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SUShUW3dSbJ1jCjytUj4CtaH5oa4NIWDKogDiN42/3jc84vuab5dx+WZ5ux3Bzp0r
	 CyJXJ/V2w3/O21kjznGDMK/OzgrDuDYQ8IQIm5VpNy2u4OJah5l6PqWC9Q3Y7oDyaU
	 aGWFqUWSGHm0XiRoU2H/NU1mtN2PaLKlWSgjttps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbgJIWGg (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 9 Oct 2020 18:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389431AbgJIWGg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 18:06:36 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3638622258;
        Fri,  9 Oct 2020 22:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602281195;
        bh=BSdsYnSsWQ2YK6s+0hwikbexRRTi6RzXd6Oify0LIKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FggwccN5I5AZiuE+Vm843foxykXLgY3+2Ve5JGwMxqNB3E+xShPYydixbERiidVVi
         QW9J0tz5mlsoo600M7a+WgeVErDk1b1VMW5mDMvhyrS14K46mLfNtrpVvaVMMeP9LF
         2DCRbted8w1IYRD5exRfS6+MpJtndCuG5tnmVNDU=
Date:   Fri, 9 Oct 2020 15:06:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
Message-ID: <20201009220633.GA1122@sol.localdomain>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain>
 <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 02, 2020 at 09:27:09AM -0700, Linus Torvalds wrote:
> On Thu, Oct 1, 2020 at 3:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Better
> >         loff_t dummy = 0;
> > ...
> >                 wr = __kernel_write(file, data, bytes, &dummy);
> 
> No, just fix __kernel_write() to work correctly.
> 
> The fact is, NULL _is_ the right pointer for ppos these days.
> 
> That commit by Christoph is buggy: it replaces new_sync_write() with a
> buggy open-coded version.
> 
> Notice how new_sync_write does
> 
>         kiocb.ki_pos = (ppos ? *ppos : 0);
> ,,,
>         if (ret > 0 && ppos)
>                 *ppos = kiocb.ki_pos;
> 
> but the open-coded version doesn't.
> 
> So just fix that in linux-next. The *last* thing we want is to have
> different semantics for the "same" kernel functions.

It's a bit unintuitive that ppos=NULL means "use pos 0", not "use file->f_pos".

Anyway, it works.  The important thing is, this is still broken in linux-next...

- Eric
