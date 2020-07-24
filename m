Return-Path: <SRS0=oaWr=BD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:40442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgGXUvm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 16:51:42 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V5 00/15] entry, x86, kvm: Generic entry/exit functionality for host and guest
In-Reply-To: <20200722215954.464281930@linutronix.de>
References: <20200722215954.464281930@linutronix.de>
Date: Fri, 24 Jul 2020 22:51:38 +0200
Message-ID: <878sf8tz51.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID: <20200724205138.wCjVENxrOefA9wy7ILb4szfdR5bpEBxjDHKIjDctr2Y@z>

Thomas Gleixner <tglx@linutronix.de> writes:
> This is the 5th version of generic entry/exit functionality for host and
> guest.

I've merged the pile in two steps. Patch 1-5, i.e. the generic code is
here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and merged this branch and patch 6-15 into

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

core/entry is immutable and any updates, changes go on top. It's meant
as a base for other architecture developers who want to fiddle with that
without having to get the x86 mess as well.

Thanks for all the help!

       tglx
