From: Peter Fritzsche <Peter.Fritzsche@gmx.de>
Subject: Re: [PATCH 2/2] asm-generic: Don't warn that atomic_t is only 24 bit
Date: Wed, 28 Apr 2010 20:42:09 +0200
Message-ID: <201004282042.15485.Peter.Fritzsche@gmx.de>
References: <1272451837-17961-1-git-send-email-peter.fritzsche@gmx.de> <20100428135434.GA4662@Krystal> <20100428152815.GB25569@shareable.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100428152815.GB25569@shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Keith M Wesolowski <wesolows@foobazco.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Wednesday 28 April 2010 17:28:15 you wrote:

> If the comment's getting removed, it should probably go from here too:
> 
> linux-2.6$ git grep '24' arch/*/include/*/atomic*
> arch/mn10300/include/asm/atomic.h: * useful range of an atomic_t is only 24
> bits arch/mn10300/include/asm/atomic.h: * useful range of an atomic_t is
> only 24 bits arch/mn10300/include/asm/atomic.h: * Note that the guaranteed
> useful range of an arch/mn10300/include/asm/atomic.h: * Note that the
> guaranteed useful range of an

This is part one of the patch - already sent to the mn10300 people. Currently 
only got Acked reponses for both patches

Best regards,
	Peter Fritzsche
