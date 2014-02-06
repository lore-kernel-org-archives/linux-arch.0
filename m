From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 5/5] arch: Sanitize atomic_t bitwise ops
Date: Thu, 6 Feb 2014 08:53:02 -0800
Message-ID: <CA+55aFwzn09dPJekgCbO2VRO8j3=eEt2j_QFd=Gd4MXTA2gm9g@mail.gmail.com>
References: <20140206134825.305510953@infradead.org>
	<20140206135001.333583247@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140206135001.333583247@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 6, 2014 at 5:48 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> Many archs have atomic_{set,clear}_mask() but not all. Remove these
> and provide a comprehensive set of bitops:
>
>   atomic{,64}_{and,or,xor}{,_return}()

Who uses these, and why?

The "_return()" versions of atomic ops are noticeably slower and more
complex on common architectures (ie x86), and apparently there is no
use of them since they didn't exist.

So why add them? Just to encourage people to do bad things?

                  Linus
