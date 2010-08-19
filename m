From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Thu, 19 Aug 2010 14:59:57 +0200
Message-ID: <20100819125957.GB6729@basil.fritz.box>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
 <87aaoiu6z6.fsf@basil.nowhere.org>
 <1282222109.10440.50.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34047 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab0HSM77 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Aug 2010 08:59:59 -0400
Content-Disposition: inline
In-Reply-To: <1282222109.10440.50.camel@thorin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: Andi Kleen <andi@firstfloor.org>, Namhyung Kim <namhyung@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

> If so, the warning seems valid as sizeof(struct page) is probably not
> (always) a power of 2. On a native build on x86_64 it is 56 bytes
> hereover.
> Hmm ....


gcc just generats a mull with inverted value. mull is cheap on any
reasonable CPU.  Please fix sparse.

-andi
