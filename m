Return-Path: <owner-linux-mm@kvack.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Date: Tue, 14 Jan 2020 16:48:22 -0500
Message-ID: <9970E373-DF70-4FE4-A839-AAE641612EC5@lca.pw>
References: <20200114213405.GX2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200114213405.GX2935@paulmck-ThinkPad-P72>
Sender: owner-linux-mm@kvack.org
To: paulmck@kernel.org
Cc: Marco Elver <elver@google.com>, LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <Mark.Rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200114214822.y77GyZh1-YS1Hh9i14nTiueQl6qVh6DIbktXjozz9HA@z>



> On Jan 14, 2020, at 4:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> As an alternative, once the patches needed for your tests to pass
> reach mainline, you could announce that KCSAN was ready to be enabled
> in distros.
>=20
> Though I confess that I don't know how that works.  Is there a separate
> testing kernel binary provided by the distros in question?

I don=E2=80=99t think I have powers to announce that. Once the feature hit t=
he mainline, distro people could start to use in the debug kernel variant, a=
nd it is a shame to only find out it is broken. Anyway, I=E2=80=99ll try to e=
dge out those corner cases. Stay tuned.=
