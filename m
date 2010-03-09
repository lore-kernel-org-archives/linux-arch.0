From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] improve sys_personality for compat architectures
Date: Tue, 9 Mar 2010 13:58:17 +0100
Message-ID: <20100309125817.GA18435@lst.de>
References: <201002021536.51928.arnd@arndb.de> <20100203.091309.52886984.davem@davemloft.net> <4B69D6BA.4030704@zytor.com> <201002040838.10783.arnd@arndb.de> <20100204160057.GA5120@lst.de> <20100305114911.ef629eb1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100305114911.ef629eb1.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tony.luck@intel.com, ralf@linux-mips.org, kyle@mcmartin.ca, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, viro@zeniv.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 05, 2010 at 11:49:11AM -0800, Andrew Morton wrote:
> > Yes, this should be common over architectures.  Anyway, I expect there
> > to be some discussion until we've reached that point, so for now I'll
> > rebase patches 5 and 6 to not require this patch, and will send one
> > to kill the unused x86 implementation.  Whatever is the final outcome
> > can be implemented on top.
> > 
> 
> This never happened?

Seems like no one cared enough to discuss this issue in detail.  I'll
start a fresh discussion once we got the other patches in and I have
a clean sheet to work against.
