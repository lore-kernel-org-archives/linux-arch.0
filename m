Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42050 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeJMB52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 21:57:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id c23so11463542otl.9
        for <linux-arch@vger.kernel.org>; Fri, 12 Oct 2018 11:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com> <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
In-Reply-To: <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 12 Oct 2018 20:23:15 +0200
Message-ID: <CAG48ez0pPX7XNqSj4dVG1s+PaDBCh4ar5xw1WcY1sLBPV_QAzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] modules: Create rlimit for module space
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rick.p.edgecombe@intel.com
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Daniel Borkmann <daniel@iogearbox.net>, Kees Cook <keescook@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, jeyu@kernel.org, linux-arm-kernel@lists.infradead.org, kernel list <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, kristen@linux.intel.com, Dave Hansen <dave.hansen@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, deneen.t.dock@intel.com
Message-ID: <20181012182315.noQtGdnDkm995QGMNUxn7mPkQMx27Xx_y9cXCWTLyjw@z>

On Fri, Oct 12, 2018 at 2:35 AM Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
> <rick.p.edgecombe@intel.com> wrote:
> > This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> > module space a user can use. The intention is to be able to limit module space
> > allocations that may come from un-privlidged users inserting e/BPF filters.
>
> Note that in some configurations (iirc e.g. the default Ubuntu
> config), normal users can use the subuid mechanism (the /etc/subuid
> config file and the /usr/bin/newuidmap setuid helper) to gain access
> to 65536 UIDs, which means that in such a configuration,
> RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
> applies to RLIMIT_MEMLOCK.)

Actually, I may have misremembered, perhaps it's not installed by
default - I just checked in a Ubuntu VM, and the newuidmap helper from
the uidmap package wasn't installed.
