Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45209 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfEPU7k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 16:59:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so4318948lja.12
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 13:59:39 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id h25sm1087986lja.41.2019.05.16.13.59.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 13:59:37 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id h13so3708859lfc.7
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 13:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com> <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
In-Reply-To: <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 May 2019 13:59:21 -0700
Message-ID: <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org
Message-ID: <20190516205921.6Zx1peTkRzvXsuWlXOVzI1f-pWzdWlrYbvFExAOQ-fA@z>

On Thu, May 16, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
>
> I have reconfigured it locally now and pushed an identical tag with a
> new signature. Can you see if that gives you the same warning if you
> try to pull that?

No, same issue:

   [torvalds@i7 linux]$ git fetch
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
tags/asm-generic-nommu
   From ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic
    * tag                         asm-generic-nommu -> FETCH_HEAD
   [torvalds@i7 linux]$ git verify-tag FETCH_HEAD
   gpg: Signature made Thu 16 May 2019 01:28:54 PM PDT
   gpg:                using RSA key 60AB47FFC9095227
   gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
(0x00, 0x4)
   gpg: Can't check signature: Wrong key usage

That's the same key you used previously.

I think you have to do some gpg edit-key magic or something, and then
the key need to be refreshed.

But I really despise the usability of gpg, so what do I know?

              Linus
