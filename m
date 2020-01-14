From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Date: Tue, 14 Jan 2020 13:34:05 -0800
Message-ID: <20200114213405.GX2935@paulmck-ThinkPad-P72>
References: <20200114192220.GS2935@paulmck-ThinkPad-P72>
 <F185919B-2D86-43B6-9BEC-D14D72871A58@lca.pw>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F185919B-2D86-43B6-9BEC-D14D72871A58@lca.pw>
Sender: linux-doc-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: Marco Elver <elver@google.com>, LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 14, 2020 at 03:30:53PM -0500, Qian Cai wrote:
> 
> 
> > On Jan 14, 2020, at 2:22 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > Just so I understand...  Does this problem happen even in CONFIG_KCSAN=n
> > kernels?
> 
> No.

Whew!!!  ;-)

> > I have been running extensive CONFIG_KSCAN=y rcutorture tests for quite
> > awhile now, so even if this only happens for CONFIG_KSCAN=y, it is not
> > like it affects everyone.
> > 
> > Yes, it should be fixed, and Marco does have a patch on the way.
> 
> The concern is really about setting KSCAN=y in a distro debug kernel where it has other debug options. I’ll try to dig into more of those issues in the next few days.

Understood.  But there are likely to be other issues with KCSAN, given how
new it is.  Yes, yes, I certainly would like to believe that the patches
we currently know about will make KCSAN perfect for distros, I have way
too much grey hair (and too little hair as well!) to really beleive that.

As an alternative, once the patches needed for your tests to pass
reach mainline, you could announce that KCSAN was ready to be enabled
in distros.

Though I confess that I don't know how that works.  Is there a separate
testing kernel binary provided by the distros in question?

							Thanx, Paul
