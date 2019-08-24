From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Date: Sat, 24 Aug 2019 12:08:00 -0700
Message-ID: <201908241206.D223659@keescook>
References: <201908200943.601DD59DCE@keescook>
 <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
 <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86003539-18ec-f2ff-a46f-764edb820dcd@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>, 20190819234111.9019-8-keescook@chromium.org, Peter Zijlstra <peterz@infradead.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 23, 2019 at 04:26:59PM +0200, Christophe Leroy wrote:
> 
> 
> Le 23/08/2019 à 00:56, Andrew Morton a écrit :
> > On Tue, 20 Aug 2019 09:47:55 -0700 Kees Cook <keescook@chromium.org> wrote:
> > 
> > > Reply-To: 20190819234111.9019-8-keescook@chromium.org
> > 
> > Really?
> 
> That seems correct, that's the "[PATCH 7/7] bug: Move WARN_ON() "cut here"
> into exception handler" from the series at
> https://lkml.org/lkml/2019/8/19/1155
> 
> 
> > 
> > > Subject: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception handler
> > 
> > It's strange to receive a standalone [7/7] patch.
> 
> Iaw the Reply_To, I understand it as an update of the 7th patch of the
> series.

Was trying to avoid the churn of resending the identical 1-6 patches
(which are all just refactoring to make 7/7 not a mess).

I can resend the whole series, if that's preferred.

> > > Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
> > 
> > I'm seeing double.

Tracking down all these combinations has been tricky, which is why I did
the patch 1-6 refactoring: it makes the call hierarchy much easier to
examine (IMO).

-Kees

-- 
Kees Cook
