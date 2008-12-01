From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH-mm 4/7] sh: wire up arch overrides for unaligned access on the SH4a
Date: Mon, 1 Dec 2008 15:51:23 +0900
Message-ID: <20081201065123.GB30438@linux-sh.org>
References: <1228012830.26141.1029.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:40035 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750709AbYLAGwx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Dec 2008 01:52:53 -0500
Content-Disposition: inline
In-Reply-To: <1228012830.26141.1029.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Sat, Nov 29, 2008 at 06:40:30PM -0800, Harvey Harrison wrote:
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  arch/sh/include/asm/unaligned-sh4a.h |  258 ----------------------------------
>  arch/sh/include/asm/unaligned.h      |   76 ++++++++--
>  2 files changed, 61 insertions(+), 273 deletions(-)
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>

Thanks for looking at this!
