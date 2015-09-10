Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36971 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825AbbIJLPh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Sep 2015 07:15:37 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com> <2644177.lVCYzIBfPW@wuerfel>
Subject: Re: [PATCH] Remove #ifdef CONFIG_64BIT from all asm-generic/fcntl.h
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18146.1441883729.1@warthog.procyon.org.uk>
Date: Thu, 10 Sep 2015 12:15:29 +0100
Message-ID: <18147.1441883729@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dhowells@redhat.com, arnd@arndb.de, 3chas3@gmail.com, hpa@zytor.com, mingo@redhat.com, plagnioj@jcrosoft.com, jikos@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tglx@linutronix.de, tomi.valkeinen@ti.com, x86@kernel.org
Message-ID: <20150910111529.BKXuz5T_bvdYvlz5b-dlFzzY755y0-0y6gao2A7H-KY@z>

Rather than iterating through all the rest of your patches and saying the same
thing, if there's something in a UAPI header that needs wrapping in __KERNEL__
to exclude it from userspace's use, then it should be transferred to the
non-UAPI variant of that header (which should #include the UAPI variant).

David
