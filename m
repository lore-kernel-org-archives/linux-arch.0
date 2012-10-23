Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hq2.tensilica.com ([65.119.96.30]:64253 "EHLO
	mailgw.tensilica.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756186Ab2JXPkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Oct 2012 11:40:22 -0400
From: Marc Gauthier <marc@tensilica.com>
Date: Tue, 23 Oct 2012 15:06:59 -0700
Subject: RE: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Message-ID: <522C1DF17AF50042AD8AE87F7887BD3D0B60880C30@exch.hq.tensilica.com>
References: <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com>
 <20121019213548.GR2616@ZenIV.linux.org.uk> <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk> <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos>
 <20121023205119.GA27729@sigill.intra.peff.net>
 <alpine.LFD.2.02.1210232307480.2756@ionos>
 <20121023214717.GA29306@sigill.intra.peff.net>
In-Reply-To: <20121023214717.GA29306@sigill.intra.peff.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff King <peff@peff.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Chris Metcalf <cmetcalf@tilera.com>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Message-ID: <20121023220659.-htfwn3zaOdCC7p51ayYTAH7YQ5p9KhN3BE29cLqjhQ@z>

Jeff King wrote:
> On Tue, Oct 23, 2012 at 11:25:06PM +0200, Thomas Gleixner wrote:
> > > The resulting notes are stored in a separate
> > > revision-controlled branch
> >
> > Which branch(es) is/are that ? What are the semantics of that?
[...]


Nice feature.

Can a later commit be eventually be made to reference some set
of notes added so far, so they become part of the whole history
signed by the HEAD SHA1?  hence pulled/pushed automatically as
well.  Otherwise do you not end up with a forever growing separate
tree of notes that loses some of the properties of being behind
the head SHA1 (and perhaps less scalable in manageability)?
Also that way notes are separate only temporarily.

As for automating the inclusion of notes in the flow, can that
be conditional on some pattern in the note, so that e.g. the
Acked-by's get included and folded in automatically, whereas
others do not, according to settings?

-Marc
