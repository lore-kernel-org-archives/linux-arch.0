From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge mmu and non-mmu versions of sys_call_table)
Date: Tue, 19 Apr 2011 14:16:35 +0200
Message-ID: <201104191416.35746.arnd@arndb.de>
References: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com> <alpine.OSX.2.00.1104191807210.373@ibook.intranet> <m2k4eqfocu.fsf@igel.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <m2k4eqfocu.fsf@igel.home>
Sender: linux-m68k-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 19 April 2011, Andreas Schwab wrote:
> Finn Thain <fthain@telegraphics.com.au> writes:
> 
> > Wouldn't that require const void * const sys_call_table[] ?
> 
> No, the right signature would be void (*const sys_call_table[])(void)
> since this is an array of function pointers.
> 

But it's not an array of pointers to function with signature
void f(void). It's an array of void pointers that we assign
to function pointers of various types.

	Arnd
