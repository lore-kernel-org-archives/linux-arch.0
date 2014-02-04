From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: mips octeon memory model questions
Date: Tue, 4 Feb 2014 20:05:35 +0100
Message-ID: <20140204190535.GC5002@laptop.programming.kicks-ass.net>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
 <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Daney <ddaney@caviumnetworks.com>, Ralf Baechle <ralf@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 04, 2014 at 10:58:40AM -0800, Linus Torvalds wrote:
> On Tue, Feb 4, 2014 at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Still doesn't make sense, because if we need the first sync to stop
> > writes from being re-ordered with the ll-sc, we also need the second
> > sync to avoid the same.
> 
> Presumably octeon doesn't do speculative writes, only *buffered* writes.

Speculative writes are bad.. :-)

> So writes move down, not up.

Right, but the ll-sc store might move down over a later store. Say
because the ll-sc needs to first get exclusive ownership of the
cacheline where the later store would be to an already owned line.
