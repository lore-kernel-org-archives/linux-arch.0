From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 06/19] OpenRISC: PTrace
Date: Tue, 5 Jul 2011 17:42:29 +0200
Message-ID: <201107051742.29359.arnd@arndb.de>
References: <1309641352-18714-1-git-send-email-jonas@southpole.se> <1309641352-18714-7-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57782 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab1GEPmb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2011 11:42:31 -0400
In-Reply-To: <1309641352-18714-7-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Saturday 02 July 2011, Jonas Bonn wrote:
> Signed-off-by: Jonas Bonn <jonas@southpole.se>
> ---
>  arch/openrisc/include/asm/ptrace.h |  124 ++++++++
>  arch/openrisc/kernel/ptrace.c      |  574 ++++++++++++++++++++++++++++++++++++
>  arch/openrisc/kernel/ptrace.h      |   37 +++
>  3 files changed, 735 insertions(+), 0 deletions(-)
>  create mode 100644 arch/openrisc/include/asm/ptrace.h
>  create mode 100644 arch/openrisc/kernel/ptrace.c
>  create mode 100644 arch/openrisc/kernel/ptrace.h

This patch still contains a bunch of commented out code that wants to be
cleaned up. I think you have done that in most other patches that needed
the same cleanup.

	Arnd
