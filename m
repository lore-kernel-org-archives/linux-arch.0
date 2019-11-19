From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Date: Tue, 19 Nov 2019 22:53:48 +0100
Message-ID: <CANpmjNOJdWi6i+2Nn70UQDvF0a0pQTVVye7CTTJgqOHa3UmHMQ@mail.gmail.com>
References: <CANpmjNPiKg++=QHUjD87dqiBU1pHHfZmGLAh1gOZ+4JKAQ4SAQ@mail.gmail.com>
 <A74F8151-F5E8-4532-BB67-6CFA32487D26@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A74F8151-F5E8-4532-BB67-6CFA32487D26@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-arch.vger.kernel.org

On Tue, 19 Nov 2019 at 22:42, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Nov 19, 2019, at 2:54 PM, Marco Elver <elver@google.com> wrote:
> >
> > Regardless of approach, my guess is that the complexity outweighs any
> > benefits this may provide in the end. Not only would a hypothetical
> > kernel that combines these be extremely slow, it'd also diminish the
> > practical value because testing and finding bugs would also be
> > impaired due to performance.
>
> On the other hand, it is valuable for distros to be able to select both for the debug kernel variant. Performance is usually not a major concern over there and could be migrated by other means like selecting powerful systems etc.

Fair enough. However, right now none of gcc nor clang would support
this. It is something to revisit in future, but is certainly not
something that can trivially be resolved.

Thanks,
-- Marco
