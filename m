Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:46766 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264287AbUEDI6T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 May 2004 04:58:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: static DEFINE_PER_CPU vs. modules
Date: Tue, 4 May 2004 10:56:39 +0200
References: <200405031741.52504.arnd@arndb.de> <200405040024.03906.arnd@arndb.de> <16534.53723.524354.936428@napali.hpl.hp.com>
In-Reply-To: <16534.53723.524354.936428@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405041056.43748.arnd@arndb.de>
To: davidm@hpl.hp.com
Cc: Richard Henderson <rth@twiddle.net>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 04 May 2004 01:12, David Mosberger wrote:
> Why not use a GCC attribute?  Perhaps it's a bit of a stretch, but if
> you interpret "model(small)" as indicating "small positive/negative
> _absolute_ address", you could even use the same attribute name.

Yes, that might solve it for gcc-3.5, but not for any older compiler
that does not support this, so it's not an option. Besides, it
would probably mean less efficient code (three loads to get to
a per-cpu variable instead of the current two).

	Arnd <><
