Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35925 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCHAWg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 19:22:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so12746667pfa.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Mar 2019 16:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
 <20190307164647.GC25101@redhat.com> <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
In-Reply-To: <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Mar 2019 16:22:24 -0800
Message-ID: <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
Message-ID: <20190308002224.JJ03mWe5sNlnl67g4J8-eXwP10XEflw0pWdSNbwMZbA@z>

On Thu, Mar 7, 2019 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> I'd have to try, but I think you are right. It was probably an
> overoptimization back in 1997 when the code got added to
> linux-2.1.68pre1, and compilers have become smarter in the
> meantime ;-)

How do you track history pre-git (2.6.XX)?
-- 
Thanks,
~Nick Desaulniers
