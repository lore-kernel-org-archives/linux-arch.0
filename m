From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
Date: Sat, 7 May 2011 09:57:36 -0400
Message-ID: <BANLkTim4RFeFpj8uJsnm0gazLOMdYr8P1Q@mail.gmail.com>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61711 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab1EGN55 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 09:57:57 -0400
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-m32r@ml.linux-m32r.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org

On Sat, May 7, 2011 at 01:57, Stephen Boyd wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
>
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
>
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> =C2=A0arch/blackfin/Kconfig.debug =C2=A0| =C2=A0 =C2=A09 ---------

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
