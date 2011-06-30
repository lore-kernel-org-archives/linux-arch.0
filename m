From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/2] modules: add default loader hook implementations
Date: Thu, 30 Jun 2011 15:43:43 -0400
Message-ID: <BANLkTi=6RkrRHeNtDhpebKx7cNXNKvbxtw@mail.gmail.com>
References: <201106281245.19457.arnd@arndb.de> <1309461732-2875-1-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48714 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab1F3ToE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2011 15:44:04 -0400
In-Reply-To: <1309461732-2875-1-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: rusty@rustcorp.com.au, arnd@ardnb.de, geert@linux-m68k.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, torvalds@linux-foundation.org, akpm@linux-foundation.org

On Thu, Jun 30, 2011 at 15:22, Jonas Bonn wrote:
> -/* These must be implemented by the specific architecture */
> +/* These may be implemented by architectures that need to hook into =
the
> + * module loader code. =C2=A0Architectures that don't need to do any=
thing special
> + * can just rely on the 'weak' default hooks defined in kernel/modul=
e.c.
> + * Note, however, that at least one of apply_relocate or apply_reloc=
ate_add
> + * must be implemented by each architecture.
> + */

still need to update this multi-line comment ;)
-mike
