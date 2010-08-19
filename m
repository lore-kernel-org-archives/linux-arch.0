From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Thu, 19 Aug 2010 13:03:12 +0100
Message-ID: <5790.1282219392@redhat.com>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42317 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab0HSMDU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Aug 2010 08:03:20 -0400
In-Reply-To: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Namhyung Kim <namhyung@gmail.com>
Cc: dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Namhyung Kim <namhyung@gmail.com> wrote:

> +	if (is_power_of_2(__size))				\
> +		__diff = (__addr1 - __addr2) >> ilog2(__size);	\
> +	else							\
> +		__diff = (__addr1 - __addr2) / __size;		\

You shouldn't need to do this.  The compiler's optimiser should switch a
divide to a shift for a power-of-2 divisor.

David
