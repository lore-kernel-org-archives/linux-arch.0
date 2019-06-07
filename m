Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38888 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfFGWPe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 18:15:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so2711438lfa.5
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 15:15:33 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r3sm565410ljr.76.2019.06.07.15.15.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 15:15:31 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id i21so3026660ljj.3
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 15:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com> <87ef45axa4.fsf_-_@xmission.com>
In-Reply-To: <87ef45axa4.fsf_-_@xmission.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Jun 2019 15:07:28 -0700
Message-ID: <CAHk-=wjjVnEKSv3pV_dvgmqGDZDcw+N+Bgcorq7uqS86f1gwXA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>, Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, omar.kilani@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, David Laight <David.Laight@aculab.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190607220728.rBv8MHU8FDJrC0JKTFJAaLqy4tuy_DRH07jx1dPV-GE@z>

On Fri, Jun 7, 2019 at 2:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The sigsuspend system call overrides the signal mask just
> like all of the other users of set_user_sigmask, so convert
> it to use the same helpers.

Me likey.

Whole series looks good to me, but that's just from looking at the
patches. Maybe testing shows problems..

              Linus
