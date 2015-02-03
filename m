From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC] change non-atomic bitops method
Date: Tue, 03 Feb 2015 15:14:43 +0000
Message-ID: <30242.1422976483@warthog.procyon.org.uk>
References: <20150202193154.GC10842@pengutronix.de> <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58079 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965790AbbBCPPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 10:15:38 -0500
In-Reply-To: <20150202193154.GC10842@pengutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Uwe =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FKleine-K=3DF6nig=3F=3D?= <u.kleine-koenig@pengutronix.de>
Cc: dhowells@redhat.com, "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

Uwe Kleine-K=C3=B6nig  wrote:

> Might be a matter of taste, but this check is equivalent to
>=20
> 	*p !=3D (*p | mask)
>=20
> which is what you really want to test for.

I would argue that this is less clear as to what's going on.

David
