From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 44/76] ARC: ptrace support
Date: Fri, 18 Jan 2013 14:48:14 +0000
Message-ID: <201301181448.15162.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-45-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59405 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab3AROsS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:48:18 -0500
In-Reply-To: <1358511930-7424-45-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/Kconfig         |    1 +
>  arch/arc/kernel/Makefile |    3 +
>  arch/arc/kernel/entry.S  |   69 +++++++++++++++++++++++
>  arch/arc/kernel/ptrace.c |  136 +++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 207 insertions(+), 2 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
