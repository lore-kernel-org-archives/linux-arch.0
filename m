Return-Path: <B.Zolnierkiewicz@elka.pw.edu.pl>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50864 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264578AbUDTWxW
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Apr 2004 18:53:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: "[PATCH] idr.c: extra features enhancements" breaks some archs
Date: Wed, 21 Apr 2004 00:52:39 +0200
References: <200404202259.43931.bzolnier@elka.pw.edu.pl> <20040420142947.6501c5c4.akpm@osdl.org> <20040420234245.G16428@flint.arm.linux.org.uk>
In-Reply-To: <20040420234245.G16428@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404210052.39771.bzolnier@elka.pw.edu.pl>
To: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: jim.houston@comcast.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 21 of April 2004 00:42, Russell King wrote:
> On Tue, Apr 20, 2004 at 02:29:47PM -0700, Andrew Morton wrote:
> > Could I please ask the relevant arch maintainers to prepare an
> > implementation?
>
> Its in the usual place.

I'm talking about find_next_bit() not find_next_zero_bit().
