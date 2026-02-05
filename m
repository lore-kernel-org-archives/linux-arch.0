Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E535F8AF;
	Thu,  5 Feb 2026 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278313; cv=none; b=MYoVLRz4PRBvDLYLfHPbFbIcb7HF7uYr86kyxj2V6CIZvT2zNaKS8qPIjZPWiWXMyFwxVlvew77qgBKxURezY4XJrboYQYouik/NB9y7zz6/KEFPdCwpeKif6RSdbh4Qb/WXdL20WYf76KzmHlhhG7QbpBw0dl0PhqU7g9eh7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278313; c=relaxed/simple;
	bh=BASbWuVWV/zUTkyQUenseoXn+as5sod/qSPZSb97xDA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r5BjQLEmEzukMcv6mpBnqr/kvNdEO/4cY0yVLJEVxvTGk6V5BBYsErRjsJL6eRFuFziJ+HTAD4E4okH1AgZmA2Pn2BfL/UdxdLHJuqdmrqDdtbaqRSUTmc27QiLpwFHLap7FwmBLtuYb/TGPlTEnHRKrZz40L5EK5t1uKeiTahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jCnUnAC7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kh4+rASO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jCnUnAC7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kh4+rASO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4111CEC0562;
	Thu,  5 Feb 2026 02:58:32 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 02:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770278312;
	 x=1770364712; bh=NcrU81+fnhXaSVX9sn3CITROGjdo+DCLl0eqiW6c8VE=; b=
	jCnUnAC7QV46AkQm56Y/ouLSQjbL84T8u9ws0wqRA1Jpy8amNqNcHBo0I7URHzm+
	5NHDeDE5dFbcOHd1IkGS/VbWKmieXsoIUZMo34pgCtvdmD5oM0RVyKSNTQLIa+Pf
	xpTicbjYESf1UAr0hVbV8rFlDRmsX4meBrtFOF+GthK1txzlWMxz9MVEqZAavO36
	EUm2t18Nj2cF1WhPODbdxzoFbylcI/5cbPye5edEkOdm2Op0kXwNV9ip/XxrQmkx
	Ro44YlNgvRFfYUaFcXKtyThJ8qf0j37n3A0dIcH5GQBXWmM2rEkjuAoZdGBCAkjs
	xGiZvXAWCe2RpUpwuxir8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770278312; x=
	1770364712; bh=NcrU81+fnhXaSVX9sn3CITROGjdo+DCLl0eqiW6c8VE=; b=k
	h4+rASOzOR6SrbEXY5AxdYKO3gHXdAKmy0dg6428zwsKGBkU0MquFYQqPdEFax5W
	MldJWHxCKVyddRo8/fDlfxk0QtdulCq6Wq6HqkaG4Olh3w5c/F5zstfP8t2vxrqk
	Gy5L1aKgXW+9Tu19/5ScXJn/Dcj5/WvPMpPN2Fp4Q6KU6cbdZQ4fXjrUFhy7uJ9u
	9plocS9MpUfWukqra7iPssEK3LnwobG7IEqzkqpE4mNaWiWk1IRuwYYQ7TimP2Q8
	pioX3dVcLcN+NePRvr18lBriMT9/LSZwMdpth6K5NeYG/0om3NUpgVDbyPkHaLcF
	+F21zl3ofYFUAs5qaHf+w==
X-ME-Sender: <xms:p02EaaSgx017jfaGLmCesp-Pg1NsJyAty_BRLm47xzDKZpc5ilAl0w>
    <xme:p02EaamREaMM3iRNEHhwSFa1N4ezJm1v2GnLDg_5D58sH2u1MPwrK09vWUyMAvgjd
    fncLb_pi2BUHyQgqL2JfH2suYkjqMuZ2u3YLWY3DazcSXJ_2vQnDXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsvghnjedujeesrghnuggvshhtvggthhdrtghomhdprhgtphhtth
    hopehmihhnrggthhhouhesrghnuggvshhtvggthhdrtghomhdprhgtphhtthhopehrrghn
    ugholhhphhesrghnuggvshhtvggthhdrtghomhdprhgtphhtthhopehtihhmiedtleesrg
    hnuggvshhtvggthhdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdr
    tghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtg
    hpthhtoheprghlvgigsehghhhithhirdhfrhdprhgtphhtthhopegriiejtddtvddusehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphhjfieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p02EaRiJWqJLzqy9nuTwXBtALAS8Quo9-z-dD8QtERr4E48qz_bUBg>
    <xmx:p02EaciORQ-BgEO_1zBZ0jG_6jg-cZSUgUgRizbc2w5FULChmKooFA>
    <xmx:p02EafGFL6huMW4FehMI3A-3pLbTrf68VI-OgfTgkzJNMA1cG4VRVg>
    <xmx:p02EaZDZaNQ8DkZTIK_BvUCKboTZXHqn66p_YMxwPvpxgLVJvctr_w>
    <xmx:qE2EaVEIvBoM1q3mHTM619SqjVvt1PcezXGecRDoPJdlkIXtP5K3eylP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4348B700065; Thu,  5 Feb 2026 02:58:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALU_AqKd0drw
