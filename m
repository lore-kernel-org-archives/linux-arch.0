From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
Date: Thu, 23 Jan 2020 16:01:15 -0800
Message-ID: <CAHk-=wibZoVAzGpO-OssKN8cidpCKrfdDcMaspM6JW-3fbcSmQ@mail.gmail.com>
References: <20200123190456.8E05ADE6@viggo.jf.intel.com> <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
 <20200123202600.GG10328@zn.tnic> <636d5f4b-c47f-77f6-067f-a6b342db5650@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39504 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgAXABf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 19:01:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id t23so27115lfk.6
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 16:01:34 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m24sm2440560ljb.81.2020.01.23.16.01.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 16:01:31 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id r19so398018ljg.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 16:01:31 -0800 (PST)
In-Reply-To: <636d5f4b-c47f-77f6-067f-a6b342db5650@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Guan Xuetao <gxt@pku.edu.cn>

On Thu, Jan 23, 2020 at 1:23 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> I'm confident I can send patches to the x86 maintainers and not make
> them too angry.  Sending pull requests to Linus, not so much. :)

With a diffstat summary like

 24 files changed, 2 insertions(+), 1697 deletions(-)

there's not a lot I could complain about ;l)

> I'll just plan to send it to Linus directly.

I do note that while I've merged patch series from you before, I don't
seem to have done a git pull from you.

But since you already have a git tree, and the tree looks fine, it
really is just a git request-pull, and you basically already have the
cover-letter to add to the email.

In fact, you don't even have to use a signed tag since it's on
kernel.org - but it's always nice to see, and you can put the cover
letter explanation into the tag.

             Linus
