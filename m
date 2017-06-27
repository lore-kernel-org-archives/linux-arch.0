From: Daniel Lustig <dlustig@nvidia.com>
Subject: RE: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Tue, 27 Jun 2017 00:07:20 +0000
Message-ID: <8709419e3d964b86b025bb35a6b55440@HQMAIL105.nvidia.com>
References: <20170607131611.GF30263@arm.com>
 <mhng-107d5417-a33b-4b20-96cb-6adead7c3130@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8542 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdF0AHX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2017 20:07:23 -0400
In-Reply-To: <mhng-107d5417-a33b-4b20-96cb-6adead7c3130@palmer-si-x1c4>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "albert@sifive.com" <albert@sifive.com>, "patches@groups.riscv.org" <patches@groups.riscv.org>

> > https://github.com/riscv/riscv-isa-manual/releases/download/riscv-user
> > -2.2/riscv-spec-v2.2.pdf
> 
> That's the most up to date spec.

Yes, that's the most up to date public spec.  Internally, the RISC-V memory
model task group has been working on fixing the memory model spec for the
past couple of months now.  We're aiming to release it for public review
well before the end of the year.  Hopefully in the coming weeks even.

> > which, on the one hand is reassuring (because ignoring dependency
> > ordering is plain broken), but on the other it doesn't go quite far
> > enough in defining exactly what constitutes a "syntactic data
> > dependency". The cumulativity of your fences also needs defining,
> > because I think this was up in the air at some point and the document
> > above doesn't seem to tackle it (it doesn't seem to describe what
> > constitutes being a memory of the predecessor or successor sets)

That will all covered in the new spec.

> > P.S. You should also totally get your architects to write a formal
> > model ;)

Also in progress :)

Were there any more specific questions I can answer in the meantime?  Or
any specific concern you'd like to point me to?

Dan
