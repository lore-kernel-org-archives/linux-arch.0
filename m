From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
Date: Mon, 12 Oct 2009 18:03:12 +0100
Message-ID: <20091012170312.GB9453@flint.arm.linux.org.uk>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org> <20091012090710.GA29310@n2100.arm.linux.org.uk> <20091012.023744.157085851.davem@davemloft.net> <20091012100023.GC29310@n2100.arm.linux.org.uk> <Pine.LNX.4.64.0910121634170.7327@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932960AbZJLREQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0910121634170.7327@sister.anvils>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: David Miller <davem@davemloft.net>, Nitin Gupta <ngupta@vflare.org>, Nick Piggin <npiggin@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 12, 2009 at 05:09:53PM +0100, Hugh Dickins wrote:
> Sorry to muddy the waters on this, if you and Dave are sure that
> you have the right fix, down in your architectures, and that fix
> isn't going to hurt your performance significantly.

If I look at the issue from this point of view:

- we are using PG_arch_1 to delay cache handling for the page

- if PG_arch_1 is set on a page, we set it explicitly because we
  didn't do some flushing between the allocation of the page and
  mapping it into userspace

- if a page with PG_arch_1 set ever gets to userspace, this can
  only be because we did the lazy flushing thing

I don't see that there should have been any bearing on whether a page
has a mapping or not when we get to update_mmu_cache.  The issue here
is that > if PG_arch_1 is set on a page, then we didn't flush it at
the time when we believed it was appropriate to do so. <

Tell me I'm wrong (having only just sent it to Linus...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
