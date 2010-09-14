From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [RFC PATCH 0/5] Bump gcc minimum version to 3.4, 4.1 for x86
Date: Mon, 13 Sep 2010 20:11:53 -0400
Message-ID: <AANLkTi=JpfhvyxC13U98x5me9U8dU6BHOcGkPC0KK7aW@mail.gmail.com>
References: <1284408880-14414-1-git-send-email-hpa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44256 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab0INALz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2010 20:11:55 -0400
In-Reply-To: <1284408880-14414-1-git-send-email-hpa@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Sep 13, 2010 at 4:14 PM, H. Peter Anvin <hpa@linux.intel.com> w=
rote:
> This patchset bumps the minimum supported gcc version to 3.4 for the
> general kernel, and to 4.1 for x86.
>
> We have had a rash of bug reports related to these really old
> compilers and their associated binutils version lately, and it is
> clear that the support burden of these older compilers is getting to
> be excessive. =C2=A0If you really want to build a kernel on a system =
that
> old you can build or obtain an updated gcc/binutils as well.

What version of binutils does this correspond to?  It would be nice to
clean up some of the hacks for ancient binutils as well.

--
Brian Gerst
