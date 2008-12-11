From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/19] mips: convert to generic init_task.c
Date: Thu, 11 Dec 2008 14:04:25 +0100
Message-ID: <200812111404.25597.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <c89dc10c8a51d3f0f014dcdd86b70ef253b22710.1228966585.git.kyle@mcmartin.ca> <e7880c938229e333f2c0dbe34eee62257c159a5e.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:58228 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbYLKNFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 08:05:07 -0500
In-Reply-To: <e7880c938229e333f2c0dbe34eee62257c159a5e.1228966585.git.kyle@mcmartin.ca>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, ralf@linux-mips.org, Kyle McMartin <kyle@redhat.com>

On Thursday 11 December 2008, Kyle McMartin wrote:
> - */
> -union thread_union init_thread_union
> -=A0=A0=A0=A0=A0=A0=A0__attribute__((__section__(".data.init_task"),
> -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __aligned__(THREAD=
_SIZE))) =3D
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0{ INIT_THREAD_INFO(init=
_task) };
> -

The __aligned__(THREAD_SIZE) is only present in sparc, mips and
parisc (though the latter uses 128 byte align). I guess you
verified that dropping it is ok for parisc, but is that also
true for mips and sparc?

	Arnd <><
