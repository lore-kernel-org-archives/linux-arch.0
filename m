Return-Path: <SRS0=sPo6=4I=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33641 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgBTW4t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 17:56:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so221620lji.0
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 14:56:46 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f9sm434946ljp.62.2020.02.20.14.56.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:56:44 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id c23so29738lfi.7
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 14:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20200217183340.GI23230@ZenIV.linux.org.uk> <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220224707.GQ23230@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Feb 2020 14:56:28 -0800
Message-ID: <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
Subject: Re: [RFC] regset ->get() API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20200220225628.yvgbFDef9y3FEFG4kq9ipcLDoBUkLzwPxn4z13hXA1Q@z>

On Thu, Feb 20, 2020 at 2:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 19, 2020 at 12:01:54PM -0800, Linus Torvalds wrote:
>
> > I don't mind it, but some of those buffers are big, and the generic
> > code generally doesn't know how big.
>
> That's what regset_size() returns...

Yes, but the code ends up being disgusting. You first have to call
that indirect function just to get the size, then do a kmalloc, and
then call another indirect function to actually fill it.

Don't do that. Not since we know how retpoline is a bad thing.

And since the size isn't always some trivial constant (ie for x86 PFU
it depends on the register state!), I think the only sane model is to
change the interface even more, and just have the "get()" function not
only get the data, but allocate the backing store too.

So you'd never pass in the result pointer - you'd get a result area
that you can then free.

Hmm?

The alternative is to pick a constant size that is "big enough", and
just assume that one page (or whatever) is sufficient:

> > Maybe even more. I'm not sure how big the FPU regset can get on x86...
>
> amd64:
>         REGSET_GENERAL  =>      sizeof(struct user_regs_struct) (216)
>         REGSET_FP       =>      sizeof(struct user_i387_struct) (512)
>         REGSET_XSTATE   =>      sizeof(struct swregs_state) or
>                                 sizeof(struct fxregs_state) or
>                                 sizeof(struct fregs_state) or
>                                 XSAVE insn buffer size (max about 2.5Kb, AFAICS)
>         REGSET_IOPERM64 =>      IO_BITMAP_BYTES (8Kb, that is)

Yeah, so apparently one page isn't sufficient.


> FWIW, what I have in mind is to start with making copy_regset_to_user() do
>         buf = kmalloc(size, GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
>         err = regset->get(target, regset, offset, size, buf, NULL);

See above. This doesn't work. You don't know the size. And we don't
have a known maximum size either.

>         if (!err && copy_to_user(data, buf, size))
>                 err = -EFAULT;
>         kfree(buf);
>         return err;

But if you change "->get()" to just return a kmalloc'ed buffer, I'd be
ok with that.

IOW, something like

        buf = regset->get(target, regset, &size);
        if (IS_ERR(buf))
                return PTR_ERR(bug);
        err = copy_to_user(data, buf, size);
        kfree(buf);
        return err;

or something like that. Just get rid of the "ubuf" entirely.

Wouldn't that be nicer?

            Linus
