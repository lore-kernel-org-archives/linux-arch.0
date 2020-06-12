From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Date: Fri, 12 Jun 2020 16:47:57 +1200
Message-ID: <20200612044757.GA10703@tower>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
 <202006021052.E52618F@keescook>
 <CAEdQ38F2GP92xB2gMXTrEo-Adbbc9Cy1DWHU9yveGLzJNd2HrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEdQ38F2GP92xB2gMXTrEo-Adbbc9Cy1DWHU9yveGLzJNd2HrA@mail.gmail.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Matt Turner <mattst88@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-alpha <linux-alpha@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 11, 2020 at 09:23:52PM -0700, Matt Turner wrote:
> Since I noticed earlier that using maxcpus=1 on a 2-CPU system
> prevented the system from hanging, I tried disabling CONFIG_SMP on my
> 1-CPU system as well. In doing so, I discovered that the RCU torture
> module (RCU_TORTURE_TEST) triggers some null pointer dereferences on
> Alpha when CONFIG_SMP is set, but works successfully when CONFIG_SMP
> is unset.
> 
> That seems likely to be a symptom of the same underlying problem that
> started this thread, don't you think? If so, I'll focus my attention
> on that.

I wonder if that is related to user space segfaults we are now seeing
on SMP systems but not UP systems while building Alpha debian-ports.
It's happening in the test-suites of builds of certain software
(such as autogen and guile) but they always build successfully with
the test suite passing on a UP system.

When investigating I seem to recall it was a NULL (or near NULL)
pointer dereference but couldn't make any sense of how it might
have got into such an obviously wrong state.

Cheers,
Michael.
