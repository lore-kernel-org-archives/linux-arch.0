Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38382 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfEPWvN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 18:51:13 -0400
Received: by mail-lj1-f181.google.com with SMTP id 14so4574376ljj.5
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 15:51:12 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u3sm1186611lfc.73.2019.05.16.15.51.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 15:51:11 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id c17so3908449lfi.2
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 15:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
 <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
 <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com>
 <1558043623.29359.44.camel@HansenPartnership.com> <CAK8P3a0QsURY+QrkvBh5zS12cCLYD=ssVtus_6Q_DSnB1=1y3A@mail.gmail.com>
In-Reply-To: <CAK8P3a0QsURY+QrkvBh5zS12cCLYD=ssVtus_6Q_DSnB1=1y3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 May 2019 15:50:54 -0700
Message-ID: <CAHk-=wi+CyMkQJahExx0FNtJf+cd9VqjWNx3z6Em_xW11ScViw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org
Message-ID: <20190516225054.6HwfJeLev9cX1KlqkJfSvJUpSjyC9uRjTWBIT2tGv6Q@z>

On Thu, May 16, 2019 at 3:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Strangely, the copy I have on my local machine does have the 'S'
> flag. I sent it back to the server now.

Yup, now when I refreshed your key, I got an update, and your
signature looks all good.

              Linus
