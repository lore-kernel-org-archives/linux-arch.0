Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46736 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfBKWew (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Feb 2019 17:34:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so437174ljg.13
        for <linux-arch@vger.kernel.org>; Mon, 11 Feb 2019 14:34:50 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id q123-v6sm2351069ljb.60.2019.02.11.14.34.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:34:48 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v12-v6so471285ljc.6
        for <linux-arch@vger.kernel.org>; Mon, 11 Feb 2019 14:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20190211172948.3322-1-will.deacon@arm.com>
In-Reply-To: <20190211172948.3322-1-will.deacon@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Feb 2019 14:34:31 -0800
Message-ID: <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>
Message-ID: <20190211223431.7gohh7xIoF5LQkDYI-z9jeIir2pGZUQ166GYynWF_04@z>

On Mon, Feb 11, 2019 at 9:30 AM Will Deacon <will.deacon@arm.com> wrote:
>
> +
> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +       writes by the CPU to a particular device will arrive in program order.

Hmm. I'd like more people look at strengthening this one wrt across
CPUs and locking.

Right now we document mmiowb(), but that "documentation" is really
just a fairy tale. Very *very* few drivers actually do mmiowb() on
their own.

IOW, we should seriously just consider making the rule be that locking
will order mmio too. Because that's practically the rule anyway.

Powerpc already does it. IO within a locked region will serialize with the lock.

                Linus
