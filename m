Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38616 "EHLO
 mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1727556AbgANUa4 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Tue,
 14 Jan 2020 15:30:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so13485597qki.5 for
 <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 12:30:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Date: Tue, 14 Jan 2020 15:30:53 -0500
Message-ID: <F185919B-2D86-43B6-9BEC-D14D72871A58@lca.pw>
References: <20200114192220.GS2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200114192220.GS2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org
Cc: Marco Elver <elver@google.com>, LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <Mark.Rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20200114203053.ggSRuu4QXrfrcWut1mPOT9ffXpkWjAPlDf0az5Rg5Us@z>



> On Jan 14, 2020, at 2:22 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> Just so I understand...  Does this problem happen even in CONFIG_KCSAN=3Dn=

> kernels?

No.

>=20
> I have been running extensive CONFIG_KSCAN=3Dy rcutorture tests for quite
> awhile now, so even if this only happens for CONFIG_KSCAN=3Dy, it is not
> like it affects everyone.
>=20
> Yes, it should be fixed, and Marco does have a patch on the way.

The concern is really about setting KSCAN=3Dy in a distro debug kernel where=
 it has other debug options. I=E2=80=99ll try to dig into more of those issu=
es in the next few days.=
