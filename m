From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy
 ordering for port I/O accesses
Date: Fri, 11 Jan 2019 10:53:23 +0100
Message-ID: <20190111095323.GO1900@hirez.programming.kicks-ass.net>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-5-paulmck@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109210748.29074-5-paulmck@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, David Laight <David.Laight@ACULAB.COM>, linux-doc@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org


Hi PeterA,

The Cover leter has this:

> 5.	Update memory-barriers.txt on enforcing heavy ordering for
>	port-I/O accesses, courtesy of Will Deacon.  This one needs
>	an ack, preferably by someone from Intel.  Matthew Wilcox
>	posted some feedback from an Intel manual here, which might
>	be considered to be a close substitute, but...  ;-)
>
>	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org

which in turn has:

> Here's a quote from Section 18.6 of volume 1 of the Software Developer
> Manual, November 2018 edition:
> 
> When the I/O address space is used instead of memory-mapped I/O, the
> situation is different in two respects:
> • The processor never buffers I/O writes. Therefore, strict ordering of
> I/O operations is enforced by the processor. (As with memory-mapped I/O,
> it is possible for a chip set to post writes in certain I/O ranges.)
> • The processor synchronizes I/O instruction execution with external
> bus activity (see Table 18-1).
> 
> Table 18-1 says that in* delays execution of the current instruction until
> completion of pending stores, and out* delays execution of the _next_
> instruction until completion of both pending stores and the current store.

Can we give an Intel ACK on the below patch?

On Wed, Jan 09, 2019 at 01:07:46PM -0800, Paul E. McKenney wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> David Laight explains:
> 
>   | A long time ago there was a document from Intel that said that
>   | inb/outb weren't necessarily synchronised wrt memory accesses.
>   | (Might be P-pro era). However no processors actually behaved that
>   | way and more recent docs say that inb/outb are fully ordered.
> 
> This also reflects the situation on other architectures, the the port
> accessor macros tend to be implemented in terms of readX/writeX.
> 
> Update Documentation/memory-barriers.txt to reflect reality.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <linux-arch@vger.kernel.org>
> Cc: <linux-doc@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> ---
>  Documentation/memory-barriers.txt | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1c22b21ae922..a70104e2a087 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2619,10 +2619,8 @@ functions:
>       intermediary bridges (such as the PCI host bridge) may not fully honour
>       that.
>  
> -     They are guaranteed to be fully ordered with respect to each other.
> -
> -     They are not guaranteed to be fully ordered with respect to other types of
> -     memory and I/O operation.
> +     They are guaranteed to be fully ordered with respect to each other and
> +     also with respect to other types of memory and I/O operation.
>  
>   (*) readX(), writeX():
>  
> -- 
> 2.17.1
> 
