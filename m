From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Tue, 5 Aug 2008 19:16:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808051916010.28683@anakin>
References: <20080728200500.GA14284@uranus.ravnborg.org>
 <200808051418.05324.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761747AbYHERQl@vger.kernel.org>
In-Reply-To: <200808051418.05324.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 5 Aug 2008, Rusty Russell wrote:
> On Tuesday 29 July 2008 06:05:00 Sam Ravnborg wrote:
> > is is suggested to move the arch specific files under arch/
> > and for the header files this is arch/$ARCH/include.
> 
> Well, it would have been nice to take the opportunity to separate user-visible 
> header files and non-user-visible files.  We could have left the user-visible 
> ones in place, for example: diffstat would then show when you were frobbing 
> the userspace interface.
> 
> But I'm guessing noone wants even more marginal-value churn right now.
> Rusty.

That actually sounds like a good idea to me!
Can we do the same with the <linux/*.h> ones?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
