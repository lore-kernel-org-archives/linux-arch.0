From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/8] asm-generic/io.h: allow barriers in io{read,write}{16,32}be
Date: Thu, 05 May 2016 18:29:27 +0200
Message-ID: <4160174.j7y8ElCmf4@wuerfel>
References: <1462462435-27403-1-git-send-email-horia.geanta@nxp.com> <1462462545-27637-1-git-send-email-horia.geanta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:50694 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016AbcEEQ3d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2016 12:29:33 -0400
In-Reply-To: <1462462545-27637-1-git-send-email-horia.geanta@nxp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Horia =?utf-8?B?R2VhbnTEgw==?= <horia.geanta@nxp.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 05 May 2016 18:35:45 Horia Geant=C4=83 wrote:
> While reviewing the addition of io{read,write}64be accessors, Arnd
>=20
> -finds a potential problem:
> "If an architecture overrides readq/writeq to have barriers but does
> not override ioread64be/iowrite64be, this will lack the barriers and
> behave differently from the little-endian version. I think the only
> affected architecture is ARC, since ARM and ARM64 both override the
> big-endian accessors to have the correct barriers, and all others
> don't use barriers at all."
>=20
> -suggests a fix for the same problem in existing code (16/32-bit
> accessors); the fix leads "to a double-swap on architectures that
> don't override the io{read,write}{16,32}be accessors, but it will
> work correctly on all architectures without them having to override
> these accessors."
>=20
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Horia Geant=C4=83 <horia.geanta@nxp.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
