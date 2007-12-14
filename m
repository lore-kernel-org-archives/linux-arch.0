Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60317 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933994AbXLNQQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Dec 2007 11:16:58 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: RFC: remove __read_mostly
Date: Fri, 14 Dec 2007 17:16:46 +0100
References: <20071213222044.GH21616@stusta.de> <p73bq8ugrez.fsf@bingen.suse.de> <20071213224111.GI21616@stusta.de>
In-Reply-To: <20071213224111.GI21616@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200712141716.47742.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 13 December 2007, Adrian Bunk wrote:
> On Thu, Dec 13, 2007 at 11:29:08PM +0100, Andi Kleen wrote:
> > Adrian Bunk <bunk@kernel.org> writes:
> > >
> > > -rwxrwxr-x 1 bunk bunk 46607243 2007-12-13 19:50 vmlinux.old
> > > -rwxrwxr-x 1 bunk bunk 46598691 2007-12-13 21:55 vmlinux
> > 
> > File sizes are useless -- check size output.
> 
>     text    data     bss      dec     hex filename
> 29268488 3697961 5222400 38188849 246b731 vmlinux.old
> 29268435 3685565 5228784 38192784 246c690 vmlinux

Just to make sure everyone interprets this correctly:

The file size in the first example suggests a 8552 byte
(0.02%) size improvement for removing __read_mostly.

The size output shows a -3935 byte (0.01%) size penalty
instead, much smaller because data that was moved out to
the .data.read_mostly section from .bss now takes space
in the binary but won't consume more RAM.

Since 'size' does not take any sections except text, data and
bss into account, its output is more often than not also
misleading, but at least it shows that the footprint is likely
to get larger without __read_mostly rather than smaller.

	Arnd <><
