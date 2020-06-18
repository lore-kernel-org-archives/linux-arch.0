Return-Path: <SRS0=1XNm=77=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgFRTsm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2020 15:48:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1638AC0613EE
        for <linux-arch@vger.kernel.org>; Thu, 18 Jun 2020 12:48:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z9so8714788ljh.13
        for <linux-arch@vger.kernel.org>; Thu, 18 Jun 2020 12:48:41 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w26sm795492ljj.114.2020.06.18.12.48.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 12:48:38 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id c17so8715466lji.11
        for <linux-arch@vger.kernel.org>; Thu, 18 Jun 2020 12:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200617073755.8068-1-hch@lst.de>
In-Reply-To: <20200617073755.8068-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jun 2020 12:48:22 -0700
Message-ID: <CAHk-=wjpnu=882iD9ck9Ywt6R1LYX_Hv-oS7dBMsWZwDRGZ5jA@mail.gmail.com>
Subject: Re: rename probe_kernel_* and probe_user_*
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20200618194822.Hw8gY12LaNdmgNrXnzgA6wMRcTQ0qo5RJsoAooC3ZhU@z>

[ Explicitly added architecture lists and developers to the cc to make
this more visible ]

On Wed, Jun 17, 2020 at 12:38 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Andrew and I decided to drop the patches implementing your suggested
> rename of the probe_kernel_* and probe_user_* helpers from -mm as there
> were way to many conflicts.  After -rc1 might be a good time for this as
> all the conflicts are resolved now.

So I've merged this renaming now, together with my changes to make
'get_kernel_nofault()' look and act a lot more like 'get_user()'.

It just felt wrong (and potentially dangerous) to me to have a
'get_kernel_nofault()' naming that implied semantics that we're all
familiar with from 'get_user()', but acting very differently.

But part of the fixups I made for the type checking are for
architectures where I didn't even compile-test the end result. I
looked at every case individually, and the patch looks sane, but I
could have screwed something up.

Basically, 'get_kernel_nofault()' doesn't do the same automagic type
munging from the pointer to the target that 'get_user()' does, but at
least now it checks that the types are superficially compatible.
There should be build failures if they aren't, but I hopefully fixed
everything up properly for all architectures.

This email is partly to ask people to double-check, but partly just as
a heads-up so that _if_ I screwed something up, you'll have the
background and it won't take you by surprise.

               Linus
