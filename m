From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
Date: Tue, 31 Jan 2017 13:41:17 -0800
Message-ID: <CA+55aFx0u8SpEYOkNymXBu7_q5uF-MitrjmpDx9+Uj3fgnxgRg@mail.gmail.com>
References: <20170131165537.GC23970@htj.duckdns.org> <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36642 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdAaVlX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2017 16:41:23 -0500
In-Reply-To: <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dougmill@linux.vnet.ibm.com

On Tue, Jan 31, 2017 at 1:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I've pulled this, but I really think it's papering over the real
> issue. Adding "linux-arch" mailing list to ask architecture
> maintainers to check their implementation of the atomic ops that
> return a truth value.

For example, looking at the x86-32 version, I see this:

  static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
  ...
        return (int)a;

which looks really horribly wrong, but the assembly implementation
actually returns 0/1 in %eax so it ends up being right - just
confusingly so.

Also, to make things more confusing, the underscore version
(__atomic_add_unless()) actually returns the old value, not the truth
value of the comparison.

So this area definitely is messy. The x86-64 versions actually look
fairly clean and return nice boolean values.

                Linus
