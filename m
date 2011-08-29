From: "Joseph S. Myers" <joseph@codesourcery.com>
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
Date: Mon, 29 Aug 2011 15:21:52 +0000 (UTC)
Message-ID: <Pine.LNX.4.64.1108291518300.17624@digraph.polyomino.org.uk>
References: <20110822193602.GA23301@codeaurora.org> <2047151.mWElcT8jZQ@wuerfel>
 <20110829104324.GM24840@distanz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.codesourcery.com ([38.113.113.100]:57955 "EHLO
	mail.codesourcery.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1H2PVy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2011 11:21:54 -0400
In-Reply-To: <20110829104324.GM24840@distanz.ch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On Mon, 29 Aug 2011, Tobias Klauser wrote:

> On nios2 we're using an outdated eglibc version (based on glibc 2.5)
> right now and thus we still rely on our own non-asm-generic version of
> asm/unistd.h

As I noted before 
<http://sourceware.org/ml/libc-ports/2010-09/msg00014.html> Nios II has 
the problem for upstream submission of the unassigned nature of the 
binutils and GCC ports - unless you know of any progress on that issue at 
Altera.

-- 
Joseph S. Myers
joseph@codesourcery.com
