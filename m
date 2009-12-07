From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: What's in asm-generic.git
Date: Mon, 7 Dec 2009 16:14:45 +0100
Message-ID: <200912071614.46166.arnd@arndb.de>
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935291AbZLGPPS@vger.kernel.org>
In-Reply-To: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com>
Sender: linux-kernel-owner@vger.kernel.org
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Monday 07 December 2009, liqin.chen@sunplusct.com wrote:
> Arnd Bergmann <arnd@arndb.de> =D0=B4=D3=DA 2009-12-04 03:14:08:
>=20
> Maybe you can add a __NR_set_thread_area define in asm-generic/unsitd=
=2Eh
> for tls used.

Yes, good point. I'll update the syscall list with this, and also check=
 if more
syscalls have been addded.

	Arnd <><
