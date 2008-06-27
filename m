From: "John Williams" <john.williams@petalogix.com>
Subject: Re: Microblaze init port v4
Date: Fri, 27 Jun 2008 10:12:07 +1000
Message-ID: <1d3f23370806261712s5251253cs5f9c8d6614184bae@mail.gmail.com>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	 <20080626150121.GB22025@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.234]:59143 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYF0AMJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 20:12:09 -0400
Received: by hu-out-0506.google.com with SMTP id 28so594454hub.21
        for <linux-arch@vger.kernel.org>; Thu, 26 Jun 2008 17:12:08 -0700 (PDT)
In-Reply-To: <20080626150121.GB22025@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: monstr@seznam.cz, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com

Hi,

On 6/27/08, Adrian Bunk <bunk@kernel.org> wrote:
> On Thu, Jun 26, 2008 at 02:29:29PM +0200, monstr@seznam.cz wrote:

>  > current linux version is 2.6.26-rc8 and I think this is the right time
>  > to send latest patches againts rc8 for Microblaze CPU.
>  >...
>
>  Thanks for your work on getting the architecture included.
>
>  I have two questions:
>
>  Where can I find a toolchain for compiling a Microblaze kernel?

We bundle it in the PetaLinux distro:

http://developer.petalogix.com

>  What is the status of Microblaze support in upstream binutils and gcc?

noMMU uClibc toolchain is at 3.4.1, MMU/glibc is at 4.1.1  Xilinx does
their gcc/binutils stuff mostly in-house, and none of it is upstream.
We (PetaLogix) build and distribute the uClibc toolchain, and we are
slowly merging the MMU support across to our regular distro, that will
also include the glibc tools.

Cheers,

John
-- 
John Williams, PhD, B.Eng, B.IT
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663
