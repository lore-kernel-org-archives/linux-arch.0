From: Grant Grundler <grantgrundler@gmail.com>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Date: Fri, 18 May 2012 11:05:46 -0700
Message-ID: <CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61861 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966353Ab2ERSFr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 14:05:47 -0400
In-Reply-To: <20120518175833.GQ22082@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, May 18, 2012 at 10:58 AM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
=2E..
>=A0Except for that mess with multiple
> pending signals, the value we have in r28 on syscall entry doesn't
> seem to affect the syscall behaviour... =A0Some HPUX compat fun?

We stopped trying to support HPUX compat support probably 8 or so
years ago. Since HP didn't care, no one else did either.  So no need
to consider it now.

thanks,
grant
