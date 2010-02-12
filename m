From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] parisc: fix tracing of signals
Date: Fri, 12 Feb 2010 12:10:11 -0500
Message-ID: <20100212171011.GJ24051@bombadil.infradead.org>
References: <20100212155306.GI24051@bombadil.infradead.org> <alpine.LFD.2.00.1002120816100.7792@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002120816100.7792@localhost.localdomain>
Sender: linux-parisc-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, vapier@gentoo.org, linux-parisc@vger.kernel.org, roland@redhat.com, "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 12, 2010 at 08:21:33AM -0800, Linus Torvalds wrote:
> Hmm. All other architectures either pass in zero, or test TIF_SINGLESTEP. 
> 
> I guess TIF_BLOCKSTEP is a parisc addition, so now parisc matches x86 and 
> power etc, but it still makes me wonder about all those other 
> architectures that pass in zero.
>

Yeah, BLOCKSTEP is the branch tracing bit (traps on a taken branch.)
 
> For the curious, that seems to be at least sparc and 64-bit (but not 
> 32-bit) sh.
> 

Mike sent an email to them reporting this as well, David points out that
sparc has no hw singlestepping, so 0 is appropriate there. SH does seem
to have a legitimate bug.

regards, Kyle

