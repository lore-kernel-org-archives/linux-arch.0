From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Date: Wed, 11 Dec 2019 19:24:01 +0100
Message-ID: <20191211182401.GF31670@1wt.eu>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
 <20191211095937.GB31670@1wt.eu>
 <20191211181933.GA3919@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191211181933.GA3919@avx2>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com, linux-arch@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 09:19:33PM +0300, Alexey Dobriyan wrote:
> Reports are better be done by people who know what they are doing, as in
> understand what executable stack is and what does it mean in reality.
> 
> > Otherwise it will just go to /dev/null with all warning about bad blocks
> > on USB sticks and CPU core throttling under high temperature.
> 
> That's fine. You don't want bugreports from people who don't know what
> is executable stack. Every security bug bounty program is flooded by
> such people. This is why message is worded in a neutral way.

Well we definitely don't have the same experience with user reports. I
was just suggesting, but since you apparently already have all the
responses you needed, I'm even wondering why the warning remains.

Willy
