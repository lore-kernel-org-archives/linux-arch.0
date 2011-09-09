From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 00/36] Hexagon: Add support for Qualcomm Hexagon architecture
Date: Fri, 09 Sep 2011 10:39:45 +0200
Message-ID: <3067098.EfRYKETXVd@wuerfel>
References: <20110909010847.294039464@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909010847.294039464@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thursday 08 September 2011 20:08:47 Richard Kuo wrote:
> This is the third version of the patchset to the Linux kernel to support
> the Qualcomm Hexagon architecture.  These patches have been organized like
> the last time, in a somewhat logically grouped fashion.
> 
> A summary of changes from the last patchset:
> * removed __delay
> * cleaned up checksum header to pull generic one
> * implemented vDSO so signal trampolines are no longer on stack
> * fixed cpu_idle()
> * removed init_IRQ() wrapper
> * cleaned up (most of) the wrongness in time.c
> * cleaned up smp.c to use more generic IPI handlers
> * filled in ins/outs routines in IO and other misc cleanup
> * removed redundant vunmap from ioremap
> * removed more highmem cruft
> * moved rwsem to asm-generic
> * bonus ifdefs added to generic checksum.h
> 
> Also, I have been compiling with sparse and it seems to pass.
> 
> These patches are available on Code Aurora:
> 
> https://www.codeaurora.org/patches/quic/hlk/hexagon-linux-20110908.tar.gz
> 
> Thanks again for everyone's feedback!

Ok, very good.

I haven't checked if it's already in linux-next, since you said you first
wanted to fix a few things. If it's not, please have Stephen add it now.

I wrote a small piece on the two new architectures for 3.2 in
http://lwn.net/Articles/457635/ , I hope I got the facts right. 

The ptrace interface is the only part that I'd ask you to definitely
fix before the merge window, because of the impact to the user space
ABI: We try to be strict about not breaking user-visible interfaces
for any code that has been in an official kernel release. It's of course
less important for a newly merged architecture when there are no existing
users, but I think it's best to always enforce this rule.

It would of course be very nice if you could get the board support based
on device tree probing ready as well by the same time, but I don't see
that as a show-stopper for inclusion.

One small comment about the way that you send patches: The changelog part
if each patch you send lists the changes that you have done since the first
submission. This is indeed helpful for the purpose of the review, but it's
not actually how you are supposed to use this. The body of the email
should instead start with a 'changeset comment' that describes the changes
made by the patch, followed by the 'Signed-off-by:' lines, and then after
the '---' line you should write the text that does not become part of
the permanent git history: the diffstat and any additional comments you have
for reviewers including what has changed since last time.

	Arnd
