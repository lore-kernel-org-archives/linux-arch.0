From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 05/38] Disintegrate asm/system.h for ARM [ver #3]
Date: Fri, 16 Mar 2012 10:40:06 -0400
Message-ID: <1331908808.12353.2.camel@deneb.redhat.com>
References: <20120315205514.28759.58969.stgit@warthog.procyon.org.uk>
	 <20120315205603.28759.91855.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161069Ab2CPOkP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Mar 2012 10:40:15 -0400
In-Reply-To: <20120315205603.28759.91855.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org

On Thu, 2012-03-15 at 20:56 +0000, David Howells wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-arm-kernel@lists.infradead.org
> ---

<snip>

> diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
> index 94e924e..d9072d9 100644
> --- a/include/linux/mtd/map.h
> +++ b/include/linux/mtd/map.h
> @@ -1,4 +1,4 @@
> -/*
> + r/*
>   * Copyright =A9 2000-2010 David Woodhouse <dwmw2@infradead.org> et =
al.
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>=20

Looks like this hunk was unintended. It is causing a build failure for
me.

--Mark
