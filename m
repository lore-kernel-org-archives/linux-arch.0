Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55265 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab1C2L7K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2011 07:59:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Warning with asm-generic/div64.h
Date: Tue, 29 Mar 2011 13:58:56 +0200
References: <007801cbead6$1984b6e0$4c8e24a0$@mprc.pku.edu.cn> <201103251439.53568.arnd@arndb.de> <018a01cbee06$534730a0$f9d591e0$@mprc.pku.edu.cn>
In-Reply-To: <018a01cbee06$534730a0$f9d591e0$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201103291358.56758.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, 'Pavel Machek' <pavel@ucw.cz>, "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Message-ID: <20110329115856.JzJlHI18u7lCj71hxOlzqPQucY9Wokd46BHJ7K8cPtQ@z>

On Tuesday 29 March 2011, Guan Xuetao wrote:
> > The macro doesn't work for signed input or for 32 bit input. I'd suggest
> > fixing the caller to use an unsigned type.
> 
> Then,
> Cc: Len Brown <len.brown@intel.com> (supporter:SUSPEND TO RAM)
> Cc: Pavel Machek <pavel@ucw.cz> (supporter:SUSPEND TO RAM)
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl> (supporter:SUSPEND TO RAM)
> Cc: linux-pm@lists.linux-foundation.org (open list:SUSPEND TO RAM)

Yes, that sounds right.

	Arnd
