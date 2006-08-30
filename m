Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57031 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750929AbWH3Mxf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Aug 2006 08:53:35 -0400
Message-Id: <20060830124356.567568000@klappe.arndb.de>
Date: Wed, 30 Aug 2006 14:43:56 +0200
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/6] kill __KERNEL_SYSCALLS__, try #3
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>

This should address all comments I got for the second version.
Since there is no common agreement on what should happen to
the _syscallX macros, I'm not touching them at all this time.

Whoever wants to remove, reenable or replace them, should send
a separate set of patches for these. With my patches, these
macros are not used in the kernel, and not useable from user
space, so we should probably do _something_ about them.

	Arnd <><

--