Date: Thu, 05 Feb 2026 08:57:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hui Min Mina Chou" <minachou@andestech.com>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: tim609@andestech.com, "Ben Zong-You Xie" <ben717@andestech.com>,
 az70021@gmail.com, Randolph <randolph@andestech.com>
Message-Id: <af2c346e-c878-45dd-93b9-b19c80627651@app.fastmail.com>
In-Reply-To: <20260205055800.586458-1-minachou@andestech.com>
References: <20260205055800.586458-1-minachou@andestech.com>
Subject: Re: [PATCH] riscv: Fix __kernel_off_t to 64 Bits in RV32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026, at 06:58, Hui Min Mina Chou wrote:
> From: Randolph <randolph@andestech.com>
>
> Modify the __kernel_off_t type for RV32 to 64 bits to comply with
> the current glibc calling convention.
>
> In RISC-V, off_t is 64 bits in glibc, and __kernel_off_t must match
> this size. For RV32, the kernel uses the long type, which should be
> changed to long long to ensure consistency.

I don't think we can change the ABI incompatibly like this,
it breaks any current user of low-level interface that expects
the legacy types, whenever you mix a userspace binary built against
old kernel headers with a new kernel, or vice versa.

From looking at uclibc sources, I believe they still default to
a 32-bit off_t on all 32-bit architectures.

> To address the Y2038 problem, the glibc upstream for RISC-V has adopted
> 64-bit time_t and off_t for both RV32 and RV64 [*1].
> However, no corresponding modification was made on the kernel side,
> leading to test case failures in LTP=E2=80=99s fnctl due to size incon=
sistencies.
> This discrepancy causes errors when glibc passes the struct flock
> parameter to the kernel through fnctl().

I'm not sure if this is a bug in LTP or glibc, but nothing should
ever mix the low-level kernel interfaces with the glibc types.

Regardless of the architecture, the only combinations that are
allowed are:

 - libc fcntl() with libc 'struct flock'
 - libc fcntl64() with libc 'struct flock64'
 - syscall(__NR_fcntl, ...) with kernel 'struct flock'
 - syscall(__NR_fcntl64, ...) with kernel 'struct flock64'

When using 64-bit off_t in glibc, that should transparently
map the default fcntl implementation to the newer kernel
interfaces as described in the fcntl man page.

Can you point out which LTP tests exactly are failing, and
check which combination they use in your version?

Is it picking up the 32-bit types from the kernel headers,
or is it trying to call the legacy __NR_fcntl syscall
with the glibc type?

I see a special case in
ltp/testcases/kernel/syscalls/fcntl/fcntl_common.h, but that
seems to use the low-level kernel interfaces correctly.

> The structure of flock are shown as below:
>
> struct flock in glibc:
> ------------------------------------------------------
> struct flock
>   {
>     short int l_type;
>     short int l_whence;
>     __off_t l_start;
>     __off_t l_len;
>     __off64_t l_start;
>     __off64_t l_len;             <------  "__off64_t" in glibc is 64bit
>     __pid_t l_pid;
>   };

The definition I see has this  #ifdef check:

struct flock
  {
    short int l_type;   /* Type of lock: F_RDLCK, F_WRLCK, or F_UNLCK.  =
*/
    short int l_whence; /* Where `l_start' is relative to (like `lseek')=
.  */
#if __WORDSIZE =3D=3D 64 || !defined __USE_FILE_OFFSET64
    __off_t l_start;    /* Offset where the lock begins.  */
    __off_t l_len;      /* Size of the locked area; zero means until EOF=
.  */
#else
    __off64_t l_start;  /* Offset where the lock begins.  */
    __off64_t l_len;    /* Size of the locked area; zero means until EOF=
.  */
#endif
    __pid_t l_pid;      /* Process holding the lock.  */
  };

I assume __USE_FILE_OFFSET64 is always set on riscv32, so the
two structures are defined to be the same and match the kernel's
flock64.

The definition is otherwise the same as on most 32-bit architectures.

Interestingly, microblaze does not even have that #if block
and instead defines its 'struct flock' unconditionally with
a 32-bit __off_t, which is probably a bug in glibc.

> +/*
> + * In the generic flow, this file is automatically created if it does=20
> not
> + * already exist, as indicated by the line.
> + * "#include <asm-generic/posix_types.h>"
> + *
> + * If the file already exists, the automatic creation process will be=20
> skipped.
> + * Adding architecture-specific types to this file may alter the=20
> generic flow,
> + * potentially causing type conflicts during the build phase. To avoi=
d=20
> this,
> + * define a variable to instruct the generic code to skip the=20
> re-typedef
> + * process.
> + */

There is really no need to explain how the build system works here.

> +#if __BITS_PER_LONG =3D=3D 32
> +typedef long long		__kernel_off_t;
> +#define _arch_kernel_off_t	_arch_kernel_off_t
> +#endif

This does not follow the normal style for overriding types.
You are also breaking the compat syscall for rv64 kernels,
which would have to override compat_off_t.

     Arnd
