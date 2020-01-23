From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
Date: Thu, 23 Jan 2020 11:26:38 -0800
Message-ID: <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35617 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWT05 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 14:26:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so4975260lja.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 11:26:56 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 21sm1797334ljv.19.2020.01.23.11.26.54
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:26:55 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id j1so4975191lja.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 11:26:54 -0800 (PST)
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Guan Xuetao <gxt@pku.edu.cn>

Lovely. Thanks. Patches obviously all look fine.

On Thu, Jan 23, 2020 at 11:23 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> I'd _rather_ this go in via the x86 tree, but I'm not picky.  I could also
> send a pull request directly to Linus.

I have no strong feelings either way. I'll happily pull this tree for
the 5.6 merge window directly from you, or get it as part of one of
the x86 -tip pull requests.

Up to you and the -tip maintainers, really. Thomas/Ingo/Borislav?

                 Linus
