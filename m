Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:54063 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeCGQA6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2018 11:00:58 -0500
Date: Wed, 7 Mar 2018 16:00:50 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: RFC: remove the "tile" architecture from glibc
In-Reply-To: <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1803071557070.28840@digraph.polyomino.org.uk>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com> <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de> <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com> <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
 <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Helmut Grohne <helmutg@debian.org>
Message-ID: <20180307160050.XuhIdzrWYTX5A2iJyHsDv3UmGCiXgnqmUrDMrqePc3U@z>

On Wed, 7 Mar 2018, Arnd Bergmann wrote:

> Do you have any updates on this? A related question has come up
> for the kernel, as are in the process of removing a number of architectures,
> https://lwn.net/SubscriberLink/748074/119aaf0d62b3e6c1/ or
> see https://lwn.net/Articles/748074/ for a nice summary.

No-one has posted glibc test results for 2.27 or 2.26, despite the prior 
claims of interest in keeping the glibc port.  If the kernel port is 
removed, my assumption is that we should remove the glibc port at that 
point (not keep it around for possible use with older kernels).

-- 
Joseph S. Myers
joseph@codesourcery.com
