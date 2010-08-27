From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/7] Blackfin: Don't redefine
 blackfin serial port symbols
Date: Thu, 26 Aug 2010 22:11:27 -0400
Message-ID: <AANLkTi=QoMLTEDVfW0oKGVs-MhG+GpNxjC6axzLaHFKR@mail.gmail.com>
References: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk>
 <20100826141115.11132.52122.stgit@warthog.procyon.org.uk> <AANLkTinxwf6kY6hCnUn=ATSYFutCAeSJQ1pgUj11UfD4@mail.gmail.com>
 <32426.1282852938@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54526 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab0H0CLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Aug 2010 22:11:48 -0400
In-Reply-To: <32426.1282852938@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Thu, Aug 26, 2010 at 16:02, David Howells wrote:
> Mike Frysinger wrote:
>> we've got a local patch doing pretty much the same thing, but it's
>> waiting on driver patches being applied. =C2=A0so once those are all=
 set, i
>> can push up the Blackfin one.
>
> Can you give it to me to apply to my patchset in place of this one?

this guy:
http://git.kernel.org/?p=3Dlinux/kernel/git/vapier/blackfin.git;a=3Dcom=
mitdiff;h=3D8e289204d2d190a8b430edf956a315ba383d85f6
-mike
