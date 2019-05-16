Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34717 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfEPSlt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 14:41:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so4079331ljg.1
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 11:41:48 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c25sm1002991ljb.20.2019.05.16.11.41.46
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 11:41:46 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n134so3398719lfn.11
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 11:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
In-Reply-To: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 May 2019 11:41:29 -0700
Message-ID: <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org
Message-ID: <20190516184129.H06QPGzbx_hCBusU5FihHeJV0_RjJYdorv1icSALY1g@z>

On Thu, May 16, 2019 at 5:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> tags/asm-generic-nommu

Interesting. I haven't seen this error before:

  # gpg: Signature made Tue 23 Apr 2019 12:54:49 PM PDT
  # gpg:                using RSA key 60AB47FFC9095227
  # gpg: bad data signature from key 60AB47FFC9095227: Wrong key usage
(0x00, 0x4)
  # gpg: Can't check signature: Wrong key usage

I think it means that you signed it with a key that was marked for
encryption only or something like that.

But gpg being the wonderful self-explanatory great UX that it is, I
have no effin clue what it really means.

Looking at the git history, it turns out this has happened a before
from you, and in fact goes back to pull requests from 2012.

Either I just didn't notice - which sounds unlikely for something that
has been going on for 7+ years - or the actual check and error is new
to gpg, and I only notice it this merge window because I've upgraded
to F30.

          Linus
