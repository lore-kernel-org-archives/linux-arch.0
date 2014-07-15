From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 27/29] MAINTAINERS: Add nios2 maintainer
Date: Tue, 15 Jul 2014 04:10:15 -0700
Message-ID: <1405422615.14773.1.camel@joe-AO725>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	 <1405413956-2772-28-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:36112 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758752AbaGOLKV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Jul 2014 07:10:21 -0400
In-Reply-To: <1405413956-2772-28-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

On Tue, 2014-07-15 at 16:45 +0800, Ley Foon Tan wrote:
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

trivia:

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -6350,6 +6350,13 @@ S:	Maintained
[]
> +NIOS2 ARCHITECTURE
> +M:	Ley Foon Tan <lftan@altera.com>
> +L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
> +T:	git://git.rocketboards.org/linux-socfpga.git

this should be:
T:	git git://git.rocketboards.org/linux-socfpga.git
