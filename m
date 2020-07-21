Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbgGUVRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:17:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D1C0619DC
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:17:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so198464ljj.10
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:17:11 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id o1sm5082367ljj.82.2020.07.21.14.17.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:17:08 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id k13so134537lfo.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200721202425.GA2786714@ZenIV.linux.org.uk> <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk> <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
 <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com> <20200721211118.GB2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200721211118.GB2786714@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Jul 2020 14:16:51 -0700
Message-ID: <CAHk-=wh59vJmaH_jWWxpr97XdQfUpOTJgMEA11qzvMwJFjB0VQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200721211651.7VfL8PkASozWpBdvo9WKyDZDTs5nm6R8F00YWrR1Zns@z>

On Tue, Jul 21, 2020 at 2:11 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > > But I didn't check. Maybe we don't have anything that stupid in the kernel.
>
> I did.

So then the commit message really should have said so, I feel. That
would have avoided the whole worry, and made it clear that it's not an
issue.

                Linus
