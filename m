Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34970 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeFXHND (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jun 2018 03:13:03 -0400
Date: Sun, 24 Jun 2018 09:12:58 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Message-ID: <20180624071258.GB29407@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
 <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com>
 <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com>
 <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
 <20180622021636.GA11266@gmail.com>
 <87a7rm3eb5.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7rm3eb5.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Dominik Brodowski <linux@dominikbrodowski.net>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20180624071258.LuIo6JDk9R_7C-2YKeZnSFi5R3pUEbfbWkoWDNRvkcc@z>


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> The trouble with attributes is that means you can't filter your system
> call arguments with seccomp. [...]

There's nothing keeping seccomp from securely fetching those arguments and 
extending filtering to them as well ...

Allowing that would make sense for a lot of other system calls as well.

Thanks,

	Ingo
