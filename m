From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Tue, 21 Jul 2020 13:55:16 -0700
Message-ID: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgGUUzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:55:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA9C0619DB
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:55:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r19so128947ljn.12
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:55:35 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x18sm5015635ljd.123.2020.07.21.13.55.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id i80so62600lfi.13
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:55:32 -0700 (PDT)
In-Reply-To: <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jul 21, 2020 at 1:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Preparation for the change of calling conventions; right now all
> callers pass 0 as initial sum.  Passing 0xffffffff instead yields
> the values comparable mod 0xffff and guarantees that 0 will not
> be returned on success.

This seems dangerous to me.

Maybe some implementation depends on the fact that they actually do
the csum 16 bits at a time, and never see an overflow in "int",
because they keep folding things.

You now break that assumption, and give it an initial value that the
csum code itself would never generate, and wouldn't handle right.

But I didn't check. Maybe we don't have anything that stupid in the kernel.

              Linus
