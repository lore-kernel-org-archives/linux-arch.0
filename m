From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/2] Blackfin: initial tracehook support
Date: Mon, 15 Feb 2010 02:36:50 -0500
Message-ID: <8bd0f97a1002142336k9ffeekb8c81384252d2192@mail.gmail.com>
References: <20100202185907.GE3630@lst.de> <1265881389-26925-2-git-send-email-vapier@gentoo.org>
	<20100211204653.34BB3900@magilla.sf.frob.com> <8bd0f97a1002111554ib69bd48rc3c5f4af65058281@mail.gmail.com>
	<20100212032406.BE645C81B@magilla.sf.frob.com> <8bd0f97a1002112033m5805d4eco3add4d5625e71e9@mail.gmail.com>
	<20100212204427.5F75CA18@magilla.sf.frob.com> <8bd0f97a1002130141v301af30av3ec51f065656b65f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.211.179]:62392 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab0BOHhN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Feb 2010 02:37:13 -0500
In-Reply-To: <8bd0f97a1002130141v301af30av3ec51f065656b65f@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, oleg@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Sat, Feb 13, 2010 at 04:41, Mike Frysinger wrote:
> On Fri, Feb 12, 2010 at 15:44, Roland McGrath wrote:
>> Moreover, the usual cleanup is to make your arch_ptrace() use
>> copy_regset_from_user() and copy_regset_to_user() to implement exist=
ing
>> calls ike PTRACE_GETREGS. =C2=A0That way, existing ptrace users (str=
ace, gdb)
>> become tests of the user_regset paths (some of them).

unfortunately the Blackfin ports of both gdb and strace do not use the
PTRAGE_{G,S}ETREGS interfaces.  so i had to port both in order to test
out the new code.

> OK, this should be doable. =C2=A0are there any guidelines for what sh=
ould
> be in a specific regset ? =C2=A0the Blackfin processor does not have =
a FPU,
> so the only set i have defined atm is the "general" set and that is
> exactly the same as the current set of ptrace registers. =C2=A0this i=
s also
> what the current PTRACE_{G,S}ETREGS operates on (struct pt_regs).

going by the gdb code, all i really need to worry about is the
"general" set and have that be the same as pt_regs today

i have one or two small things to check out, but i think we should be
all set now thanks to your help
-mike
