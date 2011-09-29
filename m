From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 19/24] C6X: headers
Date: Thu, 29 Sep 2011 16:41:21 +0200
Message-ID: <3471979.HTqjRmXnHP@wuerfel>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <201109281607.11228.arnd@arndb.de> <1317306284.2580.119.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52619 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab1I2OmH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2011 10:42:07 -0400
In-Reply-To: <1317306284.2580.119.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 29 September 2011 10:24:43 Mark Salter wrote:
> I think we still want the c6x unaligned.h because the hardware can do
> unaligned 32 and 64 memory accesses with no performance penalty. There
> are some addressing mode limitations which is why the compiler doesn't
> use them generally.

Ok. I guess you still only need to override __cpu_to_{le,be}{16,32,64}p and
__{le,be}{16,32,64}_to_cpup then and use include/linux/unaligned/access_ok.h.

	Arnd
