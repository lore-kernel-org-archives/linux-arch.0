Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35055 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbcFTQjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2016 12:39:49 -0400
Received: by mail-vk0-f48.google.com with SMTP id j2so202682693vkg.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2016 09:38:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160620133614.GE9892@dhcp22.suse.cz>
References: <cover.1466192946.git.luto@kernel.org> <44f658aacbabd9d1689b3e0aae60ee8746881eff.1466192946.git.luto@kernel.org>
 <20160620133614.GE9892@dhcp22.suse.cz>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 20 Jun 2016 09:13:55 -0700
Message-ID: <CALCETrV3M0a4Xyro21Rz8gpkq1b8PnFUZm_NPnBr0BBO8HS6ug@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] fork: Add generic vmalloced stack support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160620161355.RcZ5EJ0XWvbpR7LJduf9EKXONUloB3iA4qT3mB5I668@z>

On Mon, Jun 20, 2016 at 6:36 AM, Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 17-06-16 13:00:42, Andy Lutomirski wrote:
>> If CONFIG_VMAP_STACK is selected, kernel stacks are allocated with
>> vmalloc_node.
>
> I like this! It also reduces demand for higher order (order-2) pages
> considerably which is a great plus on its own. I would be little bit
> worried about the performance because vmalloc wasn't the fastest one
> AFAIR. Have you tried to measure that?

It seems to add about 1.5µs to pthread_create+join on my laptop.  (On
an unmodified, stripped-down kernel, it took about 7µs before.  On a
Fedora system, the baseline is much worse.)  I think that most of the
overhead is because vmalloc allocates one page at a time, which means
that it won't use a higher order page even if one is sitting on a
freelist.

I can imagine better integration with the page allocator in which
higher order pages are used if readily available.  Similarly, vfree
could free pages that happen to be aligned and consecutive as a unit
to avoid the overhead of merging them back together one at a time.

But I'm not planning on doing any of this myself any time soon.  I
just want to get the code working and merged.

--Andy
