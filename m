From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/5] kernel hacking: GCC optimization for debug
 experience (-Og)
Date: Wed, 2 May 2018 13:09:18 +0200
Message-ID: <20180502110917.wnat6cjxfbtrdh7t@gmail.com>
References: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
 <20180502073315.sso3aaak45aeuyst@gmail.com>
 <20180502090756.tztulppgfefccd7q@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502090756.tztulppgfefccd7q@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Du, Changbin" <changbin.du@intel.com>
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Du, Changbin <changbin.du@intel.com> wrote:

> On Wed, May 02, 2018 at 09:33:15AM +0200, Ingo Molnar wrote:
> > 
> > * changbin.du@intel.com <changbin.du@intel.com> wrote:
> > 
> > > Comparison of system performance: a bit drop.
> > > 
> > >     w/o CONFIG_DEBUG_EXPERIENCE
> > >     $ time make -j4
> > >     real    6m43.619s
> > >     user    19m5.160s
> > >     sys     2m20.287s
> > > 
> > >     w/ CONFIG_DEBUG_EXPERIENCE
> > >     $ time make -j4
> > >     real    6m55.054s
> > >     user    19m11.129s
> > >     sys     2m36.345s
> > 
> > Sorry, that's not a proper kbuild performance measurement - there's no noise 
> > estimation at all.
> > 
> > Below is a description that should produce more reliable numbers.
> > 
> > Thanks,
> > 
> > 	Ingo
> >
> Thanks for your suggestion, I will try your tips to eliminate noise. Since it is
> tested in KVM guest, so I just reboot the guest before testing. But in host side
> I still need to consider these noises.

Please test the impact on the host, guest tests are typically too noisy for such 
comparisons.

BTW., for guest tests rebooting the guest is not enough to replicate the method I 
suggested.

Thanks,

	Ingo
