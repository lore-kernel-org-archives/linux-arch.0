Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43151 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbaDRUtH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Apr 2014 16:49:07 -0400
Message-ID: <53518FAC.8020504@zytor.com>
Date: Fri, 18 Apr 2014 13:48:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
In-Reply-To: <1397824031-4892-1-git-send-email-lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: lftan.linux@gmail.com, cltang@codesourcery.com, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20140418204844.rQPNrC5Nv4CrSAEpZYlCvY-vKLROsnJ8_mHVMOOttJg@z>

On 04/18/2014 05:26 AM, Ley Foon Tan wrote:
> This patchset adds the Linux kernel port for Nios II processor from Altera.
> The nios2 Linux port follows the guidance for new architecture ports using
> generic headers (including unistd.h).

Did the generic headers ever get updated to match Linus' guidance that
any new architecture ports should use a 64-bit time_t?

	-hpa


