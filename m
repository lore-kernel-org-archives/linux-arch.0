From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 16/24] C6X: loadable module support
Date: Mon, 22 Aug 2011 17:14:46 -0400
Message-ID: <1314047687.2404.26.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-17-git-send-email-msalter@redhat.com>
	 <2446000.E5C4Vbv39p@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab1HVVOu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 17:14:50 -0400
In-Reply-To: <2446000.E5C4Vbv39p@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Mon, 2011-08-22 at 23:04 +0200, Arnd Bergmann wrote:
> I have to admit that I don't really understand how the module loader
> works, but I have noticed in the past that all architectures provide
> only one of apply_relocate or apply_relocate_add.
> 
> Do you actually need both?

I will double check, but I believe the answer is yes. Then again, it
could be that the apply_relocate was only needed for the TI compiler.
GCC definitely needs apply_relocate_add.

--Mark
