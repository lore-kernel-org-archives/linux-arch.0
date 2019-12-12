From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Date: Fri, 13 Dec 2019 00:25:20 +0300
Message-ID: <20191212212520.GA9682@avx2>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
 <20191211095937.GB31670@1wt.eu>
 <20191211181933.GA3919@avx2>
 <20191211182401.GF31670@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191211182401.GF31670@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com, linux-arch@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 07:24:01PM +0100, Willy Tarreau wrote:
> On Wed, Dec 11, 2019 at 09:19:33PM +0300, Alexey Dobriyan wrote:
> > Reports are better be done by people who know what they are doing, as in
> > understand what executable stack is and what does it mean in reality.
> > 
> > > Otherwise it will just go to /dev/null with all warning about bad blocks
> > > on USB sticks and CPU core throttling under high temperature.
> > 
> > That's fine. You don't want bugreports from people who don't know what
> > is executable stack. Every security bug bounty program is flooded by
> > such people. This is why message is worded in a neutral way.
> 
> Well we definitely don't have the same experience with user reports. I
> was just suggesting, but since you apparently already have all the
> responses you needed, I'm even wondering why the warning remains.

Willy, whatever instructions for users you have in mind must be
different for different people. Developer should be told to add
"-Wl,-z,noexecstack" and more. Regular user (define "regular") should be
told to send bugreport if the program really needs executable stack
which again splits into two situations: exec stack was added knowingly
because it is some old program with lost source code or it was readded
by mistake.

"Complain to linux-kernel" is meaningless, kernel is not responsible.

What the message is even supposed to say?

It is not even pr_err.
