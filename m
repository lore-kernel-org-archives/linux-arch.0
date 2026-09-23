Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FC36A367;
	Wed, 23 Sep 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183097; cv=none; b=HgLXlldD5EmzRXRPpATzzU0Q469Lk9uZEhITbOw38dUS9uK4WjthSrwO8JiHb3IPK2pLiQHcFPm+IpQy3KT0eDixtPSdeC6Z1PFa4/8MCc409qbF44syBbiSiIWWGgecXHR+j7WPBN96suTJ5Zjev9KscE0i8L/OnSgarYK5UYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183097; c=relaxed/simple;
	bh=mFcFZfOlnsuJdzBLf6TiwYs/mM8BfOzEA+zUamfHr4Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=N6cf733oT3FZKUrhyM2sLrGqnxvZV4a0CdXAALqKoFSAYE3IdDboFRCsGhvGnL6+48VUL8ZgXlh6It8VMk5asc1OtA+xQLULqCEgZzB6hNNnJUONgxfha9lHVQvkA+0S9yN9gEt2SapRjsgD6GVH+mvy3RYmG/bqz8awMatuAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Wed, 23 Sep 2026 18:02:06 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 David Laight <david.laight.linux@gmail.com>
CC: frederic@kernel.org, neeraj.upadhyay@kernel.org, boqun@kernel.org,
 joelagnelf@nvidia.com, rcu@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
 linux-csky@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
In-Reply-To: <93f2bb33-c5ec-4836-8b1b-d0ee131be5b7@paulmck-laptop>
References: <20260911192540.20983-1-brads@mainlining.org> <20260911192540.20983-2-brads@mainlining.org> <20260923114313.75494970@pumpkin> <93f2bb33-c5ec-4836-8b1b-d0ee131be5b7@paulmck-laptop>
Message-ID: <DAF15CD4-3548-4486-9322-F31DC37FFD97@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 23 September 2026 18:00:33 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Wed, Sep 23, 2026 at 11:43:13AM +0100, David Laight wrote:
>> On Fri, 11 Sep 2026 19:25:34 +0000
>> Bradley Morgan <brads@mainlining.org> wrote:
>> 
>> > cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
>> > cmpxchg() for the architectures lacking native one-byte atomics.
>> > The same architectures also lack native two-byte cmpxchg(), where
>> > such an operation is not supported and either fails to compile via
>> > BUILD_BUG() or fails to link, because the bad pointer sentinels
>> > these architectures declare are never defined.
>> > 
>> > Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
>> > word with READ_ONCE(), splices the two target bytes through a union
>> > and loops on cmpxchg() of the full word until the compare succeeds.
>> > Like cmpxchg_emu_u8() it is fully ordered.
>> > 
>> > The Kconfig symbol gating this file is renamed from
>> > ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
>> > selects both the one-byte and the two-byte emulation.
>> > 
>> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> > Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> > ---
>> >  arch/Kconfig                |  2 +-
>> >  arch/arc/Kconfig            |  2 +-
>> >  arch/arm/Kconfig            |  2 +-
>> >  arch/csky/Kconfig           |  2 +-
>> >  arch/sh/Kconfig             |  2 +-
>> >  arch/xtensa/Kconfig         |  2 +-
>> >  include/linux/cmpxchg-emu.h |  1 +
>> >  lib/Makefile                |  2 +-
>> >  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
>> >  9 files changed, 40 insertions(+), 10 deletions(-)
>> > 
>> > diff --git a/arch/Kconfig b/arch/Kconfig
>> > index 3bb2e568f5b1..d56064797e09 100644
>> > --- a/arch/Kconfig
>> > +++ b/arch/Kconfig
>> > @@ -1817,7 +1817,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>> >  	# strict alignment always, even with -falign-functions.
>> >  	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
>> >  
>> > -config ARCH_NEED_CMPXCHG_1_EMU
>> > +config ARCH_NEED_CMPXCHG_1_2_EMU
>> 
>> Is it actually worth the churn of changing the name?
>> Maybe just a comment that say it adds both 1 and 2 byte emulation?
>
>The churn is only a few lines of code, and the potential confusion from
>the name would be forever.  I agree that if we were stuck with the old
>name, the comment would help, but why not just rip the bandage off and
>be done with it?  ;-)

true.

>
>							Thanx, Paul

--- Thanks!
"I'm not a very positive person" - Linus torvalds
