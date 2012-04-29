Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:55908 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab2D2LDX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 29 Apr 2012 07:03:23 -0400
Date: Sun, 29 Apr 2012 13:03:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 0/4] kbuild: Move vmlinux link out of top-level
	Makefile
Message-ID: <20120429110321.GA7925@merkur.ravnborg.org>
References: <20120428205651.GA7426@merkur.ravnborg.org> <CAMuHMdXsSva4U+-dnyGYOEPGcFWaTSBwkfs_b9JNjW=gxUiQXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXsSva4U+-dnyGYOEPGcFWaTSBwkfs_b9JNjW=gxUiQXQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
Message-ID: <20120429110321.FpTXh5Fvw0JE-SjuNs_yg9NdcGegGQf3EO3qzt-Fe0E@z>

On Sun, Apr 29, 2012 at 10:26:25AM +0200, Geert Uytterhoeven wrote:
> On Sat, Apr 28, 2012 at 22:56, Sam Ravnborg <sam@ravnborg.org> wrote:
> > anyway - so there where nothing gained by using
> 
> ... there was ...
> 
> > - We no logner rebuild if one of the .tmp_kallsyms
> 
> longer
> 
> >  files are deleted.
> 
> ... is deleted
> 
> > - rebuild if options to ld changes (Andi Kleen)
> 
> change

Thanks for all the grammatic corrections. I will await until tonight and
submit a v3 with these corrected and any other comments that may show up until then.

	Sam
