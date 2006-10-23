Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:14221 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751597AbWJWGeg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Oct 2006 02:34:36 -0400
Message-ID: <453C6260.7060609@s5r6.in-berlin.de>
Date: Mon, 23 Oct 2006 08:34:08 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
Subject: Re: dealing with excessive includes
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <200610230242.58647.ak@suse.de> <20061023010812.GE25210@parisc-linux.org> <200610230331.16573.ak@suse.de> <20061023013604.GF25210@parisc-linux.org> <453C1FB5.9070007@yahoo.com.au>
In-Reply-To: <453C1FB5.9070007@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@xenotime.net>, Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin wrote:
...
> If you have an
> 
> #ifndef _LINUX_INTERRUPT_H
> #error ...
> 
> That almost explicitly tells you which is the correct file to include to
> get all definitions from this file. Wouldn't that help?

This can even be evaluated by a script that searches for required header
files, except if more than one of such clauses appear in a file.
-- 
Stefan Richter
-=====-=-==- =-=- =-===
http://arcgraph.de/sr/
