From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Date: Tue, 14 Jan 2020 14:09:06 -0800
Message-ID: <20200114220906.GZ2935@paulmck-ThinkPad-P72>
References: <20200114213405.GX2935@paulmck-ThinkPad-P72>
 <9970E373-DF70-4FE4-A839-AAE641612EC5@lca.pw>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9970E373-DF70-4FE4-A839-AAE641612EC5@lca.pw>
Sender: linux-kbuild-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: Marco Elver <elver@google.com>, LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 14, 2020 at 04:48:22PM -0500, Qian Cai wrote:
> 
> 
> > On Jan 14, 2020, at 4:34 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > As an alternative, once the patches needed for your tests to pass
> > reach mainline, you could announce that KCSAN was ready to be enabled
> > in distros.
> > 
> > Though I confess that I don't know how that works.  Is there a separate
> > testing kernel binary provided by the distros in question?
> 
> I don’t think I have powers to announce that. Once the feature hit the mainline, distro people could start to use in the debug kernel variant, and it is a shame to only find out it is broken. Anyway, I’ll try to edge out those corner cases. Stay tuned.

Very good, thank you!

And you do have the power to announce.  But just like most of the rest
of use, myself included, you won't always have the power to make people
actually pay attention to what you say.  ;-)

							Thanx, Paul
