Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45712 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfCAQrh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Mar 2019 11:47:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id d24so20710794ljc.12
        for <linux-arch@vger.kernel.org>; Fri, 01 Mar 2019 08:47:36 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p21sm5415223lfd.4.2019.03.01.08.47.34
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:47:35 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 131so9302456lfa.5
        for <linux-arch@vger.kernel.org>; Fri, 01 Mar 2019 08:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Mar 2019 08:41:24 -0800
Message-ID: <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] Remove Mysterious Macro Intended to Obscure Weird
 Behaviours (mmiowb())
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301164124.vTvnZaZBqqAzrgu_d6yCc0_SzlE5G4DC7MEbHH_lxvM@z>

Love the acronym, and the series looks good to me.

Michael - can you check (or maybe you already did?) that this works
for ppc too, and doesn't have any gotcha's?

                      Linus
