From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] asm-generic: Don't warn that atomic_t is only 24 bit
Date: Wed, 28 Apr 2010 15:33:29 +0200
Message-ID: <201004281533.29327.arnd@arndb.de>
References: <1272451837-17961-1-git-send-email-peter.fritzsche@gmx.de> <1272453036-18670-1-git-send-email-peter.fritzsche@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50341 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0D1Ndf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2010 09:33:35 -0400
In-Reply-To: <1272453036-18670-1-git-send-email-peter.fritzsche@gmx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Fritzsche <peter.fritzsche@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Keith M Wesolowski <wesolows@foobazco.org>

On Wednesday 28 April 2010, Peter Fritzsche wrote:
> 32-bit Sparc used to only allow usage of 24-bit of it's atomic_t type.
> This was corrected with linux 2.6.3 when Keith M Wesolowski changed the
> implementation to use the parisc approach of having an array of
> spinlocks to protect the atomic_t.
> 
> These warnings were also removed from the sparc implementation when the
> new implementation was merged in BKrev:402e4949VThdc6D3iaosSFUgabMfvw,
> but the warning still remained in some other places without any
> 24-bit-only atomic_t implementation inside the kernel.
> 
> We should remove these warnings to allow users to rely on the full
> 32-bit range of atomic_t.
> 
> Signed-off-by: Peter Fritzsche <peter.fritzsche@gmx.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
