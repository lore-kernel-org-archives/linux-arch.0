Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E7FC433F5
	for <linux-arch@archiver.kernel.org>; Mon, 20 Sep 2021 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D53461077
	for <linux-arch@archiver.kernel.org>; Mon, 20 Sep 2021 14:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhITObr (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 20 Sep 2021 10:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbhITObq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Sep 2021 10:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E50960E76;
        Mon, 20 Sep 2021 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632148219;
        bh=Q9AttzYMMlrQ9pqRSwf8ZRicqkLjL7wPmPl+QB6Dqw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDkwv2niPIMZc3hgsAxpdvEuyVP+F5N/JUNkW66BOpvgSf4CoVfmrciUp7kzVTtcd
         vJpGZa1i3FV11K4wwUlsEBAWmgeTmL+9KbgS5EiBPJsmmMIjZke6jN6yqhoY5Rw+1v
         NLyl5E+Ht2w3D5fP5Hrv0nCaxiFBHvCKNqWWHQDow+10eDHDaZcxEtZBWaPgxU6svG
         zwKGHAH4xxP+WqgoIK34diFMkNXM3Kew3NGnArqQak2EbmjLpJYXg3yteJP6u3M52g
         fO+W0vP20ycNgIC1V8/TCohayPJ7AnWswWi2EOdQnHSV31s6W+iEwRioS1Fpbs2UfP
         E4HosL1jloyBA==
Date:   Mon, 20 Sep 2021 07:30:15 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        llvm@lists.linux.dev
Subject: Re: Odd pci_iounmap() declaration rules..
Message-ID: <YUia9zfbiertRRNR@archlinux-ax161>
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
 <YUdti08rLzfDZy8S@ls3530>
 <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
 <YUeriU9EIJ5hiFjL@archlinux-ax161>
 <CAHk-=wgNfaf03Dw78q1qLLZs6G=iJjfo5ZTcnyXgSk3w1tp0yg@mail.gmail.com>
 <CAHk-=wirqeqb59bbFjCQ9L9BiVOQFqD=JbUEG+hU2bF4BDWqVg@mail.gmail.com>
 <CAHk-=wgzc8EUcH=V7P0GoxVYw4bQ7URJvQVZ7_5pODQmrSkAnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzc8EUcH=V7P0GoxVYw4bQ7URJvQVZ7_5pODQmrSkAnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 19, 2021 at 05:44:03PM -0700, Linus Torvalds wrote:
> On Sun, Sep 19, 2021 at 3:44 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The fix seems to be to just move that odd code from the header file to
> > lib/pci_iomap.c, and that should make it all JustWork(tm).
> 
> I'm not 100% happy about the end result, and in particular I think
> that the new generic pci_iounmap() function for the
> ARCH_WANTS_GENERIC_PCI_IOUNMAP case should do the "iounmap(p)" thing
> even if ARCH_HAS_GENERIC_IOPORT_MAP wasn't true, but I tried to keep
> the old rules, even if they seemed broken.
> 
> arm and arm64 build for me, as did sparc64 and alpha. At least in the
> configs I tested.
> 
> And the code _does_ make a bit more sense than it used to. It still
> has crazy corners, but moving the pci_iounmap() code out of the header
> file should make it easier to fix up in the future.

Thanks, I can confirm that all of my build tests pass without any
issues now.

Cheers,
Nathan
