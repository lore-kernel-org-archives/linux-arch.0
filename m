From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 4/7] Blackfin: Rename DES PC2()
 symbol to avoid collision
Date: Thu, 26 Aug 2010 15:40:24 -0400
Message-ID: <AANLkTi=3EzXm4qu+cVLj0gapDUUWgM-V1quA6X84_jHS@mail.gmail.com>
References: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk> <20100826141126.11132.71843.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51754 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0HZTlR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2010 15:41:17 -0400
In-Reply-To: <20100826141126.11132.71843.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

On Thu, Aug 26, 2010 at 10:11, David Howells wrote:
> Rename the PC2() symbol in the generic DES crypto module to be prefixed with
> DES_ to avoid collision with arch code (Blackfin in this case).

unfortunately this is one Blackfin define we cant easily hide away in
a peripheral-specific header and avoid global namespace pollution.  it
represents a pin that can be used across different peripherals.

so it'd be nice if the crypto/ guys took this change :)

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
-mike
