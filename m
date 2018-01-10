From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Tue, 9 Jan 2018 19:07:17 -0800
Message-ID: <20180110030715.646ca2iss4ecr5mo@ast-mbp>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com>
 <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
 <CA+55aFwDZ_K1uzuTq95hUXUVLFsCPCqGAMHpwa4PLCRvszmqkQ@mail.gmail.com>
 <CAPcyv4it+Nasf1mp-+ydGP6rjHkyNKJXDTMyPrERk4V5g4yP7A@mail.gmail.com>
 <20180110015713.im4atka6sahz7ucx@ast-mbp>
 <CAPcyv4h1Uvke8d8JThHMLuci5HMKLf3hHgtkpcch1QSpq35M+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38655 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeAJDHV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jan 2018 22:07:21 -0500
Content-Disposition: inline
In-Reply-To: <CAPcyv4h1Uvke8d8JThHMLuci5HMKLf3hHgtkpcch1QSpq35M+Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Tue, Jan 09, 2018 at 06:22:09PM -0800, Dan Williams wrote:
> 
> When you came up with that tweak you noted:
> 
> "The following:
> [..]
> is generic and no speculative flows."

I meant 'no speculative control flow'
load speculation still happens.

> 
> > This macro doesn't prevent speculation.
> 
> It masks dangerous speculation. At least, I read nospec as "No
> Spectre" and it is a prefix used in the Spectre-v2 patches.

ahh. I thought 'nospec' means 'no speculation'.
I think it's too much of an honor to use bug name for the macro
that will be used in many places in the kernel.

> > I think array_access() was the best name so far.
> 
> For other usages I need the pointer to the array element, also
> array_access() by itself is unsuitable for __fcheck_files because we
> still need rcu_dereference_raw() on the element de-reference. So, I
> think it's better to get a sanitized array element pointer which can
> be used with rcu, READ_ONCE(), etc... directly rather than try to do
> the access in the same macro.

makes sense, then array_ptr() should fit ?
I'm hearing rumors that the first cpu with variant 2 and 3 fixed
will be appearing in early 2019. Which is amazing considering cpu
release cycles, but it also means that variant 1 will stay with us
for long time and we better pick clean interface and name for it.
