Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:17893 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515AbYDVPQT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 11:16:19 -0400
Received: by py-out-1112.google.com with SMTP id u52so3507897pyb.10
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2008 08:16:19 -0700 (PDT)
Message-ID: <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com>
Date: Tue, 22 Apr 2008 16:16:17 +0100
From: "Will Newton" <will.newton@gmail.com>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
In-Reply-To: <20080422081211.e85989ec.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	 <20080422081211.e85989ec.randy.dunlap@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20080422151617.Tyrhw9OOs-HdmCHbiJBGQLBVgHxbjasE02i7dP4t0IQ@z>

On Tue, Apr 22, 2008 at 4:12 PM, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Tue, 22 Apr 2008 13:13:39 +0100 Will Newton wrote:
>
>  > Hi,
>  >
>  > This patch introduces a __ARCH_WANT_SYS_SYSFS #define for
>  > architectures that support the sysfs(2) system call. At the moment
>  > that's everybody but blackfin, but future architectures may want to
>  > save the (admittedly small) code size that it adds to the kernel as
>  > well.
>  >
>  > (patch attached as well as inline because gmail seems to mangle my whitespace)
>  >
>  > ---
>  > >From d0746366e8ccb5fbaa6c9945540cecbe0c421222 Mon Sep 17 00:00:00 2001
>  > From: Will Newton <will.newton@imgtec.com>
>  > Date: Tue, 22 Apr 2008 12:57:03 +0100
>  > Subject: [PATCH] Introduce __ARCH_WANT_SYS_SYSFS.
>  >
>  > Signed-off-by: Will Newton <will.newton@imgtec.com>
>  >
>  > All arches that want the sysfs(2) system call should define this symbol.
>  > Arches such as blackfin that do not implement the system call don't compile
>  > the code and save some small amount of space.
>
>  Is there any reason that this couldn't (and shouldn't) be done
>  in the Kconfig space and done as documented in
>  Documentation/kbuild/kconfig-language.txt ?

It can be done with Kconfig. Whether it should be or not depends on
your point of view, hence RFC. Currently __ARCH_WANT macros is the way
syscalls are enabled and disabled across architectures. If there's
consensus that it should be done via Kconfig that could certainly be
implmented, but that's a different patch.
