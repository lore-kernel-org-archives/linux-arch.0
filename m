From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Mon, 27 May 2013 18:23:06 +0200
Message-ID: <20130527182306.3bd8a252@thinkpad>
References: <51A2CC07.5010100@asianux.com>
	<CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com>
	<51A32D81.2010105@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:32805 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab3E0QXO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2013 12:23:14 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
	Mon, 27 May 2013 17:18:40 +0100
In-Reply-To: <51A32D81.2010105@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

On Mon, 27 May 2013 17:55:13 +0800
Chen Gang <gang.chen@asianux.com> wrote:

> 
> 'buf[2]' is 2 bytes length, and sprintf() will append '\0' at the end
> of string "?\n", so original implementation is memory overflow.
> 
> Need use strncpy() and strnlen() instead of sprintf().
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Applied, thanks.
