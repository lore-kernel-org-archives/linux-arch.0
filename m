Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1759E337;
	Fri, 11 Sep 2026 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158051; cv=none; b=vGPK6cy+GHgC8jCncouqqVu3jCEW6NuWXtxtSvCkvCdJK2KilERefCuEEwiJ379Qbm/1flOanboRQYAYIWYmtHHYUfGx/dPgZS/j3wZwVi3+4Eb18z4HdvfxtOv/mda668XPuXC7gmVX11CO0FVmI7wfk/9N31B4sIlkPtNXBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158051; c=relaxed/simple;
	bh=lpaXRPJxbfkNUnSKjznQuKuprZtqR8LRqml2W/CXNqE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TsknmmTVlOL/JH0o5Ze+6I6p1u279xki+lqmV8CH4qA2PapLvguPu7NGyKTXljRuCInkw4x2lt6yE2cgBjiMHokNAb9usYLGxCSZVa+jytGwx5ZeF67mUqlLa38TFtmyQme82Q2B2CkUGOymbqvDReEfMPttXE/O+LhiNCe7fD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Fri, 11 Sep 2026 21:20:30 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>
CC: Frederic Weisbecker <frederic@kernel.org>, neeraj.upadhyay@kernel.org,
 Boqun Feng <boqun@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 rcu <rcu@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/6=5D_Add_two-byte_cmpxchg_emu?=
 =?US-ASCII?Q?lation_and_wire_it_into_the_architectures?=
In-Reply-To: <a817a6ed-7345-435c-97bd-a394b90e8366@app.fastmail.com>
References: <20260911192540.20983-1-brads@mainlining.org> <a817a6ed-7345-435c-97bd-a394b90e8366@app.fastmail.com>
Message-ID: <95BE6915-5583-4E32-9CCC-FED8BC91AD41@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 September 2026 21:17:15 BST, Arnd Bergmann <arnd@arndb.de> wrote:
>On Fri, Sep 11, 2026, at 21:25, Bradley Morgan wrote:
>> Per Paul's note, Arnd Bergmann's platform removal series was
>> checked before analyzing the users. It removes the imx31 and
>> omap24xx CPU_ARM1136R0 selectors, but INTEGRATOR_CM1136JFS still
>> selects CPU_ARM1136R0 until its scheduled removal in early 2027,
>> so the ARMv6 path in patch 3 is still live.
>
>I can still restructure this and pull the INTEGRATOR_CM1136JFS
>removal a little earlier. At the moment, this is part of the
>patch to remove CPU_ARM1136R0, which I had planned to submit
>once the arch/arm/mach-*/ platform removal patches are done:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=a8cfcc5533e33a
>
>I could turn the mach-versatile/Kconfig change into a separate
>(trivial) patch and add it to the platform series to avoid
>churn here. The armv6 cmpxchg() code would still exist
>in 7.4 then, but be unreachable.
>
>       Arnd
Hi, is this like V2 required? Or a *ugh fine that's ok* kinda message?
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
