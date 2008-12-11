From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/19] blackfin: convert to generic init_task.c
Date: Thu, 11 Dec 2008 13:55:44 +0100
Message-ID: <200812111355.45403.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <9a5b7775c30315d101d24b7979d43e8018d83bfd.1228966585.git.kyle@mcmartin.ca> <03f8f28b93a00552becc1acff88cda27b158c9ee.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52498 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYLKM4I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 07:56:08 -0500
In-Reply-To: <03f8f28b93a00552becc1acff88cda27b158c9ee.1228966585.git.kyle@mcmartin.ca>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, cooloney@kernel.org, Kyle McMartin <kyle@redhat.com>

On Thursday 11 December 2008, Kyle McMartin wrote:

> -union thread_union init_thread_union
> - =A0 =A0__attribute__ ((__section__(".init_task.data"))) =3D {
> -INIT_THREAD_INFO(init_task)};

Did you notice that this is init_task.data, not data.init_task?
The blackfin vmlinux.lds.S file references data.* sections
together, so this appears broken to me with your patch.

	Arnd <><
