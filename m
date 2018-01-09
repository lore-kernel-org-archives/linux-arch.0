From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Mon, 8 Jan 2018 20:21:09 -0800
Message-ID: <CA+55aFxkBkyDOApZF9zHzLY4nDkX+mxVOZQqAxGxNP6eUikBgw@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com> <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
 <CA+55aFwDZ_K1uzuTq95hUXUVLFsCPCqGAMHpwa4PLCRvszmqkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:41536 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756720AbeAIEVK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 23:21:10 -0500
In-Reply-To: <CA+55aFwDZ_K1uzuTq95hUXUVLFsCPCqGAMHpwa4PLCRvszmqkQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Mon, Jan 8, 2018 at 8:13 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>     # carry will be clear if idx >= max
>     cmpq %idx,%max

Bah. Other way around.

        cmpq %max,%idx

I'm a moron.

>     # mask will be clear if carry was clear, ~0 otherwise
>     sbbq %mask,%mask
>
> to generate mask directly. I might have screwed that up. Worth perhaps trying?

More importantly, worth _testing_ and fixing my hand-waving "asm like
this" crap.

But I do think that simple two-instruction cmpq/sbbq sequence could
get it right in just two trivial ALU instructions.

          Linus
