From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: arm: Request to preserve TPIDRURW per thread
Date: Mon, 21 Jan 2013 16:11:43 -0800
Message-ID: <20130122001143.GA4107@kroah.com>
References: <50FDD7A8.1080402@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62729 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3AVALr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 19:11:47 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so3585084pbc.4
        for <linux-arch@vger.kernel.org>; Mon, 21 Jan 2013 16:11:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50FDD7A8.1080402@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: linux-arch@vger.kernel.org, will.deacon@arm.com, rmk+kernel@arm.linux.org.uk

On Tue, Jan 22, 2013 at 01:04:56AM +0100, Andr=E9 Hentschel wrote:
> Hi,
> that comes a bit late, but [1] asked for objections.
> As you can see in [2] there are more and more applications coming to =
WinRT, Wine could support them,
> but mostly they expect to have the thread environment block (TEB) in =
TPIDRURW.
> This register must be preserved per thread and we have patches for th=
at.
>=20
> Currently there exist two kernel behaviours:
>=20
> 1. the kernel does not touch TPIDRURW at all ("covert channel")
> 2. the kernel clears TPIDRURW on thread switch
>=20
> Attached to [3] you'll find kernel patches you can freely use.
> Permission and more info you'll find in [4].
> Any hints or suggestions?
>=20
> [1] http://www.kernelhub.org/?p=3D2&msg=3D57979
> [2] http://forum.xda-developers.com/showthread.php?t=3D2092348
> [3] http://bugs.winehq.org/show_bug.cgi?id=3D31322
> [4] http://bugs.winehq.org/show_bug.cgi?id=3D31308

Please submit the patches to fix this in the way described in
Documentation/SubmittingPatches.  Once they are in Linus's tree, I'll b=
e
glad to take them in the stable tree if they meet the guidelines that
are described in Documentation/stable_kernel_rules.txt.

Does that help?

thanks,

greg k-h
