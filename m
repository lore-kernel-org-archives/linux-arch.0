From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/23] Make register values available to panic notifiers
Date: Mon, 12 Apr 2010 02:24:09 -0400
Message-ID: <n2i8bd0f97a1004112324g833510adr92bfd195051b882@mail.gmail.com>
References: <20100412060609.GA25273@dvomlehn-lnx2.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35579 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab0DLGYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2010 02:24:30 -0400
In-Reply-To: <20100412060609.GA25273@dvomlehn-lnx2.corp.sa.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David VomLehn <dvomlehn@cisco.com>
Cc: to@dvomlehn-lnx2.corp.sa.net, "linux-arch@vger.kernel.org"@cisco.comlinux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, maint_arch@dvomlehn-lnx2.corp.sa.net

On Mon, Apr 12, 2010 at 02:06, David VomLehn wrote:
> This patch makes panic() and die() registers available to, for exampl=
e,
> panic notifier functions. =C2=A0Panic notifier functions are quite us=
eful
> for recording crash information, but they don't get passed the regist=
er
> values. This makes it hard to print register contents, do stack
> backtraces, etc. The changes in this patch save the register state wh=
en
> panic() is called and introduce a function for die() to call that all=
ows
> it to pass in the registers it was passed.
>
> Following this patch are more patches, one per architecture. These in=
clude
> two types of changes:
> o =C2=A0A save_ptregs() function for the processor. I've taken a whac=
k at
> =C2=A0 doing this for all of the processors. I have tested x86 and MI=
PS
> =C2=A0 versions. I was able to find cross compilers for ARM, ... and =
the
> =C2=A0 code compiles cleanly. Everything else, well, what you see is =
sheer
> =C2=A0 fantasy. You are welcome to chortle with merriment.

could you post a sample module that you're using to test with here ?
presumably you have some simple code that registers a notify handler
and then calls panic_with_regs() ...
-mike
