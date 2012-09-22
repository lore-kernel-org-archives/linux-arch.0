From: Cyrill Gorcunov <gorcunov@openvz.org>
Subject: Re: sys_kcmp (was: Re: [PATCH 1/2] ARM: add finit_module syscall to
 ARM)
Date: Sat, 22 Sep 2012 15:45:49 +0400
Message-ID: <20120922114549.GA11610@moon>
References: <CAMuHMdXVKvaCoJTRb4O+Z4GuifzTEopdcRfRHBahQmpuX+Xi0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63425 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab2IVLpx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Sep 2012 07:45:53 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXVKvaCoJTRb4O+Z4GuifzTEopdcRfRHBahQmpuX+Xi0w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Sat, Sep 22, 2012 at 12:56:42PM +0200, Geert Uytterhoeven wrote:
> On Fri, Sep 21, 2012 at 6:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > That brings up another question though - when was kcmp added to x86, and
> > why aren't we getting notifications from checksyscalls.sh that ARM hasn't
> > been updated?
> >
> > It seems to be that the script was broken, and no one has noticed.
> 
> It seems Heiko did notice: http://www.serverphorums.com/read.php?12,559093
> 
> Now, I'm a bit puzzled by what follows: Heiko proposes a patch to
> ignore sys_kcmp,
> as it's x86-specific, which is acked by Cyrill. Then it suddenly

hpa@ pointed that better approach is to implement kcmp on other archs
after i've acked the patch. so then Heiko provided a patch for s390.
