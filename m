From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] asm-generic: Don't warn that atomic_t is only 24
	bit
Date: Wed, 28 Apr 2010 09:54:34 -0400
Message-ID: <20100428135434.GA4662@Krystal>
References: <1272451837-17961-1-git-send-email-peter.fritzsche@gmx.de> <1272453036-18670-1-git-send-email-peter.fritzsche@gmx.de> <201004281533.29327.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201004281533.29327.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Fritzsche <peter.fritzsche@gmx.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Keith M Wesolowski <wesolows@foobazco.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

* Arnd Bergmann (arnd@arndb.de) wrote:
> On Wednesday 28 April 2010, Peter Fritzsche wrote:
> > 32-bit Sparc used to only allow usage of 24-bit of it's atomic_t type.
> > This was corrected with linux 2.6.3 when Keith M Wesolowski changed the
> > implementation to use the parisc approach of having an array of
> > spinlocks to protect the atomic_t.
> > 
> > These warnings were also removed from the sparc implementation when the
> > new implementation was merged in BKrev:402e4949VThdc6D3iaosSFUgabMfvw,
> > but the warning still remained in some other places without any
> > 24-bit-only atomic_t implementation inside the kernel.
> > 
> > We should remove these warnings to allow users to rely on the full
> > 32-bit range of atomic_t.
> > 
> > Signed-off-by: Peter Fritzsche <peter.fritzsche@gmx.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

AFAIK that was the last architecture imposing limitations below 32 bits
on atomic_t.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
