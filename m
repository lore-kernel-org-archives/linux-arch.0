From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Thu, 19 Aug 2010 15:05:13 +0200
Message-ID: <1282223113.10440.78.camel@thorin>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
	 <87aaoiu6z6.fsf@basil.nowhere.org> <1282222109.10440.50.camel@thorin>
	 <20100819125957.GB6729@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:5198 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab0HSNFU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Aug 2010 09:05:20 -0400
In-Reply-To: <20100819125957.GB6729@basil.fritz.box>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Don, 2010-08-19 at 14:59 +0200, Andi Kleen wrote:
> > If so, the warning seems valid as sizeof(struct page) is probably not
> > (always) a power of 2. On a native build on x86_64 it is 56 bytes
> > hereover.
> > Hmm ....
> 
> gcc just generats a mull with inverted value. mull is cheap on any
> reasonable CPU.  Please fix sparse.

Not that I really know the code of sparse but what would be an
acceptable condition (except plain simply disabling/removing the warning
as such)?
No warning if it's a constant value (read: explicit or sizeof())?

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
