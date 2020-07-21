From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Tue, 21 Jul 2020 13:58:47 -0700
Message-ID: <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk> <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUU7I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:59:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F4C061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:59:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so176726ljc.5
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:59:07 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v12sm5992747lfp.12.2020.07.21.13.59.05
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:59:05 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id q4so195860lji.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 13:59:05 -0700 (PDT)
In-Reply-To: <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jul 21, 2020 at 1:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This seems dangerous to me.
>
> Maybe some implementation depends on the fact that they actually do
> the csum 16 bits at a time, and never see an overflow in "int",
> because they keep folding things.
>
> You now break that assumption, and give it an initial value that the
> csum code itself would never generate, and wouldn't handle right.
>
> But I didn't check. Maybe we don't have anything that stupid in the kernel.

I take it back. The very first place I looked seemed to do exactly that.

See "do_csum()" in the kernel. It doesn't handle carry for any of the
usual cases, exactly because it knows it doesn't need to.

Ok, so do_csum() doesn't take that initial value, but it's very much
an example of the kind of algorithm I was thinking of: it does do
things 32 bits at a time and handles the carry bit in that inner loop,
but internally it knows that the val;ues are limited in other places,
and doesn't need to handle carry everywhere.

                Linus
