Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60744 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756171AbaEPXHS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 May 2014 19:07:18 -0400
Message-ID: <537699E7.9050005@zytor.com>
Date: Fri, 16 May 2014 16:06:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/25] Change time_t and clock_t to 64 bit
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <8468354.y2kUZdOz9e@wuerfel> <1400168823.7862.9.camel@dabdike> <9176609.NChAu49t7f@wuerfel> <20140515220717.1ced0f1a@alan.etchedpixels.co.uk> <20140516074826.GB8555@infradead.org>
In-Reply-To: <20140516074826.GB8555@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, James Bottomley <James.Bottomley@hansenpartnership.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20140516230615.b8RqkNBU2yCD51o7mwwEMGlsUUBTmYir9OXbIsy-nQg@z>

On 05/16/2014 12:48 AM, Christoph Hellwig wrote:
> 
> The stat(64) syscall already has stopped time_t for a long time:
> 
> struct stat64 {
> 	...
> 	int             st_atime;       /* Time of last access.  */
> 	unsigned int    st_atime_nsec;
> 	int             st_mtime;       /* Time of last modification.  */
> 	unsigned int    st_mtime_nsec;
> 	int             st_ctime;	/* Time of last status change. */
> 	unsigned int	st_ctime_nsec;
> };
> 

... except that that is really a struct timespec just written weirdly,
and userspace uses it as a struct timespec.

	-hpa


