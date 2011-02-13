From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 00/75] genirq: Overhaul for 2.6.39
Date: Sun, 13 Feb 2011 13:50:53 +0100
Message-ID: <20110213125053.GA28968@merkur.ravnborg.org>
References: <20110210222908.661199947@linutronix.de> <AANLkTi=waRQcvdxyKUgcLZ1r-hwUcAVZeVDcBa-apyK2@mail.gmail.com> <alpine.LFD.2.00.1102110058450.31804@localhost6.localdomain6> <AANLkTin3o9eFjpe6TMmKb5LSRUT+0Y2EpD4OU4LzN8Kd@mail.gmail.com> <alpine.LFD.2.00.1102110135320.31804@localhost6.localdomain6> <alpine.LFD.2.00.1102111359580.31804@localhost6.localdomain6> <20110211135906.GA16358@elte.hu> <alpine.LFD.2.00.1102111516020.31804@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:53233 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab1BMMu4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 Feb 2011 07:50:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102111516020.31804@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Fri, Feb 11, 2011 at 03:26:11PM +0100, Thomas Gleixner wrote:
> On Fri, 11 Feb 2011, Ingo Molnar wrote:
> > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > > =A0129 files changed, 4353 insertions(+), 5400 deletions(-)
> >=20
> > Did I get the file count right - roughtly how many files are affect=
ed throughout all=20
> > architectures? The changes are massively intrusive and widely sprea=
d out so we=20
> > cannot do them in one go, right?
>=20
> Alone the stuff which fiddles in irq_desc->status for whatever reason=
s
> is >100 files in arch/. And that has do be done manually case by case=
=2E

Some kind of arch TODO list wold be nice. Just to let the arch maintain=
ers
know what you expect from them (on top of the deprecated warnings).

	Sam
